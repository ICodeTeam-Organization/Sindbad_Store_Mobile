import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import '../../../../../core/setup_service_locator.dart';
import '../../data/repos/add_product_store_repo_impl.dart';
import '../../domain/entities/add_product_entities/brand_entity.dart';
import '../../domain/entities/add_product_entities/main_category_entity.dart';
import '../../domain/entities/add_product_entities/sub_category_entity.dart';
import '../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../../domain/entities/edit_product_entities/product_images_entity.dart';
import '../../domain/usecases/get_main_and_sub_category_use_case.dart';
import '../manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import '../manger/cubit/brands_by_main_category_id/cubit/get_brands_by_category_id_cubit.dart';
import '../manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import '../widgets/custom_add_image_widget.dart';
import '../widgets/custom_box_add_image_for_edit_product_screen.dart';
import '../widgets/custom_card_contains_all_drop_down_edit_screen.dart';
import '../widgets/custom_dropdown_widget.dart';
import '../widgets/custom_dropdown_widget_for_state_cubit.dart';
import '../widgets/custom_simple_text_form_field.dart';
import '../widgets/custom_text_form_widget.dart';

class EditProductScreenBody extends StatefulWidget {
  // final int productId;
  final ProductDetailsEntity productDetailsEntity;

  const EditProductScreenBody({
    super.key,
    required this.productDetailsEntity,
    // required this.productId,
  });

  @override
  State<EditProductScreenBody> createState() => _EditProductScreenBodyState();
}

class _EditProductScreenBodyState extends State<EditProductScreenBody> {
  late TextEditingController _priceProductController = TextEditingController();
  late TextEditingController _descriptionProductController =
      TextEditingController();
  late List<ProductImagesEntity> subImagesProduct;
  // void d(BuildContext context) {
  // context
  //     .read<GetCategoryNamesCubit>()
  //     .getMainAndSubCategory(filterType: 2, pageNumper: 1, pageSize: 100);
  // }
  // final List<TextEditingController> _keys = [];
  // final List<TextEditingController> _values = [];

  @override
  void initState() {
    _priceProductController = TextEditingController(
        text: widget.productDetailsEntity.priceProduct.toString());
    _descriptionProductController = TextEditingController(
        text: widget.productDetailsEntity.descriptionProduct.toString());
    subImagesProduct = widget.productDetailsEntity.imagesProduct;

    super.initState();
    // Initialize controllers with fake data
    // widget.properties.forEach((key, value) {
    //   _keys.add(TextEditingController(text: key));
    //   _values.add(TextEditingController(text: value));
    // });
  }

  @override
  void dispose() {
    // for (var controller in _keys) {
    //   controller.dispose();
    // }
    // for (var controller in _values) {
    //   controller.dispose();
    // }
    super.dispose();
  }

  // void _addField() {
  //   setState(() {
  //     _keys.add(TextEditingController());
  //     _values.add(TextEditingController());
  //   });
  // }

  // void _removeField(int index) {
  //   setState(() {
  //     _keys.removeAt(index);
  //     _values.removeAt(index);
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    final AddAttributeProductDartCubit cubitAttribute =
        context.read<AddAttributeProductDartCubit>();
    // context
    //     .read<GetCategoryNamesCubit>()
    //     .getMainAndSubCategory(filterType: 2, pageNumper: 1, pageSize: 100);
    // تحديث البراند
    // context.read<GetBrandsByCategoryIdCubit>().getBrandsByMainCategoryId(
    //     mainCategoryId: widget.productDetailsEntity.mainCategoryIdProduct);
    // shortuct to access [GetCategoryNamesCubit]
    // final GetCategoryNamesCubit cubitCategories =
    //     context.read<GetCategoryNamesCubit>();
    // shortuct to access [EditProductFromStoreCubit]
    final EditProductFromStoreCubit cubitEditProduct =
        context.read<EditProductFromStoreCubit>();
    // loop to add attribute product from getProductDetails
    for (int i = 0;
        i < widget.productDetailsEntity.attributesWithValuesProduct.length;
        i++) {
      cubitAttribute.keys.add(TextEditingController(
          text: widget.productDetailsEntity.attributesWithValuesProduct[i]
              .attributeNameProduct));
      cubitAttribute.values.add(TextEditingController(
          text: widget.productDetailsEntity.attributesWithValuesProduct[i]
              .valueProduct[0]));
    }

