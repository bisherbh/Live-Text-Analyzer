import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/injection.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/entities/text_stats.dart';
import '../cubit/text_analyzer_cubit.dart';
import '../cubit/text_analyzer_state.dart';
import '../widgets/stats_panel.dart';
import '../widgets/text_input_field.dart';
import '../widgets/top_words_widget.dart';

class TextAnalyzerPage extends StatelessWidget {
  const TextAnalyzerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<TextAnalyzerCubit>(),
      child: const _TextAnalyzerView(),
    );
  }
}

class _TextAnalyzerView extends StatefulWidget {
  const _TextAnalyzerView();

  @override
  State<_TextAnalyzerView> createState() => _TextAnalyzerViewState();
}

class _TextAnalyzerViewState extends State<_TextAnalyzerView> {
  late final TextEditingController _controller;
  bool _excludeStopWords = true;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        surfaceTintColor: Colors.transparent,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.analytics_outlined,
                color: AppTheme.primaryColor,
              ),
            ),
            const SizedBox(width: 12),
            const Text('Live Text Analyzer'),
          ],
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.bug_report_outlined),
            tooltip: 'Simulate Isolate Failure',
            onPressed: () {
              context.read<TextAnalyzerCubit>().simulateIsolateFailure();
            },
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextInputField(
                controller: _controller,
                onChanged: (text) {
                  context.read<TextAnalyzerCubit>().onTextChanged(text);
                },
              ),
              const SizedBox(height: 24),
              SwitchListTile.adaptive(
                contentPadding: EdgeInsets.zero,
                title: const Text('Exclude common stop words'),
                subtitle: const Text(
                  'Remove stop words from the most frequent words',
                ),
                value: _excludeStopWords,
                onChanged: (excludeStopWords) {
                  setState(() {
                    _excludeStopWords = excludeStopWords;
                  });
                  context.read<TextAnalyzerCubit>().setExcludeStopWords(
                    excludeStopWords,
                  );
                },
              ),
              const SizedBox(height: 24),
              BlocConsumer<TextAnalyzerCubit, TextAnalyzerState>(
                listener: (context, state) {
                  state.maybeWhen(
                    failure: (message) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(message),
                          backgroundColor: AppTheme.errorColor,
                          behavior: SnackBarBehavior.floating,
                        ),
                      );
                    },
                    orElse: () {},
                  );
                },
                builder: (context, state) {
                  final stats = state.maybeWhen(
                    success: (s) => s,
                    orElse: () => TextStats.empty(),
                  );

                  final isLoading = state.maybeWhen(
                    loading: () => true,
                    orElse: () => false,
                  );

                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Analysis Overview',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.textPrimaryColor,
                            ),
                          ),
                          if (isLoading)
                            const SizedBox(
                              width: 18,
                              height: 18,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  AppTheme.primaryColor,
                                ),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      StatsPanel(stats: stats),
                      const SizedBox(height: 20),
                      TopWordsWidget(topWords: stats.topWords),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
