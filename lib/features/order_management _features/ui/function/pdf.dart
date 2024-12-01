import 'dart:io';
import 'package:barcode_widget/barcode_widget.dart';
import 'package:dartz/dartz.dart' as dartz;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';
import 'package:printing/printing.dart';

String? share;

class Pdf {
  static Future<File> generateCenteredText(String text, int? parcels) async {
    final pdf = pw.Document();
    for (int i = 0; i < parcels!; i++) {
      pdf.addPage(
        pw.Page(
          build: (pw.Context context) {
            return pw.Center(
              child: pw.BarcodeWidget(
                height: 70.h,
                width: 200.w,
                data: text,
                textPadding: 8,
                barcode: Barcode.code128(),
              ),
            );
          },
        ),
      );
    }

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );

    return saveDocument(name: 'icode.pdf', pdf: pdf);
  }

  static Future<File> saveDocument({
    required String name,
    required Document pdf,
  }) async {
    final bytes = await pdf.save();

    final dir = await getApplicationDocumentsDirectory();
    final file = File('${dir.path}/$name');

    await file.writeAsBytes(bytes);

    return file;
  }

  static Future openFile(File file) async {
    final url = file.path;
    share = url;

    await OpenFile.open(url);
  }
}
