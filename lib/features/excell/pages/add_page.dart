import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/excell/pages/manager/excell_operationclass.dart';

class AddExcelPage extends StatefulWidget {
  const AddExcelPage({super.key});

  @override
  State<AddExcelPage> createState() => _AddExcelPageState();
}

class _AddExcelPageState extends State<AddExcelPage> {
  final List<ExcellOperation> operation = [
    ExcellOperation(operationName: "أضافة", operations: [
      Operation(
          name: "اضافة / تعديل منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لإضافة أو تعديل المنتجات عبر ملف إكسل، يتم تعبئة ملف الإكسل حسب النموذج (يمكن تحميل نموذج أي عملية من خلال الرابط الذي يظهر) يجب وجود الحقول الأساسية للمنتج وهي الرقم، الاسم، السعر، الصورة ويجب أن تكون البيانات صحيحة وإلا سيتم رفض الملف. يعطي النظام الملاحظات على الملف مع رقم السطر. يمكن إضافة آلاف المنتجات في ملف الإكسل وسيتم إضافتها دفعة واحدة."),
      Operation(
          name: "تحديث اسعار منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لتحديث أسعار المنتجات الموجودة في النظام. يحتاج الملف إلى عمودين: رقم المنتج والسعر الجديد."),
      Operation(
          name: "ايقاف منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لايقاف منتجات معينة مؤقتاً عن الظهور في التطبيق. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "تفعيل منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لتفعيل منتجات كانت موقفة سابقاً. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "اضافة / تعديل عروض منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لإضافة أو تعديل عروض المنتجات. يحتاج الملف إلى أعمدة: رقم المنتج، اسم المنتج، السعر، تاريخ بداية العرض، تاريخ نهاية العرض."),
      Operation(
          name: "ايقاف عروض منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لايقاف عروض منتجات معينة. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "تفعيل عروض منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لتفعيل عروض منتجات كانت موقفة. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "تعديل تاريخ عروض منتجات",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لتعديل تواريخ العروض للمنتجات. يحتاج الملف إلى أعمدة: رقم المنتج، تاريخ بداية العرض، تاريخ نهاية العرض."),
    ]),
    ExcellOperation(operationName: "عمليات الفئات", operations: [
      Operation(
          name: "اعادة الاسماء المقترحة لفئات مورد",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "يتم رفع فئات المورد بالأسماء. يمكن كتابة الفئات على شكل شجرة بحيث يفصل بين الفئة والفئة الفرعية بالرمز >. بعد رفع الفئات يقوم النظام بمقارنة الأسماء بشجرة فئات سندباد، يتم إعطاء الملاحظات والاقتراحات عبر إعادة ملف الإكسل بتفاصيل أكثر."),
      Operation(
          name: "تسجيل فئات مورد - الفئات المعتمدة",
          downloadExcellLink: "https://example.com/template.xlsx",
          note:
              "لتسجيل فئات المورد المعتمدة بعد المراجعة. يجب أن يحتوي الملف على أعمدة: اسم الفئة، الفئة الرئيسية، وكود الفئة في سندباد."),
      Operation(
          name: "تحميل شجرة فئات سندباد",
          downloadExcellLink: "https://example.com/template.xlsx",
          note: "لا يوجد شرح متوفر لهذه العملية."),
      Operation(
          name: "اضافة فئات ادارية",
          downloadExcellLink: "https://example.com/template.xlsx",
          note: "لا يوجد شرح متوفر لهذه العملية."),
    ]),
    ExcellOperation(operationName: "ادوات مساعده", operations: [
      Operation(
          name: "جلب صور من النت",
          downloadExcellLink: "https://example.com/template.xlsx",
          note: "لا يوجد شرح متوفر لهذه العملية."),
      Operation(
          name: "اختيار صورة",
          downloadExcellLink: "https://example.com/template.xlsx",
          note: "لا يوجد شرح متوفر لهذه العملية."),
      Operation(
          name: "اختيار عدة صور",
          downloadExcellLink: "https://example.com/template.xlsx",
          note: "لا يوجد شرح متوفر لهذه العملية."),
      Operation(
          name: "تجميع روابط الصور",
          downloadExcellLink: "https://example.com/template.xlsx",
          note: "لا يوجد شرح متوفر لهذه العملية."),
    ])
  ];

  ExcellOperation? selectedOperationGroup;
  Operation? selectedOperation;
  bool processing = false;

  Future<void> _downloadTemplate() async {
    // Download logic here
  }

  Future<void> _pickExcelFile() async {
    // File picker logic here
  }

  Future<void> _uploadAndExecute() async {
    if (selectedOperation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر العملية أولاً')),
      );
      return;
    }

    setState(() {
      processing = true;
    });

    await Future.delayed(const Duration(seconds: 2));

    setState(() {
      processing = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'اضافة منتجات عبر الإكسيل',
            style: TextStyle(
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          foregroundColor: Colors.black,
        ),
        body: Container(
          color: const Color(0xFFF7F7F7),
          padding: const EdgeInsets.all(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Card(
                  color: Colors.white,
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Column(
                      children: [
                        const Align(
                          alignment: Alignment.centerRight,
                          child: Text(
                            "اختر نوع العملية :",
                            style: TextStyle(
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w700,
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        // First Dropdown
                        DropdownButtonFormField<ExcellOperation>(
                          value: selectedOperationGroup,
                          decoration: const InputDecoration(
                            labelText: 'عمليات المنتجات',
                            border: OutlineInputBorder(),
                          ),
                          items: operation
                              .map(
                                (op) => DropdownMenuItem<ExcellOperation>(
                                  value: op,
                                  child: Text(op.operationName),
                                ),
                              )
                              .toList(),
                          onChanged: (v) {
                            setState(() {
                              selectedOperationGroup = v;
                              selectedOperation = null; // reset second dropdown
                            });
                          },
                        ),
                        const SizedBox(height: 12),
                        // Second Dropdown (depends on first)
                        DropdownButtonFormField<Operation>(
                          value: selectedOperation,
                          decoration: const InputDecoration(
                            labelText: 'اضافة / تعديل',
                            border: OutlineInputBorder(),
                          ),
                          items: selectedOperationGroup?.operations
                                  .map(
                                    (op) => DropdownMenuItem<Operation>(
                                      value: op,
                                      child: Text(op.name),
                                    ),
                                  )
                                  .toList() ??
                              [],
                          onChanged: (v) {
                            setState(() {
                              selectedOperation = v;
                            });
                          },
                        ),
                        const SizedBox(height: 18),
                        // Download Template Button
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 84,
                            maxWidth: 480,
                          ),
                          child: SizedBox(
                            width: 326,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _downloadTemplate,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF093456),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.download,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      'تحميل نموذج اضافة تعديل منتجات',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 12),
                        // Upload & Execute Button
                        ConstrainedBox(
                          constraints: const BoxConstraints(
                            minWidth: 84,
                            maxWidth: 480,
                          ),
                          child: SizedBox(
                            width: 326,
                            height: 48,
                            child: ElevatedButton(
                              onPressed: _uploadAndExecute,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFFF746B),
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.max,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  const Icon(
                                    Icons.upload_file,
                                    color: Colors.white,
                                  ),
                                  const SizedBox(width: 8),
                                  Flexible(
                                    child: Text(
                                      processing
                                          ? 'جارٍ التنفيذ...'
                                          : 'رفع وتنفيذ الملف',
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style:
                                          const TextStyle(color: Colors.white),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Dynamic Note / Explanation Card
                Card(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        width: double.infinity,
                        height: 48,
                        color: const Color(0xffE1E2E3),
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              selectedOperation != null
                                  ? "شرح عملية: ${selectedOperation!.name}"
                                  : "شرح العملية",
                              style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          selectedOperation != null &&
                                  selectedOperation!.note.isNotEmpty
                              ? selectedOperation!.note
                              : 'يتم تعبئة ملف الإكسل حسب النموذج المخصص. يجب أن يحتوي الملف على الحقول الأساسية: الرقم، الاسم، السعر. يجب أن تكون البيانات صحيحة وإلا سيتم رفض الملف. يعرض النظام الملاحظات مع رقم السطر عند وجود أخطاء. يمكن إضافة آلاف المنتجات دفعة واحدة من خلال ملف إكسل واحد.',
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Models
