class FileModel {
  final int? intField;
  final String strField;
  final int? errType;
  final String strTField;

  FileModel({
    this.intField,
    required this.strField,
    this.errType,
    required this.strTField,
  });

  // Factory constructor to create an instance from JSON
  factory FileModel.fromJson(Map<String, dynamic> json) {
    return FileModel(
      intField: json['intField'] as int?,
      strField: json['strField'] as String? ?? '',
      errType: json['errType'] as int?,
      strTField: json['strTField'] as String? ?? '',
    );
  }

  // Method to convert instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'intField': intField,
      'strField': strField,
      'errType': errType,
      'strTField': strTField,
    };
  }
}
