class ApiResponse<T> {
  final int code;
  final String message;
  final T? data;
  ApiResponse({required this.code, required this.message, this.data});

  factory ApiResponse.fromJson(Map<String, dynamic> json, T Function(Object? json)? fromT) {
    final rawData = json["data"];
    return ApiResponse(code: json["code"], message: json["message"],data: rawData != null ? fromT?.call(rawData) :null);
  }
}
