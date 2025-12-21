import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/ProductDetails/product_details_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_simple_text_form_field.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';
import 'package:sindbad_management_app/core/widgets/store_primary_button.dart';
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

  // Image files for product
  File? mainImageProductFile;
  File? subOneImageProductFile;
  File? subTwoImageProductFile;
  File? subThreeImageProductFile;

  // Existing image URLs (for edit mode)
  String? mainImageUrl;
  String? subOneImageUrl;
  String? subTwoImageUrl;
  String? subThreeImageUrl;

  final List<String> tags = [];

  // Attribute controllers
  List<TextEditingController> keys = [];
  List<TextEditingController> values = [];

  // Dropdown selection state
  int? mainCategoryId;
  int? subCategoryId;
  int? brandId;

  // Form key for validation
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Scroll controller for scrolling to top on validation error
  final ScrollController _scrollController = ScrollController();

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
    _scrollController.dispose();
    // Dispose attribute controllers
    for (var controller in keys) {
      controller.dispose();
    }
    for (var controller in values) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Populate controllers with product details
  void _populateControllers(ProductDetailsSuccess state) {
    if (!_isDataLoaded) {
      final product = state.productDetailsEntity;
      nameProductController.text = product.nameProduct ?? '';
      numberProductController.text = product.numberProduct ?? '';
      priceProductController.text = product.priceProduct.toString();
      descriptionProductController.text = product.descriptionProduct ?? '';
      oldPriceController.text = product.productOldPrice?.toString() ?? '';
      shortDescriptionController.text = product.productShortDescription ?? '';

      // Set existing image URLs
      mainImageUrl = product.mainImageUrlProduct;

      // Set category and brand IDs
      mainCategoryId = product.mainCategoryIdProduct;
      // subCategoryId = product.subCategoryIdProduct;
      brandId = product.brandIdProduct;

      // Populate existing images URLs if available
      // if (product.images != null && product.images!.isNotEmpty) {
      //   if (product.images!.length > 0) subOneImageUrl = product.images![0];
      //   if (product.images!.length > 1) subTwoImageUrl = product.images![1];
      //   if (product.images!.length > 2) subThreeImageUrl = product.images![2];
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
                controller: _scrollController,
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
                                      isRequired: true,
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
                                          isRequired: true,
                                        ),
                                        SizedBox(width: 20.w),
                                        CustomTextFormWidget(
                                          keyboardType: TextInputType.number,
                                          textController:
                                              numberProductController,
                                          text: 'رقم المنتج',
                                          width: 130.w,
                                          height: 65.h,
                                          isRequired: true,
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 20.h),
                                    CustomTextFormWidget(
                                      keyboardType: TextInputType.number,
                                      textController: oldPriceController,
                                      text: 'السعر السابق',
                                      width: 130.w,
                                      height: 65.h,
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
                                      isRequired: false,
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
                                    ImagePacker.Add(
                                      boxNumber: 1,
                                      initialImageUrl: mainImageUrl,
                                      containerWidth: 400.w,
                                      mainContainerHeight: 210.h,
                                      upContainerHeight: 175.h,
                                      downContainerHeight: 35.h,
                                      onImageSelected: (value) {
                                        mainImageProductFile = value;
                                      },
                                    ),
                                    SizedBox(height: 25.h),
                                    // ========  for 3 Sub Images  =======
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ImagePacker.Add(
                                          boxNumber: 2,
                                          initialImageUrl: subOneImageUrl,
                                          onImageSelected: (value) {
                                            subOneImageProductFile = value;
                                          },
                                        ),
                                        ImagePacker.Add(
                                          boxNumber: 3,
                                          initialImageUrl: subTwoImageUrl,
                                          onImageSelected: (value) {
                                            subTwoImageProductFile = value;
                                          },
                                        ),
                                        ImagePacker.Add(
                                          boxNumber: 4,
                                          initialImageUrl: subThreeImageUrl,
                                          onImageSelected: (value) {
                                            subThreeImageProductFile = value;
                                          },
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(height: 26.h),

                            //  ================= for drop down =========
                            CustomDropdownWidget(
                              enabled: true,
                              textTitle: 'أختر الفئة',
                              hintText: "قم بإختيار الفئة المناسبة",
                              initialItem: null,
                              items: [],
                              // TODO: Populate items from categories list
                              onChanged: (value) {
                                setState(() {
                                  // TODO: Get the actual category ID from the selected value
                                  // Reset dependent selections when main category changes
                                  subCategoryId = null;
                                  brandId = null;
                                });
                              },
                            ),
                            SizedBox(height: 16.h),
                            CustomDropdownWidget(
                              enabled: mainCategoryId != null,
                              textTitle: 'أختر القسم',
                              hintText: mainCategoryId != null
                                  ? "قم بإختيار القسم المناسب"
                                  : "إختر الفئة الأساسية أولا",
                              items: [],
                              // TODO: Populate items from sub-categories list
                              onChanged: (value) {
                                setState(() {
                                  // TODO: Get the actual sub-category ID from the selected value
                                });
                              },
                            ),
                            SizedBox(height: 16.h),
                            CustomDropdownWidget(
                              enabled: mainCategoryId != null,
                              textTitle: 'أختر اسم البراند',
                              hintText: mainCategoryId != null
                                  ? "قم بإختيار البراند المناسب"
                                  : "إختر الفئة الأساسية أولا",
                              isRequired: false,
                              items: [],
                              // TODO: Populate items from brands list
                              onChanged: (value) {
                                setState(() {
                                  // TODO: Get the actual brand ID from the selected value
                                });
                              },
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
                                      child: Column(
                                        children:
                                            List.generate(keys.length, (index) {
                                          return Padding(
                                            padding: EdgeInsets.symmetric(
                                                vertical: 5.0.h),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                CustomSimpleTextFormField(
                                                  textController: keys[index],
                                                  hintText: 'خاصية',
                                                ),
                                                CustomSimpleTextFormField(
                                                  textController: values[index],
                                                  hintText: 'قيمة',
                                                ),
                                                IconButton(
                                                  icon: Icon(
                                                      Icons.remove_circle,
                                                      size: 20.sp),
                                                  onPressed: () {
                                                    setState(() {
                                                      keys[index].dispose();
                                                      values[index].dispose();
                                                      keys.removeAt(index);
                                                      values.removeAt(index);
                                                    });
                                                  },
                                                ),
                                              ],
                                            ),
                                          );
                                        }),
                                      ),
                                    ),
                                    Center(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                keys.add(
                                                    TextEditingController());
                                                values.add(
                                                    TextEditingController());
                                              });
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
                            onTap: () async {
                              if (_formKey.currentState!.validate()) {
                                // Collect existing image URLs
                                final List<String> existingImageUrls = [
                                  if (subOneImageUrl != null) subOneImageUrl!,
                                  if (subTwoImageUrl != null) subTwoImageUrl!,
                                  if (subThreeImageUrl != null)
                                    subThreeImageUrl!,
                                ];

                                // Collect new image files
                                final List<File> newImageFiles = [
                                  if (subOneImageProductFile != null)
                                    subOneImageProductFile!,
                                  if (subTwoImageProductFile != null)
                                    subTwoImageProductFile!,
                                  if (subThreeImageProductFile != null)
                                    subThreeImageProductFile!,
                                ];

                                context.read<ProductsCubit>().updateProduct(
                                      productId: widget.productId,
                                      price: double.parse(
                                          priceProductController.text),
                                      description:
                                          descriptionProductController.text,
                                      mainImageFile: mainImageProductFile,
                                      images: newImageFiles.isNotEmpty
                                          ? newImageFiles
                                          : null,
                                      imagesUrl: existingImageUrls.isNotEmpty
                                          ? existingImageUrls
                                          : null,
                                      mainCategoryId: mainCategoryId ?? 0,
                                      subCategoryId: subCategoryId,
                                      brandId: brandId,
                                      attributeKeys: keys,
                                      attributeValues: values,
                                      oldPrice:
                                          oldPriceController.text.isNotEmpty
                                              ? double.parse(
                                                  oldPriceController.text)
                                              : null,
                                      shortDescription:
                                          shortDescriptionController.text,
                                      tags: tags.isNotEmpty ? tags : null,
                                    );
                              } else {
                                // Form is invalid, scroll to top to show errors
                                _scrollController.animateTo(
                                  0,
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            title: "حفظ التعديلات",
                            width: 280.w,
                            height: 50.h,
                            buttonColor: Color(0xFFFF746B),
                          ),
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
