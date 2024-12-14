import 'dart:collection';

import 'package:animated_custom_dropdown/custom_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/custom_add_image_widget.dart';

// import '../widgets/custom_add_image_widget.dart';
import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_simple_text_form_field.dart';
import '../../widgets/custom_text_form_widget.dart';

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

  // List<String> getNamesCategory() {
  //   // استخراج أسماء الفئات الرئيسية
  //   List<String> namesCategory = context
  //       .read<AddProductToStoreCubit>()
  //       .categoriesWithDetails
  //       .values
  //       .map((category) {
  //     return category
  //         .keys.first; // نحصل على اسم الفئة الرئيسية (مثل Electronics)
  //   }).toList();
  //   return namesCategory;
  // }

  final Map<int, Map<String, List<Map<String, dynamic>>>> categories = {
    1: {
      'Electronics': [
        {'id': 1, 'name': 'Mobile Phones'},
        {'id': 2, 'name': 'Laptops'},
        {'id': 3, 'name': 'Cameras'},
        {'id': 4, 'name': 'Televisions'},
        {'id': 5, 'name': 'Headphones'}
      ]
    },
    2: {
      'Home Appliances': [
        {'id': 6, 'name': 'Refrigerators'},
        {'id': 7, 'name': 'Washing Machines'},
        // {'id': 8, 'name': 'Microwaves'},
        // {'id': 9, 'name': 'Air Conditioners'},
        // {'id': 10, 'name': 'Vacuum Cleaners'}
      ]
    }
  }; // أضف باقي الفئات هنا }

  final Map<int, List<Map<String, dynamic>>> brands = {
    // id 'Electronics'
    1: [
      {"id": 1, "name": "O.K."},
      {"id": 2, "name": "Adidas"}
    ],
    // id 'Home Appliances'
    2: [
      {"id": 1, "name": "O.K."},
      {"id": 2, "name": "Adidas"}
    ],
  };

  String? selectedCategory;
  List<Map<String, dynamic>>? subCategories;
  String? selectedSubCategory;
  List<Map<String, dynamic>>? categoryBrands;
  String? selectedBrand;

  // late SingleSelectController<String?> categoryController;
  // late SingleSelectController<String?> subCategoryController;
  // late SingleSelectController<String?> brandController;
