import 'package:flutter/material.dart';

import '../../domain/entities/text_stats.dart';
import 'stat_card.dart';

class StatsPanel extends StatelessWidget {
  final TextStats stats;

  const StatsPanel({
    super.key,
    required this.stats,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isMobile = constraints.maxWidth < 600;

        if (isMobile) {
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: StatCard(
                      label: 'Words',
                      value: stats.wordCount,
                      icon: Icons.title,
                      color: const Color(0xFF2563EB),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: StatCard(
                      label: 'Letters',
                      value: stats.letterCount,
                      icon: Icons.sort_by_alpha,
                      color: const Color(0xFF10B981),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              StatCard(
                label: 'Whitespace',
                value: stats.whitespaceCount,
                icon: Icons.space_bar,
                color: const Color(0xFF8B5CF6),
              ),
            ],
          );
        }

        return Row(
          children: [
            Expanded(
              child: StatCard(
                label: 'Words',
                value: stats.wordCount,
                icon: Icons.title,
                color: const Color(0xFF2563EB),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                label: 'Letters',
                value: stats.letterCount,
                icon: Icons.sort_by_alpha,
                color: const Color(0xFF10B981),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: StatCard(
                label: 'Whitespace',
                value: stats.whitespaceCount,
                icon: Icons.space_bar,
                color: const Color(0xFF8B5CF6),
              ),
            ),
          ],
        );
      },
    );
  }
}
