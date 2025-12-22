import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/dialogs/ErrorDialog.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/entity/excell_operationclass.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_cubt.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/cubit/excell_cubit/excell_states.dart';
import 'package:sindbad_management_app/core/utils/download_snackbar_helper.dart';
import 'package:sindbad_management_app/core/widgets/primary_action_button.dart';

class AddExcelPage extends StatefulWidget {
  const AddExcelPage({super.key});

  @override
  State<AddExcelPage> createState() => _AddExcelPageState();
}

class _AddExcelPageState extends State<AddExcelPage> {
  FilePickerResult? file;
  final List<ExcellOperation> operation = [
    ExcellOperation(operationName: "أضافة", operations: [
      Operation(
          name: "اضافة / تعديل منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A9%20%D9%88%D8%AA%D8%B9%D8%AF%D9%8A%D9%84%20%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لإضافة أو تعديل المنتجات عبر ملف إكسل، يتم تعبئة ملف الإكسل حسب النموذج (يمكن تحميل نموذج أي عملية من خلال الرابط الذي يظهر) يجب وجود الحقول الأساسية للمنتج وهي الرقم، الاسم، السعر، الصورة ويجب أن تكون البيانات صحيحة وإلا سيتم رفض الملف. يعطي النظام الملاحظات على الملف مع رقم السطر. يمكن إضافة آلاف المنتجات في ملف الإكسل وسيتم إضافتها دفعة واحدة."),
      Operation(
          name: "تحديث اسعار منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%AA%D8%AD%D8%AF%D9%8A%D8%AB%20%D8%A7%D8%B3%D8%B9%D8%A7%D8%B1%20%D8%A7%D9%84%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لتحديث أسعار المنتجات الموجودة في النظام. يحتاج الملف إلى عمودين: رقم المنتج والسعر الجديد."),
      Operation(
          name: "ايقاف منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%A7%D9%8A%D9%82%D8%A7%D9%81%20%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لايقاف منتجات معينة مؤقتاً عن الظهور في التطبيق. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "تفعيل منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%AA%D9%81%D8%B9%D9%8A%D9%84%20%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لتفعيل منتجات كانت موقفة سابقاً. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "اضافة / تعديل عروض منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%A7%D8%B6%D8%A7%D9%81%D8%A9%20%D9%88%D8%AA%D8%B9%D8%AF%D9%8A%D9%84%20%D8%B9%D8%B1%D9%88%D8%B6%20%D8%A7%D9%84%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لإضافة أو تعديل عروض المنتجات. يحتاج الملف إلى أعمدة: رقم المنتج، اسم المنتج، السعر، تاريخ بداية العرض، تاريخ نهاية العرض."),
      Operation(
          name: "ايقاف عروض منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%A7%D9%8A%D9%82%D8%A7%D9%81%20%D8%B9%D8%B1%D9%88%D8%B6%20%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لايقاف عروض منتجات معينة. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "تفعيل عروض منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%AA%D9%81%D8%B9%D9%8A%D9%84%20%D8%B9%D8%B1%D9%88%D8%B6%20%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لتفعيل عروض منتجات كانت موقفة. يحتاج الملف إلى عمود واحد: رقم المنتج."),
      Operation(
          name: "تعديل تاريخ عروض منتجات.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D8%AA%D8%B9%D8%AF%D9%8A%D9%84%20%D8%AA%D8%A7%D8%B1%D9%8A%D8%AE%20%D8%B9%D8%B1%D9%88%D8%B6%20%D9%85%D9%86%D8%AA%D8%AC%D8%A7%D8%AA.xlsx",
          note:
              "لتعديل تواريخ العروض للمنتجات. يحتاج الملف إلى أعمدة: رقم المنتج، تاريخ بداية العرض، تاريخ نهاية العرض."),
    ]),
    ExcellOperation(operationName: "عمليات الفئات", operations: [
      Operation(
          name: "اعادة الاسماء المقترحة لفئات مورد.xlsx",
          downloadExcellLink:
              "Sindibad_%D9%86%D9%85%D9%88%D8%B0%D8%AC%20%D9%81%D8%A6%D8%A7%D8%AA%20%D8%A7%D9%84%D9%85%D9%88%D8%B1%D8%AF.xlsx",
          note:
              "يتم رفع فئات المورد بالأسماء. يمكن كتابة الفئات على شكل شجرة بحيث يفصل بين الفئة والفئة الفرعية بالرمز >. بعد رفع الفئات يقوم النظام بمقارنة الأسماء بشجرة فئات سندباد، يتم إعطاء الملاحظات والاقتراحات عبر إعادة ملف الإكسل بتفاصيل أكثر."),
      Operation(
          name: "تسجيل فئات مورد - الفئات المعتمدة.xlsx",
          note:
              "لتسجيل فئات المورد المعتمدة بعد المراجعة. يجب أن يحتوي الملف على أعمدة: اسم الفئة، الفئة الرئيسية، وكود الفئة في سندباد."),
      Operation(
          name: "تحميل شجرة فئات سندباد",
          note: "لا يوجد شرح متوفر لهذه العملية."),
      Operation(
          name: "اضافة فئات ادارية", note: "لا يوجد شرح متوفر لهذه العملية."),
    ]),
    // ExcellOperation(operationName: "ادوات مساعده", operations: [
    //   Operation(
    //       name: "جلب صور من النت",
    //       downloadExcellLink: "https://example.com/template.xlsx",
    //       note: "لا يوجد شرح متوفر لهذه العملية."),
    //   Operation(
    //       name: "اختيار صورة",
    //       downloadExcellLink: "https://example.com/template.xlsx",
    //       note: "لا يوجد شرح متوفر لهذه العملية."),
    //   Operation(
    //       name: "اختيار عدة صور",
    //       downloadExcellLink: "https://example.com/template.xlsx",
    //       note: "لا يوجد شرح متوفر لهذه العملية."),
    //   Operation(
    //       name: "تجميع روابط الصور",
    //       downloadExcellLink: "https://example.com/template.xlsx",
    //       note: "لا يوجد شرح متوفر لهذه العملية."),
    // ])
  ];

  ExcellOperation? selectedOperationGroup;
  Operation? selectedOperation;
  bool processing = false;
  // ---------------- FIXED METHODS ---------------- //

  // Future<File?> downloadFile(String url, String name) async {
  //   try {
  //     // Use the same storage approach as saveFileLocally for Android scoped storage compatibility
  //     String dirPath;
  //     if (Platform.isAndroid) {
  //       final externalDir = await getExternalStorageDirectory();
  //       if (externalDir != null) {
  //         dirPath = '${externalDir.path}/Sindbad';
  //       } else {
  //         final docDir = await getApplicationDocumentsDirectory();
  //         dirPath = '${docDir.path}/Sindbad';
  //       }
  //     } else {
  //       final dir = await getApplicationDocumentsDirectory();
  //       dirPath = '${dir.path}/Sindbad';
  //     }

  //     // Create directory if it doesn't exist
  //     final directory = Directory(dirPath);
  //     if (!await directory.exists()) {
  //       await directory.create(recursive: true);
  //     }

  //     final file = File("$dirPath/$name");

  //     // Use GET for downloading files, not POST
  //     final response = await Dio().post(
  //       url,
  //       options: Options(
  //         responseType: ResponseType.bytes,
  //         followRedirects: true,
  //         headers: {
  //           "Content-Type": "application/json",
  //           "Authorization":
  //               "Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlcyI6IlN0b3JlIiwianRpIjoiYjU5ZjlmN2EtMjM5Zi00MmFiLWEwYjUtMDE0NDVhYzk1N2U1IiwiZW1haWwiOiJlbTEzQHNpbmRpYmFkLmNvbSIsIm5hbWUiOiLYr9mK2KzZitiq2KfZhCDYstmI2YYiLCJQaG9uZU51bWJlciI6IjU1MDAwMTExOTk5MTMiLCJJZCI6IjE2OTk2OTExLTU5N2YtNDg2Yi04NWI3LTZiMzA5ODY1NTEzOCIsImV4cCI6MTc3MTE0ODI0NywiaXNzIjoiRmFzdFN0b3JlIiwiYXVkIjoiRmFzdFN0b3JlIn0.YHB3NB6kkNDwIxGNoy3VxcVcKvcxhNsvxEcQzwgO6KU",
  //         },
  //       ),
  //     );

  //     final raf = file.openSync(mode: FileMode.write);
  //     raf.writeFromSync(response.data);
  //     await raf.close();
  //     showDownloadSnackBar(context, file.path);
  //     return file;
  //   } catch (e) {
  //     print("Download error: $e");
  //     return null;
  //   }
  // }

  Future<void> downloadAllFiles() async {
    // FilePickerResult? result = await FilePicker.platform.pickFiles();

    context.read<ExcelCubit>().downloadAllFiles();
  }

  Future<void> openAndDownloadFile(String url, String filename) async {
    if (selectedOperation == null || selectedOperationGroup == null) {
      showErrorDialog(
          title: "الرجاء اختيار عملية",
          description: "الرجاء اختيار عملية",
          context: context);
    }
    context.read<ExcelCubit>().downloadFile(url, filename);
  }

  /// Upload the selected file via cubit
  Future<void> _upload() async {
    if (selectedOperation == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('اختر العملية أولاً')),
      );
      return;
    }

