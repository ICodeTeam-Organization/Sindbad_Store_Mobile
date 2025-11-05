class ResponseModel {
  final bool success;
  final String message;
  final String? data;

  ResponseModel({
    required this.success,
    required this.message,
    required this.data,
  });

  factory ResponseModel.fromJson(
    Map<String, dynamic> json,
  ) {
    return ResponseModel(
        success: json['success'] ?? false,
        message: json['message'] ?? '',
        data: json['data'] ?? json['data']);
  }
}
