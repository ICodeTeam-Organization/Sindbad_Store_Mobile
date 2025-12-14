import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/attribute_product/attribute_product_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/edit_product_from_store/edit_product_from_store_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_simple_text_form_field.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/get_category_names_success_widget.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';
import '../widgets/imagePicker.dart';

class UpdateProductPage extends StatefulWidget {
  final int productId;

  const UpdateProductPage({
    super.key,
    required this.productId,
  });

  @override
  State<UpdateProductPage> createState() => _UpdateProductPageState();
}

class _UpdateProductPageState extends State<UpdateProductPage> {
  @override
  void initState() {
    super.initState();
    // Fetch product details on initialization
    context
        .read<ProductDetailsCubit>()
        .getProductDetails(productId: widget.productId);
  }

  // Controllers for product info
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController numberProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();
  final TextEditingController descriptionProductController =
      TextEditingController();
  final TextEditingController oldPriceController = TextEditingController();
  final TextEditingController shortDescriptionController =
      TextEditingController();

  final List<String> tags = [];

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // To track if controllers have been populated
  bool _isDataLoaded = false;

  @override
  void dispose() {
    nameProductController.dispose();
    numberProductController.dispose();
    priceProductController.dispose();
    descriptionProductController.dispose();
    oldPriceController.dispose();
    shortDescriptionController.dispose();
    super.dispose();
  }