// form key
// final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    // categoryController = SingleSelectController<String?>(null);
    // subCategoryController = SingleSelectController<String?>(null);
    // brandController = SingleSelectController<String?>(null);
  }

  @override
  void dispose() {
    // categoryController.dispose();
    // subCategoryController.dispose();
    // brandController.dispose();
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
    //
    // context.read<AddProductToStoreCubit>().fetchCategories();
    //
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
                      //  ================= for text filed =========
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
                                textController: context
                                    .read<AddProductToStoreCubit>()
                                    .nameProductController, // ================================
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
                                      textController: context
                                          .read<AddProductToStoreCubit>()
                                          .priceProductController, // ================================
                                      text: 'السعر',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                    SizedBox(
                                      width: 36.0.w,
                                    ),
                                    CustomTextFormWidget(
                                      textController: context
                                          .read<AddProductToStoreCubit>()
                                          .numberProductController, // ================================
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
                                textController: context
                                    .read<AddProductToStoreCubit>()
                                    .descriptionProductController, // ================================
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
                      //  ================= for Add Images =========
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
                                imagePartNumber: 1,
                                image: context
                                    .read<AddImageToProductAddCubit>()
                                    .mainImageProduct,
                                onTapPickImage: () => context
                                    .read<AddImageToProductAddCubit>()
                                    .pickImageFromGallery(numPartImage: 1),
                                isForMainImage: true,
                                containerWidth: 333.w,
                                mainContainerHeight: 210.h,
                                upContainerHeight: 175.h,
                                downContainerHeight: 35.h,
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
                                      imagePartNumber: 2,
                                      image: context
                                          .read<AddImageToProductAddCubit>()
                                          .subOneImageProduct,
                                      onTapPickImage: () => context
                                          .read<AddImageToProductAddCubit>()
                                          .pickImageFromGallery(
                                              numPartImage: 2),
                                      onPressed: () {},
                                    ),
                                    SizedBox(
                                      width: 15.0.w,
                                    ),
                                    CustomAddImageWidget(
                                      imagePartNumber: 3,
                                      image: context
                                          .read<AddImageToProductAddCubit>()
                                          .subTwoImageProduct,
                                      onTapPickImage: () => context
                                          .read<AddImageToProductAddCubit>()
                                          .pickImageFromGallery(
                                              numPartImage: 3),
                                      onPressed: () {},
                                    ),
                                    SizedBox(
                                      width: 15.0.w,
                                    ),
                                    CustomAddImageWidget(
                                      imagePartNumber: 4,
                                      image: context
                                          .read<AddImageToProductAddCubit>()
                                          .subThreeImageProduct,
                                      onTapPickImage: () => context
                                          .read<AddImageToProductAddCubit>()
                                          .pickImageFromGallery(
                                              numPartImage: 4),
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
                      //  ================= for drop down =========
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
                              BlocBuilder<GetCategoryNamesCubit,
                                  GetCategoryNamesState>(
                                builder: (context, state) {
                                  if (state is GetCategoryNamesInitial) {
                                    // عند فتح الصفحة قبل تنفيذ دالة الجلب لابد أن تعطية شكل إفتراضي
                                    return Column(
                                      children: [
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر الفئة',
                                          hintText:
                                              "تأكد من إتصالك بالإنترنت, أعد المحاولة",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر قسم الفئة',
                                          hintText:
                                              "تأكد من إتصالك بالإنترنت, أعد المحاولة",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is GetCategoryNamesLoading) {
                                    print(
                                        "جارررررررررررررررررررررررري التحميييييييييييييييل");
                                    return Column(
                                      children: [
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر الفئة',
                                          hintText: "جاري التحميل...",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر قسم الفئة',
                                          hintText: "جاري التحميل...",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر إسم البراند',
                                          hintText: "جاري التحميل...",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                      ],
                                    );
                                  }
                                  if (state is GetCategoryNamesSuccess ||
                                      state
                                          is GetCategoryNamesMainCategoryUpdated) {
                                    final cubit =
                                        context.read<GetCategoryNamesCubit>();
                                    // for Main category Names
                                    final List<String>
                                        categoryAndSubCategoryNames = cubit
                                            .categoryAndSubCategoryNames.entries
                                            .map((entry) =>
                                                entry.value.keys.first)
                                            .toList();
                                    // for Sub category Names
                                    final List<
                                        String> subCategoriesNames = cubit
                                                .selectedMainCategoryId !=
                                            null
                                        ? cubit
                                            .getSubCategoriesByMainCategoryId(
                                              mainCategoryId:
                                                  cubit.selectedMainCategoryId!,
                                            )
                                            .map((subCategory) =>
                                                subCategory['name'] as String)
                                            .toList()
                                        : [];
                                    return Column(
                                      children: [
                                        CustomDropdownWidget(
                                          enabled: true,
                                          textTitle: 'أختر الفئة',
                                          hintText: "قم بإختيار الفئة المناسبة",
                                          initialItem: null,
                                          items: categoryAndSubCategoryNames
                                                  .isNotEmpty
                                              ? categoryAndSubCategoryNames
                                              : [],
                                          onChanged: (value) {
                                            cubit.updateSelectedMainCategory(
                                                value!);
                                            cubit.vv();
                                          },
                                        ),
                                        SizedBox(height: 10),
                                        CustomDropdownWidget(
                                          enabled:
                                              cubit.selectedMainCategoryId !=
                                                  null,
                                          textTitle: 'أختر قسم الفئة',
                                          hintText:
                                              "قم بإختيار قسم الفئة المناسب",
                                          initialItem:
                                              cubit.selectedMainCategoryId !=
                                                      null
                                                  ? subCategoriesNames.first
                                                  : null,
                                          items: cubit.selectedMainCategoryId !=
                                                  null
                                              ? subCategoriesNames.isNotEmpty
                                                  ? subCategoriesNames
                                                  : []
                                              : [],
                                          onChanged: (value) {
                                            cubit.updateSelectedSubCategory(
                                                value!);
                                            cubit.vv();
                                          },
                                        ),
                                      ],
                                    );
                                  }

                                  if (state is GetCategoryNamesFailure) {
                                    print(
                                        "فششششششششششششششل التحميييييييييييييييل");
                                    return Column(
                                      children: [
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر الفئة',
                                          hintText: "فشل التحميل, أعد المحاولة",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر قسم الفئة',
                                          hintText: "فشل التحميل, أعد المحاولة",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                        SizedBox(
                                          height: 10.h,
                                        ),
                                        CustomDropdownWidget(
                                          enabled: false,
                                          textTitle: 'أختر إسم البراند',
                                          hintText: "حدث خطأ, أعد المحاولة",
                                          items: [],
                                          onChanged: (value) => null,
                                        ),
                                      ],
                                    );
                                  }
                                  // عند حدوث خطأ غير معروف
                                  return Column(
                                    children: [
                                      CustomDropdownWidget(
                                        enabled: false,
                                        textTitle: 'أختر الفئة',
                                        hintText: "حدث خطأ, أعد المحاولة",
                                        items: [],
                                        onChanged: (value) => null,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomDropdownWidget(
                                        enabled: false,
                                        textTitle: 'أختر قسم الفئة',
                                        hintText: "حدث خطأ, أعد المحاولة",
                                        items: [],
                                        onChanged: (value) => null,
                                      ),
                                      SizedBox(
                                        height: 10.h,
                                      ),
                                      CustomDropdownWidget(
                                        enabled: false,
                                        textTitle: 'أختر إسم البراند',
                                        hintText: "حدث خطأ, أعد المحاولة",
                                        items: [],
                                        onChanged: (value) => null,
                                      ),
                                    ],
                                  );
                                },
                              ),
                              // SizedBox(
                              //   height: 10.h,
                              // ),
                              // CustomDropdownWidget(
                              //   enabled: categoryBrands != null &&
                              //           categoryBrands!.isNotEmpty
                              //       ? true
                              //       : false,
                              //   // controller: categoryBrands != null &&
                              //   //         categoryBrands!.isNotEmpty
                              //   //     ? brandController
                              //   //     : null,
                              //   textTitle: 'أختر إسم البراند',
                              //   hintText: "قم بإختيار البراند المناسب",
                              //   // items: AddProductScreen._brandList,
                              //   // استخراج أسماء الفئات الرئيسية
                              //   items: categoryBrands != null &&
                              //           categoryBrands!.isNotEmpty
                              //       ? categoryBrands!.map((brand) {
                              //           return brand['name'] as String;
                              //         }).toList()
                              //       : [],
                              //   onChanged: (value) {
                              //     setState(() {
                              //       selectedBrand = value;
                              //       print('اختير البراند: $selectedBrand');
                              //     });
                              //   },
                              //   // initialItem: AddProductScreen._brandList[0],
                              // )
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
                    onTap: () {
                      // ================ for test ============
                      // context.read<AddProductToStoreCubit>().fetchCategories();
                      print(context
                          .read<GetCategoryNamesCubit>()
                          .categoryAndSubCategoryNames);
                      print(context
                          .read<GetCategoryNamesCubit>()
                          .categoryAndSubCategoryNames
                          .isEmpty);
                      context.read<GetCategoryNamesCubit>().fetchCategories();
                    },
                    title: "تأكيد",
                    width: 251.w,
                    height: 44.h,
                    buttonColor: AppColors.primary,
                  ),
                  SizedBox(
                    width: 8.w,
                  ),
                  StorePrimaryButton(
                    onTap: () {
                      context.read<GetCategoryNamesCubit>().vv();
                    },
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
