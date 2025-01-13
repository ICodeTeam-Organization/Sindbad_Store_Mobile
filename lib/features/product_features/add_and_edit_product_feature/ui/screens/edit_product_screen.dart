import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/data/repos/add_product_store_repo_impl.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/usecases/add_product_to_store_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/usecases/get_brands_by_main_category_id_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/usecases/get_main_and_sub_category_use_case.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_images/cubit/add_image_to_product_add_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/custom_add_image_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_else_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_failure_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_initial_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_loading_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/get_category_names_success_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/widgets/two_button_in_down_add_product.dart';

import '../../widgets/custom_dropdown_widget.dart';
import '../../widgets/custom_simple_text_form_field.dart';
import '../../widgets/custom_text_form_widget.dart';

class EditProductScreen extends StatefulWidget {
  final int productId;
  final String productName;
  final String price;
  final String productNumber;
  final String description;
  final List<String> mainCategoryList;
  final String selectedCategory;
  final List<String> subCategoryList;
  final String selectedSubCategory;
  final List<String> brandList;
  final String selectedBrand;
  final String mainImage;
  final List<String> subImages;
  final Map<String, dynamic> properties;

  const EditProductScreen({
    super.key,
    required this.productId,
    this.productName = '',
    this.price = '',
    this.productNumber = '',
    this.description = '',
    this.mainCategoryList = const [],
    this.selectedCategory = '',
    this.subCategoryList = const [],
    this.selectedSubCategory = '',
    this.brandList = const [],
    this.selectedBrand = '',
    this.mainImage = '',
    this.subImages = const [],
    this.properties = const {},
  });

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
    widget.properties.forEach((key, value) {
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
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          // =========  initilize BlocProvider for Add Product Screen ==========
          child: MultiBlocProvider(
            providers: [
              //for add product
              BlocProvider(
                  create: (context) =>
                      AddProductToStoreCubit(AddProductToStoreUseCase(
                        addProductStoreRepo:
                            getit.get<AddProductStoreRepoImpl>(),
                      ))),
              BlocProvider(create: (context) => AddImageToProductAddCubit()),
              BlocProvider(
                  create: (context) =>
                      GetCategoryNamesCubit(GetMainAndSubCategoryUseCase(
                        getit.get<AddProductStoreRepoImpl>(),
                      ))),
              BlocProvider(
                  create: (context) => GetBrandsByCategoryIdCubit(
                          GetBrandsByMainCategoryIdUseCase(
                        getit.get<AddProductStoreRepoImpl>(),
                      ))),
              BlocProvider(create: (context) => AddAttributeProductDartCubit()),
              //
            ],
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomAppBar(
                  isSearch: false,
                  tital: 'تعديل منتج',
                ),
                SizedBox(height: 40.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.greyBorder),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //  container Title
                                SectionTitleWidget(title: 'معلومات المنتج'),
                                SizedBox(height: 20.h),
                                CustomTextFormWidget(
                                  textController: TextEditingController(
                                      text: widget.productName),
                                  text: 'أسم المنتج',
                                  height: 65.h,
                                  width: 400.w,
                                ),
                                SizedBox(height: 20.0.h),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomTextFormWidget(
                                      textController: TextEditingController(
                                          text: widget.price),
                                      text: 'السعر',
                                      width: 150.w,
                                      height: 65.h,
                                    ),
                                    CustomTextFormWidget(
                                      textController: TextEditingController(
                                          text: widget.productNumber),
                                      text: 'رقم المنتج',
                                      width: 150.w,
                                      height: 65.h,
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20.h),
                                CustomTextFormWidget(
                                  textController: TextEditingController(
                                      text: widget.description),
                                  text: 'وصف المنتج',
                                  width: 400.0.w,
                                  height: 200.0.h,
                                  maxLines: 5, // Allow multiple lines
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.greyBorder),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                //  container Title
                                SectionTitleWidget(title: "أختر صورة المنتح"),
                                SizedBox(height: 20.h),
                                // Add MAin image
                                CustomAddImageWidget(
                                  imagePartNumber: 1,
                                  // image: cubitAddImage.mainImageProduct,
                                  onTapPickImage: () async {
                                    // await cubitAddImage.pickImageFromGallery(numPartImage: 1);
                                    // cubitAddProduct.mainImageProductFile =
                                    //     cubitAddImage.getIamgeFile(numBox: 1);
                                    // print("image path main = ${cubitAddProduct.mainImageProduct}");
                                  },
                                  isForMainImage: true,
                                  containerWidth: 400.w,
                                  mainContainerHeight: 210.h,
                                  upContainerHeight: 175.h,
                                  downContainerHeight: 35.h,
                                  onPressed: () {},
                                ),
                                SizedBox(height: 25.0.h),
                                // Add Sub images
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomAddImageWidget(
                                      imagePartNumber: 2,
                                      // image: cubitAddImage.subOneImageProduct,
                                      onTapPickImage: () async {
                                        // await cubitAddImage.pickImageFromGallery(numPartImage: 2);
                                        // cubitAddProduct.subOneImageProductFile =
                                        //     cubitAddImage.getIamgeFile(numBox: 2);
                                        // print(
                                        //     "image path sub 1 = ${cubitAddProduct.subOneImageProduct}");
                                      },
                                      onPressed: () {},
                                    ),
                                    CustomAddImageWidget(
                                      imagePartNumber: 3,
                                      // image: cubitAddImage.subOneImageProduct,
                                      onTapPickImage: () async {
                                        // await cubitAddImage.pickImageFromGallery(numPartImage: 3);
                                        // cubitAddProduct.subTwoImageProductFile =
                                        //     cubitAddImage.getIamgeFile(numBox: 3);
                                        // print(
                                        //     "image path sub 2 = ${cubitAddProduct.subTwoImageProduct}");
                                      },
                                      onPressed: () {},
                                    ),
                                    CustomAddImageWidget(
                                      imagePartNumber: 4,
                                      // image: cubitAddImage.subOneImageProduct,
                                      onTapPickImage: () async {
                                        // await cubitAddImage.pickImageFromGallery(numPartImage: 4);
                                        // cubitAddProduct.subThreeImageProductFile =
                                        //     cubitAddImage.getIamgeFile(numBox: 4);
                                        // print(
                                        //     "image path sub 3 = ${cubitAddProduct.subThreeImageProduct}");
                                      },
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.greyBorder),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                // container Title
                                SectionTitleWidget(title: 'نوع المنتج'),
                                SizedBox(height: 20.h),
                                BlocBuilder<GetCategoryNamesCubit,
                                    GetCategoryNamesState>(
                                  builder: (context, state) {
                                    if (state is GetCategoryNamesInitial) {
                                      // عند فتح الصفحة قبل تنفيذ دالة الجلب لابد أن تعطية شكل إفتراضي
                                      return const GetCategoryNamesInitialWidget();
                                    }
                                    if (state is GetCategoryNamesLoading) {
                                      print(
                                          "جارررررررررررررررررررررررري التحميييييييييييييييل");
                                      return const GetCategoryNamesLoadingWidget();
                                    }
                                    if (state is GetCategoryNamesSuccess) {
                                      // shortuct to access [AddProductToStoreCubit]
                                      final AddProductToStoreCubit
                                          cubitAddProduct = context
                                              .read<AddProductToStoreCubit>();
                                      // shortuct to access [GetCategoryNamesCubit]
                                      final GetCategoryNamesCubit
                                          cubitCategories =
                                          context.read<GetCategoryNamesCubit>();

                                      final List<MainCategoryEntity>
                                          mainAndSubCategories =
                                          state.categoryAndSubCategoryNames;

                                      cubitAddProduct.selectedSubCategoryId =
                                          cubitCategories.selectedSubCategories
                                                  .isNotEmpty
                                              ? cubitCategories
                                                  .selectedSubCategories
                                                  .first
                                                  .subCategoryId
                                              : null;

                                      return GetCategoryNamesSuccessWidget(
                                          mainAndSubCategories:
                                              mainAndSubCategories,
                                          cubitCategories: cubitCategories,
                                          cubitAddProduct: cubitAddProduct);
                                    }

                                    if (state is GetCategoryNamesFailure) {
                                      print(
                                          "فششششششششششششششل التحميييييييييييييييل");
                                      print(state.errMessage);

                                      return const GetCategoryNamesFailureWidget();
                                    }
                                    // عند حدوث خطأ غير معروف
                                    return const GetCategoryNamesElseWidget();
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 26.h),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                              color: AppColors.white,
                              border: Border.all(color: AppColors.greyBorder),
                              borderRadius: BorderRadius.circular(10)),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SectionTitleWidget(title: "خصائص المنتج"),
                                  SizedBox(height: 20.h),
                                  BlocBuilder<AddAttributeProductDartCubit,
                                          AddAttributeProductDartState>(
                                      builder: (context, state) {
                                    if (state
                                        is AddAttributeProductDartSuccess) {
                                      return SizedBox(
                                        child: Column(
                                          children: List.generate(
                                              state.keys.length, (index) {
                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 5.0.h),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  CustomSimpleTextFormField(
                                                    textController:
                                                        TextEditingController(
                                                            text:
                                                                'cubitAttribute.values[index]'),
                                                    hintText: 'خاصية',
                                                  ),
                                                  SizedBox(width: 20.w),
                                                  CustomSimpleTextFormField(
                                                    textController:
                                                        TextEditingController(
                                                            text:
                                                                'cubitAttribute.values[index]'),
                                                    hintText: 'قيمة',
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.remove_circle,
                                                        size: 20),
                                                    onPressed: () {
                                                      // cubitAttribute.removeField(index);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        ),
                                      );
                                    }
                                    return SizedBox(); //  working [if in Initial state or else]
                                  }),
                                  Center(
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        InkWell(
                                          onTap: () {
                                            // cubitAttribute.addField();
                                          },
                                          child: const SizedBox(
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons
                                                      .add_circle_outline_sharp,
                                                  size: 20,
                                                  color: AppColors.primary,
                                                ),
                                                Text(" أضف المزيد"),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20.h),
                // for tow Button in down
                TwoButtonInDownAddproduct(),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
