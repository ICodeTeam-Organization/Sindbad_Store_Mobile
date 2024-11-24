import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/product_features/add_product_feature/widgets/custom_add_image_widget.dart';

// import '../widgets/custom_add_image_widget.dart';
import '../widgets/custom_dropdown_widget.dart';
import '../widgets/custom_simple_text_form_field.dart';
import '../widgets/custom_text_form_widget.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

// this is a Fake List to use with the DropMenu
  static const List<String> _mainCategoryList = [
    'إلكترونيات',
    'أزياء',
    'المنزل والمطبخ',
    'الجمال والعناية الشخصية',
    'الرياضة والأنشطة الخارجية',
    'الألعاب',
    'السيارات',
    'الكتب',
    'الموسيقى',
    'الصحة والعافية',
    'البقالة',
    'المجوهرات',
    'اللوازم المكتبية',
    'مستلزمات الحيوانات الأليفة',
    'منتجات الأطفال',
  ];

  static const List<String> _subCategoryList = [
    'لابتوبات',
    'شاشات',
    ' ماوسات',
    'كيبوردات',
  ];

  static const List<String> _brandList = [
    'مايكروسوفت',
    'ديل',
    'HP',
    'لينوفو',
    'أسس',
    'ماك',
    'الكتب',
    'سامسونج',
  ];

  // // Fake data for product properties key and value
  // static const Map<String, String> _productProperties = {
  //   'اللون': 'أحمر',
  //   'الحجم': 'كبير',
  //   'الوزن': '1 كجم',
  //   'المادة': 'بلاستيك',
  //   'الضمان': 'سنة واحدة',
  //   'بلد الصنع': 'الصين',
  //   'بلد ': 'الصين',
  // };

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final List<TextEditingController> _keys = [];
  final List<TextEditingController> _values = [];

