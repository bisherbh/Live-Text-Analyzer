class TextAnalysisRequest {
  final String text;
  final int requestId;
  final bool excludeStopWords;

  const TextAnalysisRequest({
    required this.text,
    required this.requestId,
    this.excludeStopWords = true,
  });
}
