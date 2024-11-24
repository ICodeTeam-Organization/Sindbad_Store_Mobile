import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/product_features/add_product_feature/widgets/custom_add_image_widget.dart';

import '../widgets/custom_dropdown_widget.dart';
import '../widgets/custom_simple_text_form_field.dart';
import '../widgets/custom_text_form_widget.dart';

class EditProductScreen extends StatefulWidget {
  // final String productName ;
  // final String price ;
  // final String productNumber ;
  // final String description ;

  // final Map<String,dynamic> maincategory ; as a {name : ... , id : ....}
  // or //
  //
  // final String maincategoryName ; store the  {name : ... }
  // final int maincategoryID ; store the  {id : ... }
  //   //
  // final Map<String,dynamic> subcategory ; as a {name : ... , id : ....}
  // or //
  //
  // final String subcategoryName ; store the  {name : ... }
  // final int subcategoryID ; store the  {id : ... }
  //   //
  // final Map<String,dynamic> brand ; as a {name : ... , id : ....}
  // or //
  //
  // final String brandName ; store the  {name : ... }
  // final int brandID ; store the  {id : ... }
  //   //

  // final String mainImage ;
  // final List<String> subImages ;
  // final Map<String,dynamic> properties ;

  // final List<String> mainCategoryList ; if i will not fetch it from inside the widget 
  // final List<String> subCategoryList ;  if i will not fetch it from inside the widget
  // final List<String> brandList ;        if i will not fetch it from inside the widget
  
  const EditProductScreen({super.key});

  // Fake data for editing a product
  static const Map<String, dynamic> fakeData = {
    'productName': 'منتج تجريبي',
    'price': '100',
    'productNumber': '12345',
    'description': 'هذا وصف تجريبي للمنتج.',
    'category': 'إلكترونيات',
    'subcategory': 'شاشات',
    'brand': 'سامسونج',
    'mainImage': 'https://via.placeholder.com/150',
    'subImages': [
      'https://via.placeholder.com/100',
      'https://via.placeholder.com/100',
      'https://via.placeholder.com/100'
    ],
    'properties': {
      'اللون': 'أحمر',
      'الحجم': 'كبير',
    }
  };

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

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final List<TextEditingController> _keys = [];
  final List<TextEditingController> _values = [];