  /// Populate controllers with product details
  void _populateControllers(ProductDetailsSuccess state) {
    if (!_isDataLoaded) {
      final product = state.productDetailsEntity;
      nameProductController.text = product.nameProduct ?? '';
      numberProductController.text = product.numberProduct ?? '';
      priceProductController.text = product.priceProduct.toString() ?? '';
      descriptionProductController.text = product.descriptionProduct ?? '';
      oldPriceController.text = product.productOldPrice?.toString() ?? '';
      shortDescriptionController.text = product.productShortDescription ?? '';

      // Set category and brand IDs in the edit cubit
      //final editCubit = context.read<EditProductFromStoreCubit>();
      //editCubit.selectedMainCategoryId = product.mainCategoryIdProduct;
      //editCubit.selectedSubCategoryId = 0;
      //editCubit.selectedBrandId = product.brandIdProduct;

      // Save existing images URLs
      // if (product.images != null && product.images!.isNotEmpty) {
      //   editCubit.saveBasicSubImages(basicSubImages: product.images!);
      // }

      _isDataLoaded = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<ProductDetailsCubit, ProductDetailsState>(
        listener: (context, state) {
          if (state is ProductDetailsSuccess) {
            _populateControllers(state);
            setState(() {}); // Trigger rebuild to show data
          }
          if (state is ProductDetailsFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content:
                      Text('فشل في تحميل بيانات المنتج: ${state.errMessage}')),
            );
          }
        },
        child: BlocBuilder<ProductDetailsCubit, ProductDetailsState>(
          builder: (context, detailsState) {
            if (detailsState is ProductDetailsLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(height: 25.h),
                    CustomAppBar(
                      isSearch: false,
                      tital: 'تعديل المنتج',
                    ),
                    SizedBox(height: 10.h),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            // ================= for text fields =========
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionTitleWidget(title: 'معلومات المنتج'),
                                    SizedBox(height: 20.h),
                                    CustomTextFormWidget(
                                      textController: nameProductController,
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
                                          keyboardType: TextInputType.number,
                                          textController:
                                              priceProductController,
                                          text: 'السعر',
                                          width: 130.w,
                                          height: 65.h,
                                        ),
                                        SizedBox(width: 20.w),
                                        CustomTextFormWidget(
                                          keyboardType: TextInputType.number,
                                          textController:
                                              numberProductController,
                                          text: 'رقم المنتج',
                                          width: 130.w,
                                          height: 65.h,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    CustomTextFormWidget(
                                      keyboardType: TextInputType.number,
                                      textController: oldPriceController,
                                      text: 'السعر السابق',
                                      isRequired: false,
                                    ),
                                    SizedBox(height: 20.h),
                                    CustomTextFormWidget(
                                      textController:
                                          shortDescriptionController,
                                      text: 'وصف مختصر',
                                      isRequired: false,
                                      maxLines: 3,
                                      width: 400.w,
                                      height: 130.h,
                                    ),
                                    SizedBox(height: 20.h),
                                    CustomTextFormWidget(
                                      textController:
                                          descriptionProductController,
                                      text: 'الوصف الكامل',
                                      isRequired: true,
                                      maxLines: 5,
                                      width: 400.w,
                                      height: 180.h,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 26.h),

                            //  ================= for Edit Images =========
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionTitleWidget(
                                        title: "تعديل صور المنتج"),
                                    SizedBox(height: 20.h),
                                    // CustomBoxAddImageForAddAndEditProductScreen
                                    //     .CustomBoxAddImageForAddAndEditProductScreen(
                                    //   // cubitEditProduct: context
                                    //   //     .read<EditProductFromStoreCubit>(),
                                    //   boxNumber: 1,
                                    //   initialImageUrl:
                                    //       detailsState is ProductDetailsSuccess
                                    //           ? detailsState
                                    //               .productDetailsEntity
                                    //               .mainImageUrlProduct
                                    //           : null,
                                    //   containerWidth: 400.w,
                                    //   mainContainerHeight: 210.h,
                                    //   upContainerHeight: 175.h,
                                    //   downContainerHeight: 35.h,
                                    //   onImageSelected: (value) {
                                    //     //   context
                                    //     //       .read<EditProductFromStoreCubit>()
                                    //     //       .saveImageInCubit(
                                    //     //           boxNum: 1, file: value);
                                    //   },
                                    // ),
                                    SizedBox(height: 25.h),
                                    // ========  for 3 Sub Images  =======
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        // CustomBoxAddImageForAddAndEditProductScreen
                                        //     .CustomBoxAddImageForAddAndEditProductScreen(
                                        //   // cubitEditProduct: context.read<
                                        //   //     EditProductFromStoreCubit>(),
                                        //   boxNumber: 2,
                                        // //  initialImageUrl: context
                                        //       // .read<EditProductFromStoreCubit>()
                                        //       // .subOneImageProductUrl,
                                        //   onImageSelected: (value) {
                                        //     context
                                        //         .read<
                                        //             EditProductFromStoreCubit>()
                                        //         .saveImageInCubit(
                                        //             boxNum: 2, file: value);
                                        //   },
                                        // ),
                                        // CustomBoxAddImageForAddAndEditProductScreen
                                        //     .CustomBoxAddImageForAddAndEditProductScreen(
                                        //   // cubitEditProduct: context.read<
                                        //   //     EditProductFromStoreCubit>(),
                                        //   boxNumber: 3,
                                        //   // initialImageUrl: context
                                        //   //     .read<EditProductFromStoreCubit>()
                                        //   //     .subTwoImageProductUrl,
                                        //   onImageSelected: (value) {
                                        //     context
                                        //         .read<
                                        //             EditProductFromStoreCubit>()
                                        //         .saveImageInCubit(
                                        //             boxNum: 3, file: value);
                                        //   },
                                        //  ),
                                        // CustomBoxAddImageForAddAndEditProductScreen
                                        //     .CustomBoxAddImageForAddAndEditProductScreen(
                                        //   // cubitEditProduct: context.read<
                                        //   //     EditProductFromStoreCubit>(),
                                        //   boxNumber: 4,
                                        //   initialImageUrl: context
                                        //       .read<EditProductFromStoreCubit>()
                                        //       .subThreeImageProductUrl,
                                        //   onImageSelected: (value) {
                                        //     context
                                        //         .read<
                                        //             EditProductFromStoreCubit>()
                                        //         .saveImageInCubit(
                                        //             boxNum: 4, file: value);
                                        //   },
                                        // ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 26.h),

                            //  ================= for drop down =========
                            GetCategoryNamesSuccessWidget(
                              mainAndSubCategories: [],
                            ),
                            SizedBox(height: 26.h),

                            // ================= for Attributes Fields =========
                            Container(
                              width: double.maxFinite,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border:
                                      Border.all(color: Colors.grey.shade300),
                                  borderRadius: BorderRadius.circular(10)),
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionTitleWidget(title: "خصائص المنتج"),
                                    SizedBox(height: 20.h),
                                    SizedBox(
                                      child: BlocBuilder<AttributeProductCubit,
                                              AttributeProduct>(
                                          builder: (context, state) {
                                        return Column(
                                          children: List.generate(
                                              state.keys.length, (index) {
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
                                                        state.keys[index],
                                                    hintText: 'خاصية',
                                                  ),
                                                  CustomSimpleTextFormField(
                                                    textController:
                                                        state.values[index],
                                                    hintText: 'قيمة',
                                                  ),
                                                  IconButton(
                                                    icon: Icon(
                                                        Icons.remove_circle,
                                                        size: 20.sp),
                                                    onPressed: () {
                                                      // context
                                                      //     .read<
                                                      //         AttributeProductCubit>()
                                                      //     .removeField(index);
                                                    },
                                                  ),
                                                ],
                                              ),
                                            );
                                          }),
                                        );
                                      }),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              // context
                                              //     .read<AttributeProductCubit>()
                                              //     .addField();
                                            },
                                            child: const SizedBox(
                                              child: Row(
                                                children: [
                                                  Icon(
                                                    Icons
                                                        .add_circle_outline_sharp,
                                                    size: 20,
                                                    color: Color(0xFF1E88E5),
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
                          ],
                        ),
                      ),
                    ),
                    // for two Buttons at bottom
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          StorePrimaryButton(
                            onTap: () =>
                                context.read<ProductsCubit>().updateProduct(),
                            title: "حفظ",
                            width: 100.w,
                            height: 50.h,
                            buttonColor: Colors.grey,
                          ),
                          // BlocConsumer<EditProductFromStoreCubit,
                          //     EditProductFromStoreState>(
                          //   listener: (context, state) {
                          //     if (state is EditProductFromStoreSuccess) {
                          //       Navigator.of(context).pop();
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text('تم تعديل المنتج بنجاح!')),
                          //       );
                          //     }
                          //     if (state is EditProductFromStoreFailure) {
                          //       ScaffoldMessenger.of(context).showSnackBar(
                          //         SnackBar(
                          //             content: Text(
                          //                 'فشل في تعديل المنتج: ${state.errMessage}')),
                          //       );
                          //     }
                          //   },
                          //   builder: (context, state) {
                          //     return StorePrimaryButton(
                          //       isLoading: state is EditProductFromStoreLoading,
                          //       onTap: () async {
                          //         if (_formKey.currentState!.validate()) {
                          //           final editCubit = context
                          //               .read<EditProductFromStoreCubit>();
                          //           final attributeState = context
                          //               .read<AttributeProductCubit>()
                          //               .state;

                          //           await editCubit.editProductFromStore(
                          //             productId: widget.productId,
                          //             priceProductController:
                          //                 priceProductController,
                          //             descriptionProductController:
                          //                 descriptionProductController,
                          //             keys: attributeState.keys,
                          //             values: attributeState.values,
                          //             oldPriceController: oldPriceController,
                          //             shortDescriptionProductController:
                          //                 shortDescriptionController,
                          //             tags: tags,
                          //           );
                          //         }
                          //       },
                          //       title: "حفظ التعديلات",
                          //       width: 280.w,
                          //       height: 50.h,
                          //       buttonColor: Color(0xFFFF746B),
                          //     );
                          //   },
                          // ),
                          SizedBox(width: 8.w),
                          StorePrimaryButton(
                            onTap: () => Navigator.of(context).pop(),
                            title: "الغاء",
                            width: 100.w,
                            height: 50.h,
                            buttonColor: Colors.grey,
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
