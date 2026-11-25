import 'package:flutter/material.dart';

import '../../../../core/theme/app_theme.dart';

class TextInputField extends StatelessWidget {
  final TextEditingController controller;
  final ValueChanged<String> onChanged;

  const TextInputField({
    super.key,
    required this.controller,
    required this.onChanged,
  });

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
            if (controller.text.isNotEmpty)
              TextButton.icon(
                onPressed: () {
                  controller.clear();
                  onChanged('');
                },
                icon: const Icon(Icons.clear_all, size: 18),
                label: const Text('Clear'),
                style: TextButton.styleFrom(
                  foregroundColor: AppTheme.textSecondaryColor,
                ),
              ),
          ],
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          onChanged: onChanged,
          maxLines: null,
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
