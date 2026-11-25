import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TextInputField extends StatefulWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TextInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

  @override
  State<TextInputField> createState() => _TextInputFieldState();
}

class _TextInputFieldState extends State<TextInputField> {
  late final ScrollController _scrollController;
  bool _showScrollToTop = false;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController()..addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    final showScrollToTop =
        _scrollController.hasClients && _scrollController.offset > 0;
    if (_showScrollToTop != showScrollToTop) {
      setState(() {
        _showScrollToTop = showScrollToTop;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Input Text',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppTheme.textPrimaryColor,
              ),
            ),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (_showScrollToTop)
                  IconButton(
                    tooltip: 'Scroll to beginning',
                    onPressed: () {
                      _scrollController.animateTo(
                        0,
                        duration: const Duration(milliseconds: 250),
                        curve: Curves.easeOut,
                      );
                    },
                    icon: const Icon(Icons.vertical_align_top),
                  ),
                if (widget.controller.text.isNotEmpty)
                  TextButton.icon(
                    onPressed: () {
                      widget.controller.clear();
                      widget.onChanged('');
                      setState(() {});
                    },
                    icon: const Icon(Icons.clear, size: 18),
                    label: const Text('Clear'),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.textSecondaryColor,
                    ),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: widget.controller,
          scrollController: _scrollController,
          onChanged: (text) {
            widget.onChanged(text);
            setState(() {});
          },
          maxLines: 8,
          minLines: 8,
          keyboardType: TextInputType.multiline,
          style: const TextStyle(
            fontSize: 15,
            color: AppTheme.textPrimaryColor,
            height: 1.5,
          ),
          decoration: const InputDecoration(
            hintText: 'Type or paste your text here to analyze in real time...',
            alignLabelWithHint: true,
          ),
        ),
      ],
    );
  }
}