  @override
  void initState() {
    super.initState();
    // Initialize controllers with fake data
    EditProductScreen.fakeData['properties'].forEach((key, value) {
      _keys.add(TextEditingController(text: key));
      _values.add(TextEditingController(text: value));
    });
  }

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

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                onPressed: () {},
                tital: 'تعديل منتج',
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
                          // decoration: BoxDecoration(),
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
                                    bottom: 16.0.h,
                                    top: 8.h,
                                    right: 20.0.w,
                                  ),
                                  child: Text(
                                    "معلومات المنتج",
                                    style: KTextStyle.textStyle16.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              CustomTextFormWidget(
                                textController: TextEditingController(text: EditProductScreen.fakeData['productName']),
                                text: 'أسم المنتج',
                                width: 334.0.w,
                                height: 65.h,
                              ),
                              SizedBox(height: 10.0.h),
                              Padding(
                                padding: EdgeInsets.only(right: 20.0.w),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    CustomTextFormWidget(
                                      textController: TextEditingController(text: EditProductScreen.fakeData['price']),
                                      text: 'السعر',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                    SizedBox(width: 36.0.w),
                                    CustomTextFormWidget(
                                      textController: TextEditingController(text: EditProductScreen.fakeData['productNumber']),
                                      text: 'رقم المنتج',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              CustomTextFormWidget(
                                textController: TextEditingController(text: EditProductScreen.fakeData['description']),
                                text: 'وصف المنتج',
                                width: 334.0.w,
                                height: 200.0.h,
                                maxLines: 5,
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
                          // decoration: BoxDecoration(),
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
                                    bottom: 16.0.h,
                                    top: 8.h,
                                    right: 20.0.w,
                                  ),
                                  child: Text(
                                    "أختر صورة المنتح",
                                    style: KTextStyle.textStyle16.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              CustomAddImageWidget(
                                hasTileButton: true,
                                containerWidth: 333,
                                mainContainerHeight: 210,
                                upContainerHeight: 175,
                                downContainerHeight: 35,
                                // initialImage: EditProductScreen.fakeData['mainImage'],
                                initialImageUrl: EditProductScreen.fakeData['mainImage'],
                                onPressed: () {},
                              ),
                              SizedBox(height: 25.0.h),
                              Padding(
                                padding: EdgeInsets.only(left: 14.w),
                                child: Row(
                                  children: [
                                    CustomAddImageWidget(
                                      // initialImage: EditProductScreen.fakeData['subImages'][0],
                                      initialImageUrl: EditProductScreen.fakeData['subImages'][0],
                                      onPressed: () {},
                                    ),
                                    SizedBox(width: 15.0.w),
                                    CustomAddImageWidget(
                                      // initialImage: EditProductScreen.fakeData['subImages'][1],
                                      initialImageUrl: EditProductScreen.fakeData['subImages'][1],
                                      onPressed: () {},
                                    ),
                                    SizedBox(width: 15.0.w),
                                    CustomAddImageWidget(
                                      initialImageUrl: EditProductScreen.fakeData['subImages'][2],
                                      // initialImage: EditProductScreen.fakeData['subImages'][2],
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
                          height: 440.0.h,
                          decoration: BoxDecoration(),
                          margin: EdgeInsets.only(bottom: 20.0.h),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Align(
                                alignment: Alignment.topRight,
                                child: Padding(
                                  padding: EdgeInsets.only(
                                    bottom: 14.0.h,
                                    top: 10.h,
                                    right: 14.0.w,
                                  ),
                                  child: Text(
                                    " نوع المنتج",
                                    style: KTextStyle.textStyle16.copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              CustomDropdownWidget(
                                textTitle: 'أختر الفئة',
                                hintText: "قم بإختيار الفئة المناسبة",
                                items: EditProductScreen._mainCategoryList,
                                initialItem: EditProductScreen.fakeData['category'],
                              ),
                              SizedBox(height: 10.h),
                              CustomDropdownWidget(
                                textTitle: 'أختر قسم الفئة',
                                hintText: "قم بإختيار قسم الفئة المناسب",
                                items: EditProductScreen._subCategoryList,
                                initialItem: EditProductScreen.fakeData['subcategory'],
                              ),
                              SizedBox(height: 10.h),
                              CustomDropdownWidget(
                                textTitle: 'أختر إسم البراند',
                                hintText: "قم بإختيار البراند المناسب",
                                items: EditProductScreen._brandList,
                                initialItem: EditProductScreen.fakeData['brand'],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      Flexible(
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          color: Colors.white,
                          child: Container(
                            decoration: BoxDecoration(),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Align(
                                  alignment: Alignment.topRight,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                      bottom: 14.0.h,
                                      top: 10.h,
                                      right: 14.0.w,
                                    ),
                                    child: Text(
                                      " خصائص المنتج",
                                      style: KTextStyle.textStyle16.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      for (int index = 0; index < _keys.length; index++)
                                        Padding(
                                          padding: EdgeInsets.symmetric(vertical: 8.0.h),
                                          child: Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
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
                                                icon: Icon(Icons.remove_circle, size: 20),
                                                onPressed: () => _removeField(index),
                                              ),
                                            ],
                                          ),
                                        ),
                                      IconButton(
                                        icon: Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
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
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StorePrimaryButton(
                    title: "تأكيد",
                    width: 251.w,
                    height: 44.h,
                    buttonColor: AppColors.primary,
                  ),
                  SizedBox(width: 8.w),
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
