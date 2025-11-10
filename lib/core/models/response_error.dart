class ResponseError {
  final String message;
  final Map<String, String>? validationErrors;

  ResponseError({
    required this.message,
    required this.validationErrors,
  });

  factory ResponseError.fromJson(Map<String, dynamic> json) {
    Map<String, String> extractedErrors = {};

    if (json["data"] != null && json["data"] is Map) {
      json["data"].forEach((key, value) {
        if (value is List && value.isNotEmpty) {
          extractedErrors[key] = value[0]; // first validation message
        }
      });
    }

    return ResponseError(
      message: json["message"] ?? "Unknown error",
      validationErrors: extractedErrors,
    );
  }
}
