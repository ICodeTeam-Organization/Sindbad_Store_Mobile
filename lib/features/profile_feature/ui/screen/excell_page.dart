import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:open_file/open_file.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/excell_operationclass.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_cubt.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_states.dart';

class AddExcelPage extends StatefulWidget {
  const AddExcelPage({super.key});

  @override
  State<AddExcelPage> createState() => _AddExcelPageState();
}

class _AddExcelPageState extends State<AddExcelPage> {
  FilePickerResult? file = null;
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
  // ---------------- FIXED METHODS ---------------- //

  Future<File?> downloadFile(String url, String name) async {
    try {
      final appStorage = await getApplicationDocumentsDirectory();
      final file = File("${appStorage.path}/$name");

      final response = await Dio().get(
        url,
        options: Options(
          responseType: ResponseType.bytes,
          followRedirects: true,
        ),
      );

      final raf = file.openSync(mode: FileMode.write);
      raf.writeFromSync(response.data);
      await raf.close();

      return file;
    } catch (e) {
      print("Download error: $e");
      return null;
    }
  }

  Future<void> downloadAllFles() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    context.read<ExcelCubit>().downloadAllFiles();
  }

  Future openAndDownloadFile(String url, String filename) async {
    final file = await downloadFile(url, filename);

    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("فشل تحميل الملف")),
      );
      // OpenFile.open(file!.path);
      return;
    }

    print("Path: ${file.path}");
    OpenFile.open(file.path);
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

  void showDownloadSnackBar(BuildContext context, String filePath) async {
    // final dir = await getApplicationDocumentsDirectory();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.blueGrey.shade900,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        margin: const EdgeInsets.all(12),
        duration: const Duration(seconds: 6),
        content: Row(
          children: [
            const Icon(Icons.check_circle, color: Colors.greenAccent, size: 28),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                "تم حفظ الملف في المجلد:\n${filePath.split('/').last}",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
        action: SnackBarAction(
          label: "فتح المجلد",
          textColor: Colors.tealAccent,
          onPressed: () {
            OpenFile.open(filePath); // يفتح المجلد
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocListener<ExcelCubit, ExcelState>(
        listener: (context, state) {
          if (state is ExcellLoadInProgress) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("جاري تنزيل الملفات")),
            );
          } else if (state is ExcellLoadSuccess) {
            showDownloadSnackBar(context, state.directoryPath);
          } else if (state is ExcellLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("حدث خطأ عند التحميل: ${state.message}")),
            );
          }
        },
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "قم اولاً بتحميل النماذج :",
                        style: TextStyle(
                          fontFamily: 'Cairo',
                          fontWeight: FontWeight.w700,
                          fontSize: 16,
                        ),
                      ),
                      ConstrainedBox(
                        constraints: const BoxConstraints(
                          minWidth: 84,
                          maxWidth: 480,
                        ),
                        child: SizedBox(
                          width: 107,
                          height: 48,
                          child: ElevatedButton(
                            onPressed: () => downloadAllFles(),
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
                                    'تحميل',
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 18),
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
                                selectedOperation =
                                    null; // reset second dropdown
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
                                onPressed: () => openAndDownloadFile(
                                    "https://rr4---sn-8pxuuxa-nbo6l.googlevideo.com/videoplayback?expire=1763758348&ei=rHwgabnRDqHfssUPq_fX6Q4&ip=2402%3A800%3A62a7%3A9598%3A8d6f%3A3073%3A52ea%3A6033&id=o-ADuGQKHzJjKqmEWP13z8ZhkSjyZKg0oMOk0LCnwf5lsP&itag=18&source=youtube&requiressl=yes&xpc=EgVo2aDSNQ%3D%3D&cps=0&met=1763736748%2C&mh=IU&mm=31%2C26&mn=sn-8pxuuxa-nbo6l%2Csn-oguelnsr&ms=au%2Conr&mv=m&mvi=4&pl=48&rms=au%2Cau&initcwndbps=1835000&bui=AdEuB5RN2nFhoiurMU3sZPADAdEPMfbA2IlY1MSMl-S6x1deQLSShEkpWGZNztAT4oNMWbAoAEn5ffO7&vprv=1&svpuc=1&mime=video%2Fmp4&ns=6-LbATzX969cYuIQmLjjzooQ&rqh=1&cnr=14&ratebypass=yes&dur=207.330&lmt=1748025761834695&mt=1763736329&fvip=1&lmw=1&fexp=51557447%2C51565115%2C51565681%2C51580970&c=TVHTML5&sefc=1&txp=4538534&n=E5X_Puhfu7cE7w&sparams=expire%2Cei%2Cip%2Cid%2Citag%2Csource%2Crequiressl%2Cxpc%2Cbui%2Cvprv%2Csvpuc%2Cmime%2Cns%2Crqh%2Ccnr%2Cratebypass%2Cdur%2Clmt&lsparams=cps%2Cmet%2Cmh%2Cmm%2Cmn%2Cms%2Cmv%2Cmvi%2Cpl%2Crms%2Cinitcwndbps&lsig=APaTxxMwRQIgOfZIJs9dLZTcsOowgD0D_V9m88rhF2dW6gZRmOmW8HwCIQDaFeBcLCSOOkvaNcEEyRQ6-6wd445pQ4cutaUAOp0cuQ%3D%3D&sig=AJfQdSswRgIhALZpG2TGEJlZevjw6QnpAPZRfR_xnMs9CCbDzKTRuHDfAiEAuB1h0bNloJdzDMV2zwcq0IJRw35fBsCOCU_krHAEfVM%3D&title=%D8%B0%D9%83%D8%B1%D9%8A%D9%86%D8%A7%20%7C%7C%20%23%D9%85%D9%88%D8%B3%D9%89_%D8%A7%D9%84%D8%B9%D9%85%D9%8A%D8%B1%D8%A9%20%20%23%D8%B0%D9%83%D8%B1%D9%8A%D9%86%D8%A7",
                                    "temp.mp4"),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF093456),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                        style: const TextStyle(
                                            color: Colors.white),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "اختر ملف الإكسل:",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: () async {
                              file = await FilePicker.platform.pickFiles(
                                  // type: FileType.custom,
                                  // allowedExtensions: ['xlsx', 'xls'],
                                  );
                              if (file == null) return;
                              setState(() {});
                              OpenFile.open(file!.files.first.path);
                            },
                            child: Container(
                              height: 48,
                              width: 326,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Color(0xffF2F3F4))),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Color(0xffF2F3F4),
                                        border: Border.all(
                                            color: Color(0xffF2F3F4))),
                                    height: 48,
                                    width: 93,
                                    child: Center(child: Text("اختر الملف")),
                                  ),
                                  if (file != null)
                                    Center(
                                        child: Text(
                                      file!.files.first.name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    )),
                                ],
                              ),
                            ),
                          ),
                          Align(
                              alignment: AlignmentGeometry.centerRight,
                              child: Text(
                                "الامتدادات المسموحة: .xlsx., .xls",
                                style: TextStyle(
                                  fontFamily: 'Cairo',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 14,
                                ),
                              )),
                          const SizedBox(height: 20),
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
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20),
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
                                        style: const TextStyle(
                                            color: Colors.white),
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
      ),
    );
  }
}

// Models