    if (file == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب اختيار ملف أولاً')),
      );
      return;
    }

    final filePath = file!.files.first.path;
    if (filePath == null) return;

    // Determine action based on selected operation index
    // Action 1 = Add/Edit products, 2-8 = other product actions, 31-49 = category actions
    final actionIndex =
        selectedOperationGroup?.operations.indexOf(selectedOperation!) ?? 0;
    final action = (actionIndex + 1).toString();

    context.read<ExcelCubit>().uploadFile(
          filePath: filePath,
          action: action,
        );
  }

  /// Pick an Excel file and validate its format
  Future<void> _pickFile() async {
    file = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xlsx', 'xls'],
    );
    if (!mounted) return; // Guard against using context after async gap

    if (file == null) {
      return; // User cancelled the picker
    }

    // Validate file extension
    final fileName = file!.files.first.name.toLowerCase();
    if (!fileName.endsWith('.xlsx') && !fileName.endsWith('.xls')) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('يجب اختيار ملف بصيغة xlsx أو xls')),
      );
      file = null;
      setState(() {});
      return;
    }

    setState(() {});
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
            showDownloadSnackBar(context, state.directoryPath,
                "تم حفظ الملفات في المجلد: ${state.directoryPath.split('/').last}");
          } else if (state is ExcellLoadFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text("حدث خطأ عند التحميل: ${state.message}")),
            );
          }
        },
        child: Scaffold(
          body: Container(
            color: Theme.of(context).scaffoldBackgroundColor,
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  CustomAppBar(
                      tital: "اضافة منتجات عبر الإكسيل", isSearch: false),
                  SizedBox(
                    height: 10,
                  ),
                  _downloadAllFilesSection(context),
                  const SizedBox(height: 18),
                  Card(
                    color: Theme.of(context).cardColor,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: Column(
                        children: [
                          Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              "اختر نوع العملية :",
                              style: TextStyle(
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w700,
                                fontSize: 16,
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          // First Dropdown
                          DropdownButtonFormField<ExcellOperation>(
                            initialValue: selectedOperationGroup,
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
                            initialValue: selectedOperation,
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

                          PrimaryActionButton(
                            enabled: selectedOperation != null &&
                                selectedOperation!.downloadExcellLink != null &&
                                selectedOperation!
                                    .downloadExcellLink!.isNotEmpty,
                            text:
                                'تحميل نموذج ${selectedOperation?.name ?? ""}',
                            icon: Icons.download,
                            isLoading: context.watch<ExcelCubit>().state
                                is ExcellLoadInProgress,
                            onPressed: () => openAndDownloadFile(
                              selectedOperation?.downloadExcellLink ?? "",
                              selectedOperation?.name ?? "",
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
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyLarge
                                    ?.color,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          InkWell(
                            onTap: _pickFile,
                            child: Container(
                              height: 48,
                              width: 326,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                color: Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.grey[600]!
                                    : Color(0xffF2F3F4),
                              )),
                              child: Row(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.grey[700]
                                            : Color(0xffF2F3F4),
                                        border: Border.all(
                                            color:
                                                Theme.of(context).brightness ==
                                                        Brightness.dark
                                                    ? Colors.grey[600]!
                                                    : Color(0xffF2F3F4))),
                                    height: 48,
                                    width: 93,
                                    child: Center(
                                        child: Text(
                                      "اختر الملف",
                                      style: TextStyle(
                                        color: Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.color,
                                      ),
                                    )),
                                  ),
                                  if (file != null)
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8),
                                        child: Text(
                                          file!.files.first.name,
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: TextStyle(
                                            color: Theme.of(context)
                                                .textTheme
                                                .bodyMedium
                                                ?.color,
                                          ),
                                        ),
                                      ),
                                    ),
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
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodySmall
                                      ?.color,
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
                                onPressed: _upload,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      Theme.of(context).colorScheme.primary,
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
                    color: Theme.of(context).cardColor,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
                          width: double.infinity,
                          height: 48,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.grey[800]
                              : const Color(0xffE1E2E3),
                          child: Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                selectedOperation != null
                                    ? "شرح عملية: ${selectedOperation!.name}"
                                    : "شرح العملية",
                                style: TextStyle(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyLarge
                                      ?.color,
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
                            style: TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyMedium
                                    ?.color),
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

  Row _downloadAllFilesSection(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "تحميل النماذج :",
          style: TextStyle(
            fontFamily: 'Cairo',
            fontWeight: FontWeight.w700,
            fontSize: 16,
            color: Theme.of(context).textTheme.bodyLarge?.color,
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
              onPressed: () => downloadAllFiles(),
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093456),
                padding: const EdgeInsets.symmetric(horizontal: 20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  if (context.watch<ExcelCubit>().state is ExcellLoadInProgress)
                    const SizedBox(
                      height: 16,
                      width: 16,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                        strokeWidth: 2,
                      ),
                    )
                  else
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
    );
  }
}

// Models
