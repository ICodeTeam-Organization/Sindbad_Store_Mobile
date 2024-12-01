import 'dart:io';

class Data {
  int? id;
  dynamic invoiceNumber;
  int? invoiceAmount;
  File? invoiceImageUrl;
  DateTime? date;

  Data({
    this.id,
    this.invoiceNumber,
    this.invoiceAmount,
    this.invoiceImageUrl,
    this.date,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json['id'] as int?,
        invoiceNumber: json['invoiceNumber'] as dynamic,
        invoiceAmount: json['invoiceAmount'] as int?,
        invoiceImageUrl: json['invoiceImageUrl'] as File?,
        date: json['date'] as DateTime?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'invoiceNumber': invoiceNumber,
        'invoiceAmount': invoiceAmount,
        'invoiceImageUrl': invoiceImageUrl,
        'date': date,
      };
}
