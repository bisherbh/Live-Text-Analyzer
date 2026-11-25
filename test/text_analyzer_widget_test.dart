import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:syncrow_text_analyzer/core/di/injection.dart';
import 'package:syncrow_text_analyzer/features/text_analyzer/presentation/pages/text_analyzer_page.dart';
import 'package:syncrow_text_analyzer/features/text_analyzer/presentation/widgets/text_input_field.dart';

void main() {
  setUpAll(() async {
    await configureDependencies();
  });

  testWidgets('TextAnalyzerPage renders input field and stats panel', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: TextAnalyzerPage(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Live Text Analyzer'), findsOneWidget);
    expect(find.byType(TextInputField), findsOneWidget);
    expect(find.text('Analysis Overview'), findsOneWidget);
    expect(find.text('Words'), findsOneWidget);
    expect(find.text('Letters'), findsOneWidget);
    expect(find.text('Whitespace'), findsOneWidget);
  });
}