// form key
// final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    for (var controller in _keys) {
      controller.dispose();
    }
    for (var controller in _values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _addField() {
    setState(() {
      _keys.add(TextEditingController());
      _values.add(TextEditingController());
    });
  }

  void _removeField(int index) {
    setState(() {
      _keys.removeAt(index);
      _values.removeAt(index);
    });
  }

// void _submit(){
//   final isValid = _formKey.currentState!.validate();
//   if(!isValid){
//     return;
//   }
//   // what happen is it vaslid (meaning the fields is ok)
//   //// write here the code for that ////
// }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                // onPressed: () {},
                tital: 'إضافة منتج',
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 363.0.w,
                          height: 434.0.h,
                          // decoration: BoxDecoration(
                          //   // color: AppColors.white,
                          //   // border: Border.all(width: 2.0.r, color: Colors.black),
                          // ),
                          margin: EdgeInsets.only(
                            bottom: 20.0.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //  container Title
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 16.0.h, top: 8.h, right: 20.0.w),
                                  child: Text(
                                    "معلومات المنتج",
                                    style: KTextStyle.textStyle16
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              CustomTextFormWidget(
                                textController: TextEditingController(),
                                text: 'أسم المنتج',
                                width: 334.0.w,
                                height: 65.h,
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomTextFormWidget(
                                      textController: TextEditingController(),
                                      text: 'السعر',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                    SizedBox(
                                      width: 36.0.w,
                                    ),
                                    CustomTextFormWidget(
                                      textController: TextEditingController(),
                                      text: 'رقم المنتج',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 10.0.h,
                              ),
                              CustomTextFormWidget(
                                textController: TextEditingController(),
                                text: 'وصف المنتج',
                                // labelText: 'أدخل وصف المنتج',
                                width: 334.0.w,
                                height: 200.0.h,
                                // initialValue: '',
                                maxLines: 5, // Allow multiple lines
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 363.0.w,
                          height: 434.0.h,
                          // decoration: BoxDecoration(
                          //   // border: Border.all(width: 2.0.w, color: Colors.black),
                          // ),
                          margin: EdgeInsets.only(
                            bottom: 20.0.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              //  container Title
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 16.0.h, top: 8.h, right: 20.0.w),
                                  child: Text(
                                    "أختر صورة المنتح",
                                    style: KTextStyle.textStyle16
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // Add MAin image
                              CustomAddImageWidget(
                                hasTileButton: true,
                                containerWidth: 333,
                                mainContainerHeight: 210,
                                upContainerHeight: 175,
                                downContainerHeight: 35,
                                onPressed: () {},
                              ),
                              SizedBox(
                                height: 25.0.h,
                              ),

                              // Add Sub images
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 14.w,
                                  // right: 8.w
                                ),
                                child: Row(
                                  children: [
                                    CustomAddImageWidget(
                                      onPressed: () {},
                                    ),
                                    SizedBox(
                                      width: 15.0.w,
                                    ),
                                    CustomAddImageWidget(
                                      onPressed: () {},
                                    ),
                                    SizedBox(
                                      width: 15.0.w,
                                    ),
                                    CustomAddImageWidget(
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 363.0.w,
                          // height: 356.0.h,
                          height: 440.0.h,
                          decoration: BoxDecoration(
                              // border: Border.all(width: 2.0.w, color: Colors.black),
                              ),
                          margin: EdgeInsets.only(bottom: 20.0.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              // container Title
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                      bottom: 14.0.h, top: 10.h, right: 14.0.w),
                                  child: Text(
                                    " نوع المنتج",
                                    style: KTextStyle.textStyle16
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdownWidget(
                                textTitle: 'أختر الفئة',
                                hintText: "قم بإختيار الفئة المناسبة",
                                items: AddProductScreen._mainCategoryList,
                                initialItem:
                                    AddProductScreen._mainCategoryList[0],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdownWidget(
                                textTitle: 'أختر قسم الفئة',
                                hintText: "قم بإختيار قسم الفئة المناسب",
                                items: AddProductScreen._subCategoryList,
                                initialItem:
                                    AddProductScreen._subCategoryList[0],
                              ),
                              SizedBox(
                                height: 10.h,
                              ),
                              CustomDropdownWidget(
                                textTitle: 'أختر إسم البراند',
                                hintText: "قم بإختيار البراند المناسب",
                                items: AddProductScreen._brandList,
                                initialItem: AddProductScreen._brandList[0],
                              )
                            ],
                          ),
                        ),
                      ),
                      // Flexible(
                      SizedBox(height: 26.h),
                      Flexible(
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.white,
                          child: Container(
                            // width: 363.0.w,
                            // height: 184.0.h,
                            decoration: BoxDecoration(
                                //  border: Border.all(width: 2.0.w, color: Colors.black),
                                ),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                // container Title
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        bottom: 14.0.h,
                                        top: 10.h,
                                        right: 14.0.w),
                                    child: Text(
                                      " خصائص المنتج",
                                      style: KTextStyle.textStyle16.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                // Flexible(
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int index = 0;
                                          index < _keys.length;
                                          index++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              vertical: 8.0.h),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              CustomSimpleTextFormField(
                                                textController: _keys[index],
                                                hintText: 'خاصية',
                                              ),
                                              SizedBox(width: 20.w),
                                              CustomSimpleTextFormField(
                                                textController: _values[index],
                                                hintText: 'قيمة',
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.remove_circle,
                                                    size: 20),
                                                onPressed: () =>
                                                    _removeField(index),
                                              ),
                                            ],
                                          ),
                                        ),
                                      IconButton(
                                        icon: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_sharp,
                                              size: 20,
                                              color: AppColors.primary,
                                            ),
                                            Text(" أضف المزيد"),
                                          ],
                                        ),
                                        onPressed: _addField,
                                      ),
                                      //  Text("أضف خاصية"),
                                    ],
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
              SizedBox(
                height: 10.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StorePrimaryButton(
                    title: "تأكيد",
                    width: 251.w,
                    height: 44.h,
                    buttonColor: AppColors.primary,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  StorePrimaryButton(
                    title: "إلغاء",
                    width: 104.w,
                    height: 46.h,
                    buttonColor: AppColors.greyIcon,
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
