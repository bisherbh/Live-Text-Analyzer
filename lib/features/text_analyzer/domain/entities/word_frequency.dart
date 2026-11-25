import 'package:equatable/equatable.dart';

class WordFrequency extends Equatable {
  final String word;
  final int count;

  const WordFrequency({
    required this.word,
    required this.count,
  });

  @override
  List<Object?> get props => [word, count];
}
