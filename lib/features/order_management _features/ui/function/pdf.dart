import 'dart:io';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart';

String? share;

class Pdf {
  static Future<pw.Document> generateCenteredText(
      String text, int parcels) async {
    final pdf = pw.Document();
    for (int i = 0; i < parcels; i++) {
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
    // await Printing.layoutPdf(
    //   onLayout: (PdfPageFormat format) async => pdf.save(),
    // );
    return pdf; // Return the generated PDF document
  }

  static Future<File> saveDocument({
    required String name,
    required pw.Document pdf,
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
