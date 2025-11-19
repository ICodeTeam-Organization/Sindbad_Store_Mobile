import 'dart:io';

import 'package:flutter/material.dart';

class AddExcelPage extends StatefulWidget {
  const AddExcelPage({Key? key}) : super(key: key);

  @override
  State<AddExcelPage> createState() => _AddExcelPageState();
}

class _AddExcelPageState extends State<AddExcelPage> {
  final List<String> productOperations = [
    'استيراد',
    'تصدير',
    'حذف',
    'عرض'
  ]; // أمثلة لخيارات عمليات المنتجات
  final List<String> addEditOptions = ['اضافة', 'تعديل'];

  String? selectedOperation;
  String? selectedAddEdit;
  PlatformFile? pickedFile;
  bool processing = false;

  // رابط نموذجي لتنزيل القالب - عدله إلى رابطك الفعلي
  final Uri templateUrl = Uri.parse('https://example.com/template.xlsx');

  Future<void> _downloadTemplate() async {
    // if (!await launchUrl(templateUrl, mode: LaunchMode.externalApplication)) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //     const SnackBar(content: Text('فشل فتح رابط التحميل')),
    //   );
    // }
  }

  Future<void> _pickExcelFile() async {
    // final result = await FilePicker.platform.pickFiles(
    //   type: FileType.custom,
    //   allowedExtensions: ['xlsx', 'xls'],
    // );
    // if (result != null && result.files.isNotEmpty) {
    //   setState(() {
    //     pickedFile = result.files.first;
    //   });
    // }
  }

  Future<void> _uploadAndExecute() async {
    if (pickedFile == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر ملف اكسل أولاً')),
      );
      return;
    }
    if (selectedOperation == null || selectedAddEdit == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر خياري القائمتين أولاً')),
      );
      return;
    }

    setState(() {
      processing = true;
    });

    // محاكاة رفع ومعالجة الملف. هنا تضع منطق الرفع والمعالجة الفعلي (API call، قراءة الملف، ...)
    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      processing = false;
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تم رفع الملف وتنفيذه: pickedFile!.name}')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('اضافة منتجات عبر الإكسيل'),
          centerTitle: true,
          backgroundColor: Colors.blueGrey,
        ),
        body: Container(
          color: const Color(0xFFEEEEEE), // خلفية رمادية eee
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // بطاقة المحتوى
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        // القائمة الأولى
                        DropdownButtonFormField<String>(
                          value: selectedOperation,
                          decoration: const InputDecoration(
                            labelText: 'عمليات المنتجات',
                            border: OutlineInputBorder(),
                          ),
                          items: productOperations
                              .map(
                                (op) => DropdownMenuItem(
                                  value: op,
                                  child: Text(op),
                                ),
                              )
                              .toList(),
                          onChanged: (v) =>
                              setState(() => selectedOperation = v),
                        ),
                        const SizedBox(height: 12),

                        // القائمة الثانية
                        DropdownButtonFormField<String>(
                          value: selectedAddEdit,
                          decoration: const InputDecoration(
                            labelText: 'اضافة تعديل',
                            border: OutlineInputBorder(),
                          ),
                          items: addEditOptions
                              .map(
                                (op) => DropdownMenuItem(
                                  value: op,
                                  child: Text(op),
                                ),
                              )
                              .toList(),
                          onChanged: (v) => setState(() => selectedAddEdit = v),
                        ),
                        const SizedBox(height: 18),

                        // زر تنزيل القالب
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: const Icon(Icons.download),
                            label: const Text('تحميل نموذج اضافة تعديل منتجات'),
                            onPressed: _downloadTemplate,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // زر اختيار ملف من الجهاز
                        SizedBox(
                          width: double.infinity,
                          child: OutlinedButton.icon(
                            icon: const Icon(Icons.upload_file),
                            label: Text(
                              pickedFile == null
                                  ? 'اختر ملف الاكسيل من الجهاز'
                                  : 'ملف مختار:pickedFile!.name}',
                            ),
                            onPressed: _pickExcelFile,
                          ),
                        ),
                        const SizedBox(height: 12),

                        // زر رفع وتنفيذ الملف
                        SizedBox(
                          width: double.infinity,
                          child: ElevatedButton.icon(
                            icon: processing
                                ? const SizedBox(
                                    width: 18,
                                    height: 18,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2,
                                      color: Colors.white,
                                    ),
                                  )
                                : const Icon(Icons.play_arrow),
                            label: const Text('رفع وتنفيذ الملف'),
                            onPressed: processing ? null : _uploadAndExecute,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                // تلميحات أو ملاحظات
                Text(
                  'ملاحظة: اضغط على "تحميل نموذج اضافة تعديل منتجات" لتنزيل قالب الاكسيل، ثم اختر الملف من جهازك واضغط "رفع وتنفيذ الملف" لتنفيذ العملية.',
                  style: TextStyle(color: Colors.grey[700]),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class PlatformFile {}
