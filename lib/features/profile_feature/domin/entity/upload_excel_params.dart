/// Parameters for uploading an Excel file
class UploadExcelParams {
  final String filePath;
  final String action;
  final String? storeId;
  final bool? isOfficial;

  UploadExcelParams({
    required this.filePath,
    required this.action,
    this.storeId,
    this.isOfficial,
  });
}
