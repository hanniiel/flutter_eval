class Response<T> {
  final String message;
  final int? code;
  final T? data;

  Response({
    this.data,
    this.code,
    required this.message,
  });

  Response copyWith({
    String? message,
    int? code,
    T? data,
  }) =>
      Response(
        message: message ?? this.message,
        code: code ?? this.code,
        data: data ?? this.data,
      );
}
