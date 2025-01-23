import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import '../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../../domain/entities/edit_product_entities/product_images_entity.dart';
import '../manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import '../manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import '../widgets/custom_box_add_image_for_edit_product_screen.dart';
import '../widgets/custom_card_contains_all_drop_down_edit_screen.dart';
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
    _priceProductController.dispose();
    _descriptionProductController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final AddAttributeProductDartCubit cubitAttribute =
        context.read<AddAttributeProductDartCubit>();

    final EditProductFromStoreCubit cubitEditProduct =
        context.read<EditProductFromStoreCubit>();
    cubitEditProduct.saveBasicSubImages(
        basicSubImages: widget.productDetailsEntity.imagesProduct
            .map((image) => image.imageUrlProduct)
            .toList());
    // loop to add attribute product from getProductDetails to cubit Attribute
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

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                isSearch: false,
                tital: 'إضافة منتج',
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
                              SectionTitleWidget(title: 'معلومات المنتج'),
                              SizedBox(height: 20.h),
                              CustomTextFormWidget(
                                enabled: false,
                                textController: TextEditingController(
                                    text: widget
                                        .productDetailsEntity.nameProduct),
                                text: 'أسم المنتج',
                                height: 65.h,
                                width: 400.w,
                              ),
                              SizedBox(height: 20.h),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomTextFormWidget(
                                    textController: _priceProductController,
                                    text: 'السعر',
                                    width: 130.w,
                                    height: 65.h,
                                  ),
                                  CustomTextFormWidget(
                                    enabled: false,
                                    textController: TextEditingController(
                                        text: widget.productDetailsEntity
                                            .numberProduct),
                                    text: 'رقم المنتج',
                                    width: 130.w,
                                    height: 65.h,
                                  ),
                                ],
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormWidget(
                                textController: _descriptionProductController,
                                text: 'وصف المنتج',
                                width: 400.w,
                                height: 200.h,
                                maxLines: 5,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),
                      // ================  card Images  ===================
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
                              // ========  for Main Image  =======
                              CustomBoxAddImageForEditProductScreen(
                                initialImageUrl: widget
                                    .productDetailsEntity.mainImageUrlProduct,
                                boxNumber: 1,
                                containerWidth: 400.w,
                                mainContainerHeight: 210.h,
                                upContainerHeight: 175.h,
                                downContainerHeight: 35.h,
                                onImageSelected: (value) {
                                  cubitEditProduct.saveImageInCubit(
                                      boxNum: 1, file: value);
                                },
                              ),
                              SizedBox(height: 25.h),
                              // ========  for 3 Sub Images  =======
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  CustomBoxAddImageForEditProductScreen(
                                    boxNumber: 2,
                                    initialImageUrl: subImagesProduct.isNotEmpty
                                        ? subImagesProduct[0].imageUrlProduct
                                        : null,
                                    onImageSelected: (value) {
                                      cubitEditProduct.saveImageInCubit(
                                          boxNum: 2, file: value);
                                    },
                                  ),
                                  CustomBoxAddImageForEditProductScreen(
                                    boxNumber: 3,
                                    initialImageUrl: subImagesProduct.length > 1
                                        ? subImagesProduct[1].imageUrlProduct
                                        : null,
                                    onImageSelected: (value) {
                                      cubitEditProduct.saveImageInCubit(
                                          boxNum: 3, file: value);
                                    },
                                  ),
                                  CustomBoxAddImageForEditProductScreen(
                                    boxNumber: 4,
                                    initialImageUrl: subImagesProduct.length > 2
                                        ? subImagesProduct[2].imageUrlProduct
                                        : null,
                                    onImageSelected: (value) {
                                      cubitEditProduct.saveImageInCubit(
                                          boxNum: 4, file: value);
                                    },
                                  ),
                                ],
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
                      // ====================  Attribute card =============================
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
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  CustomSimpleTextFormField(
                                                    textController:
                                                        cubitAttribute
                                                            .keys[index],
                                                    hintText: 'خاصية',
                                                  ),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              // ==================== Two Button in Down  =============================
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocConsumer<EditProductFromStoreCubit,
                        EditProductFromStoreState>(
                      listener: (context, state) {
                        if (state is EditProductFromStoreSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('تم تعديل المنتج بنجاح!')),
                          );
                          // Trigger the callback to refresh parent screen
                          // if (onSuccessCallback != null) {
                          //   onSuccessCallback!();
                          // }
                          // context.go(AppRouter.storeRouters.root);
                          Navigator.of(context).pop(); // close Edit pruduct
                          // context.go(AppRouter.storeRouters.root);
                          // ====  to refrech view pruduct page ====
                          // contextPerant
                          //     .read<GetStoreProductsWithFilterCubit>()
                          //     .getStoreProductsWitheFilter(
                          //       storeProductsFilter: storeProductsFilter,
                          //       pageNumper: 1,
                          //       pageSize: 100,
                          //     );
                        } else if (state is EditProductFromStoreFailure) {
                          debugPrint(state.errMessage);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.errMessage)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return StorePrimaryButton(
                          isLoading: state is EditProductFromStoreLoading,
                          title: "تأكيد",
                          width: 200.w,
                          height: 50.h,
                          buttonColor: AppColors.primary,
                          onTap: () {
                            // Handle confirmation
                            cubitEditProduct.editProductFromStore(
                              productId: widget.productDetailsEntity.idProduct,
                              priceProductController: _priceProductController,
                              descriptionProductController:
                                  _descriptionProductController,
                              keys: cubitAttribute.keys,
                              values: cubitAttribute.values,
                            );
                          },
                        );
                      },
                    ),
                    SizedBox(width: 8.w),
                    StorePrimaryButton(
                      onTap: () {
                        Navigator.of(context).pop(); // close Edit product
                        // for test
                        // debugPrint(
                        //     "=======  basic mainId = ${widget.productDetailsEntity.mainCategoryIdProduct.toString()}");
                        // debugPrint(
                        //     "=======  basic subId = ${widget.productDetailsEntity.subCategoryIdProduct[0].toString()}");
                        // debugPrint(
                        //     "=======  basic brandId = ${widget.productDetailsEntity.brandIdProduct.toString()}");
                        // cubitEditProduct.testDropDown();
                        // debugPrint(
                        //     "=======  basic isInitial = ${cubitEditProduct.isInitialDropDown.toString()}");
                        // debugPrint(
                        //     "=======  basic mainCategoryName = ${widget.productDetailsEntity.mainCategoryNameProduct.toString()}");
                        // debugPrint(
                        //     "=======  basic subCategoriesName = ${widget.productDetailsEntity.subCategoriesName.toString()}");
                        // debugPrint(
                        //     "=======  basic brandName = ${widget.productDetailsEntity.brandNameProduct.toString()}");
                        // debugPrint(
                        //     "==============================================================================");
                        // // for test
                        // cubitEditProduct.testEditProductRequest(
                        //     priceProductController: _priceProductController.text,
                        //     descriptionProductController:
                        //         _descriptionProductController.text,
                        //     keys: cubitAttribute.keys,
                        //     values: cubitAttribute.values);
                      },
                      title: "إلغاء",
                      width: 100.w,
                      height: 50.h,
                      buttonColor: AppColors.greyIcon,
                    ),
                  ],
                ),
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