    // /// for Main category Id
    // cubitEditProduct.selectedMainCategoryId =
    //     widget.productDetailsEntity.mainCategoryIdProduct;
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
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
                          margin: EdgeInsets.only(
                            bottom: 20.0.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    style: KTextStyle.textStyle16
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              CustomTextFormWidget(
                                textController: TextEditingController(
                                    text: widget
                                        .productDetailsEntity.nameProduct),
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
                                      textController: _priceProductController,
                                      text: 'السعر',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                    SizedBox(width: 36.0.w),
                                    CustomTextFormWidget(
                                      textController: TextEditingController(
                                          text: widget.productDetailsEntity
                                              .numberProduct),
                                      text: 'رقم المنتج',
                                      width: 147.0.w,
                                      height: 65.h,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 10.0.h),
                              CustomTextFormWidget(
                                textController: _descriptionProductController,
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
                      // ================  card Images  ===================
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0.r),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 363.0.w,
                          height: 434.0.h,
                          margin: EdgeInsets.only(
                            bottom: 20.0.h,
                          ),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
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
                                    style: KTextStyle.textStyle16
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              // ========  for Main Image  =======
                              CustomBoxAddImageForEditProductScreen(
                                initialImageUrl: widget
                                    .productDetailsEntity.mainImageUrlProduct,
                                boxNumber: 1,
                                containerWidth: 333,
                                mainContainerHeight: 210,
                                upContainerHeight: 175,
                                downContainerHeight: 35,
                                onImageSelected: (value) {
                                  cubitEditProduct.saveImageInCubit(
                                      boxNum: 1, file: value);
                                },
                              ),
                              SizedBox(height: 25.h),
                              // ========  for 3 Sub Images  =======
                              Padding(
                                // padding: EdgeInsets.only(left: 14.w),
                                padding: EdgeInsets.symmetric(horizontal: 14.w),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    CustomBoxAddImageForEditProductScreen(
                                      boxNumber: 2,
                                      initialImageUrl: subImagesProduct
                                              .isNotEmpty
                                          ? subImagesProduct[0].imageUrlProduct
                                          : null,
                                      onImageSelected: (value) {
                                        cubitEditProduct.saveImageInCubit(
                                            boxNum: 2, file: value);
                                      },
                                    ),
                                    CustomBoxAddImageForEditProductScreen(
                                      boxNumber: 3,
                                      initialImageUrl: subImagesProduct.length >
                                              1
                                          ? subImagesProduct[1].imageUrlProduct
                                          : null,
                                      onImageSelected: (value) {
                                        cubitEditProduct.saveImageInCubit(
                                            boxNum: 3, file: value);
                                      },
                                    ),
                                    CustomBoxAddImageForEditProductScreen(
                                      boxNumber: 4,
                                      initialImageUrl: subImagesProduct.length >
                                              2
                                          ? subImagesProduct[2].imageUrlProduct
                                          : null,
                                      onImageSelected: (value) {
                                        cubitEditProduct.saveImageInCubit(
                                            boxNum: 4, file: value);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              // SizedBox(height: 25.0.h),
                              // Padding(
                              //   padding: EdgeInsets.only(left: 14.w),
                              //   child: Row(
                              //     children: [
                              //       if (widget.subImages.isNotEmpty)
                              //         CustomAddImageWidget(
                              //           initialImageUrl: widget.subImages[0],
                              //           onPressed: () {},
                              //         ),
                              //       if (widget.subImages.length > 1)
                              //         SizedBox(width: 15.0.w),
                              //       if (widget.subImages.length > 1)
                              //         CustomAddImageWidget(
                              //           initialImageUrl: widget.subImages[1],
                              //           onPressed: () {},
                              //         ),
                              //       if (widget.subImages.length > 2)
                              //         SizedBox(width: 15.0.w),
                              //       if (widget.subImages.length > 2)
                              //         CustomAddImageWidget(
                              //           initialImageUrl: widget.subImages[2],
                              //           onPressed: () {},
                              //         ),
                              //     ],
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      // ================  card Drop down  ===================
                      CustomCardContainsAllDropDownEditScreen(
                        initialMainIdToProduct:
                            widget.productDetailsEntity.mainCategoryIdProduct,
                        initialSubIdToProduct:
                            widget.productDetailsEntity.subCategoryIdProduct[0],
                        initialBrandIdToProduct:
                            widget.productDetailsEntity.brandIdProduct,
                        initialMainNameToProduct:
                            widget.productDetailsEntity.mainCategoryNameProduct,
                        initialSubNameToProduct:
                            widget.productDetailsEntity.subCategoriesName,
                        initialBrandNameToProduct:
                            widget.productDetailsEntity.brandNameProduct,
                      ),
                      SizedBox(height: 26.h),
                      // ====================  Attributr card =============================
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
                                      bottom: 14.h,
                                      top: 10.h,
                                      right: 14.w,
                                    ),
                                    child: Text(
                                      " خصائص المنتج",
                                      style: KTextStyle.textStyle16.copyWith(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: BlocBuilder<
                                      AddAttributeProductDartCubit,
                                      AddAttributeProductDartState>(
                                    builder: (context, state) {
                                      if (state
                                          is AddAttributeProductDartSuccess) {
                                        return AddAttributeProductDartSuccessForEditPage(
                                            cubitAttribute: cubitAttribute);
                                      }
                                      return Column(
                                        children: [
                                          ...List.generate(
                                            cubitAttribute.keys.length,
                                            (index) {
                                              return Padding(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 5.0.h),
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    CustomSimpleTextFormField(
                                                      textController:
                                                          cubitAttribute
                                                              .keys[index],
                                                      hintText: 'خاصية',
                                                    ),
                                                    SizedBox(width: 20.w),
                                                    CustomSimpleTextFormField(
                                                      textController:
                                                          cubitAttribute
                                                              .values[index],
                                                      hintText: 'قيمة',
                                                    ),
                                                    IconButton(
                                                      icon: Icon(
                                                          Icons.remove_circle,
                                                          size: 20),
                                                      onPressed: () {
                                                        cubitAttribute
                                                            .removeField(index);
                                                      },
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                          Center(
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    cubitAttribute.addField();
                                                  },
                                                  child: const SizedBox(
                                                    child: Row(
                                                      children: [
                                                        Icon(
                                                          Icons
                                                              .add_circle_outline_sharp,
                                                          size: 20,
                                                          color:
                                                              AppColors.primary,
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
                                      );
                                      //  working [if in Initial state or else]
                                    },
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
              // ==================== Two Button in Down  =============================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  StorePrimaryButton(
                    title: "تأكيد",
                    width: 251.w,
                    height: 44.h,
                    buttonColor: AppColors.primary,
                    onTap: () {
                      // Handle confirmation

                      // for test
                      cubitEditProduct.testEditProductRequest(
                          priceProductController: _priceProductController.text,
                          descriptionProductController:
                              _descriptionProductController.text,
                          keys: cubitAttribute.keys,
                          values: cubitAttribute.values);
                    },
                  ),
                  SizedBox(width: 8.w),
                  StorePrimaryButton(
                    onTap: () {
                      debugPrint(
                          "=======  basic mainId = ${widget.productDetailsEntity.mainCategoryIdProduct.toString()}");
                      debugPrint(
                          "=======  basic subId = ${widget.productDetailsEntity.subCategoryIdProduct[0].toString()}");
                      debugPrint(
                          "=======  basic brandId = ${widget.productDetailsEntity.brandIdProduct.toString()}");
                      cubitEditProduct.testDropDown();
                      debugPrint(
                          "=======  basic isInitial = ${cubitEditProduct.isInitialDropDown.toString()}");
                      debugPrint(
                          "=======  basic mainCategoryName = ${widget.productDetailsEntity.mainCategoryNameProduct.toString()}");
                      debugPrint(
                          "=======  basic subCategoriesName = ${widget.productDetailsEntity.subCategoriesName.toString()}");
                      debugPrint(
                          "=======  basic brandName = ${widget.productDetailsEntity.brandNameProduct.toString()}");
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

class AddAttributeProductDartSuccessForEditPage extends StatelessWidget {
  const AddAttributeProductDartSuccessForEditPage({
    super.key,
    required this.cubitAttribute,
  });

  final AddAttributeProductDartCubit cubitAttribute;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ...List.generate(
          cubitAttribute.keys.length,
          (index) {
            return Padding(
              padding: EdgeInsets.symmetric(vertical: 5.0.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomSimpleTextFormField(
                    textController: cubitAttribute.keys[index],
                    hintText: 'خاصية',
                  ),
                  SizedBox(width: 20.w),
                  CustomSimpleTextFormField(
                    textController: cubitAttribute.values[index],
                    hintText: 'قيمة',
                  ),
                  IconButton(
                    icon: Icon(Icons.remove_circle, size: 20),
                    onPressed: () {
                      cubitAttribute.removeField(index);
                    },
                  ),
                ],
              ),
            );
          },
        ),
        Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  cubitAttribute.addField();
                },
                child: const SizedBox(
                  child: Row(
                    children: [
                      Icon(
                        Icons.add_circle_outline_sharp,
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
    );
  }
}
