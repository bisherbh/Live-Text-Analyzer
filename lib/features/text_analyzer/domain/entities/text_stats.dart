import 'package:equatable/equatable.dart';
import 'word_frequency.dart';

class TextStats extends Equatable {
  final int wordCount;
  final int letterCount;
  final int whitespaceCount;
  final List<WordFrequency> topWords;

  const TextStats({
    required this.wordCount,
    required this.letterCount,
    required this.whitespaceCount,
    required this.topWords,
  });

  factory TextStats.empty() {
    return const TextStats(
      wordCount: 0,
      letterCount: 0,
      whitespaceCount: 0,
      topWords: [],
    );
  }

  @override
  List<Object?> get props => [wordCount, letterCount, whitespaceCount, topWords];
}
