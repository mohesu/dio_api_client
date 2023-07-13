/// * [AppError] is a class that represents an error in the API.
///
class AppError implements Exception {
  final String message;
  final int code;
  StackTrace? stackTrace;

  AppError({
    this.message = "Something went wrong 😑 !!",
    this.code = 404,
  });

  factory AppError.fromJson(Map<String, dynamic> map) {
    return AppError(
      message: map['message'] ?? "Something went wrong 😑 !!",
      code: map['code'] ?? 404,
    );
  }

  AppError copyWith({
    String? message,
    int? code,
  }) {
    return AppError(
      message: message ?? this.message,
      code: code ?? this.code,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "code": code,
    };
  }

  @override
  String toString() {
    return "Message: $message \nCode: $code";
  }
}
