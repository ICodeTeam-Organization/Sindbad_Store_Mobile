import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_dropdown_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_simple_text_form_field.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/widgets/custom_text_form_widget.dart';
import 'package:sindbad_management_app/core/widgets/store_primary_button.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/manager/products_cubit/products_cubit.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/imagePicker.dart';
import '../../../add_and_edit_product_feature/ui/manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';

class AddProductPage extends StatefulWidget {
  const AddProductPage({
    super.key,
  });

  @override
  State<AddProductPage> createState() => _AddProductPageState();
}

class _AddProductPageState extends State<AddProductPage> {
  @override
  void initState() {
    super.initState();
  }

  //Updated
  final TextEditingController nameProductController = TextEditingController();
  final TextEditingController numberProductController = TextEditingController();
  final TextEditingController priceProductController = TextEditingController();
  final TextEditingController oldPriceController = TextEditingController();
  final TextEditingController shortDescriptionController =
      TextEditingController();
  File? mainImageProductFile;
  File? subOneImageProductFile;
  File? subTwoImageProductFile;
  File? subThreeImageProductFile;
  final List<String> tags = [];
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

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(height: 25.h),
              CustomAppBar(
                isSearch: false,
                tital: l10n.addProduct,
              ),
              SizedBox(height: 10.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // ================= for text filed =========
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            border: Border.all(color: theme.dividerColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitleWidget(title: l10n.productInfo),
                              SizedBox(height: 20.h),
                              CustomTextFormWidget(
                                textController: nameProductController,
                                text: l10n.productName,
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
                                    textController: priceProductController,
                                    text: l10n.priceLabel,
                                    width: 130.w,
                                    height: 65.h,
                                    isRequired: true,
                                  ),
                                  SizedBox(width: 20.w),
                                  CustomTextFormWidget(
                                    keyboardType: TextInputType.number,
                                    textController: numberProductController,
                                    text: l10n.productNumberLabel,
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
                                text: l10n.oldPrice,
                                width: 130.w,
                                height: 65.h,
                                isRequired: false,
                              ),
                              SizedBox(height: 20.h),
                              CustomTextFormWidget(
                                textController: shortDescriptionController,
                                text: l10n.shortDescription,
                                isRequired: false,
                                maxLines: 3,
                                width: 400.w,
                                height: 130.h,
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 26.h),

                      //  ================= for Add Images =========
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            border: Border.all(color: theme.dividerColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitleWidget(
                                  title: l10n.selectProductImage),
                              SizedBox(height: 20.h),
                              ImagePacker.Add(
                                // cubitAddProduct:
                                //     context.read<AddProductToStoreCubit>(),
                                boxNumber: 1,
                                initialImageUrl: null,
                                containerWidth: 400.w,
                                mainContainerHeight: 210.h,
                                upContainerHeight: 175.h,
                                downContainerHeight: 35.h,
                                onImageSelected: (value) {
                                  mainImageProductFile = value;
                                  // context
                                  //     .read<AddProductToStoreCubit>()
                                  //     .saveImageInCubit(boxNum: 1, file: value);
                                },
                              ),
                              SizedBox(height: 25.h),
                              // ========  for 3 Sub Images  =======
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ImagePacker.Add(
                                    // cubitAddProduct:
                                    //     context.read<AddProductToStoreCubit>(),
                                    boxNumber: 2,
                                    initialImageUrl: null,
                                    onImageSelected: (value) {
                                      subOneImageProductFile = value;
                                      // context
                                      //     .read<AddProductToStoreCubit>()
                                      //     .saveImageInCubit(
                                      //         boxNum: 2, file: value);
                                    },
                                  ),
                                  ImagePacker.Add(
                                    // cubitAddProduct:
                                    //     context.read<AddProductToStoreCubit>(),
                                    boxNumber: 3,
                                    initialImageUrl: null,
                                    onImageSelected: (value) {
                                      subTwoImageProductFile = value;
                                      // context
                                      //     .read<AddProductToStoreCubit>()
                                      //     .saveImageInCubit(
                                      //         boxNum: 3, file: value);
                                    },
                                  ),
                                  ImagePacker.Add(
                                    // cubitAddProduct:
                                    //     context.read<AddProductToStoreCubit>(),
                                    boxNumber: 4,
                                    initialImageUrl: null,
                                    onImageSelected: (value) {
                                      subThreeImageProductFile = value;
                                      // context
                                      //     .read<AddProductToStoreCubit>()
                                      //     .saveImageInCubit(
                                      //         boxNum: 4, file: value);
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
                        textTitle: l10n.selectCategory,
                        hintText: l10n.selectCategoryHint,
                        initialItem: null,
                        items: [],
                        // TODO: Populate items from categories list
                        // items: mainAndSubCategories.isNotEmpty
                        //     ? mainAndSubCategories
                        //         .map((category) => category.categoryName)
                        //         .toList()
                        //     : [],
                        onChanged: (value) {
                          setState(() {
                            // TODO: Get the actual category ID from the selected value
                            // mainCategoryId = mainAndSubCategories
                            //     .firstWhere((cat) => cat.categoryName == value)
                            //     .categoryId;

                            // Reset dependent selections when main category changes
                            subCategoryId = null;
                            brandId = null;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomDropdownWidget(
                        enabled: mainCategoryId != null,
                        textTitle: l10n.selectSection,
                        hintText: mainCategoryId != null
                            ? l10n.selectSectionHint
                            : l10n.selectCategoryFirst,
                        items: [],
                        // TODO: Populate items from sub-categories list
                        onChanged: (value) {
                          setState(() {
                            // TODO: Get the actual sub-category ID from the selected value
                            // subCategoryId = subCategories
                            //     .firstWhere((cat) => cat.categoryName == value)
                            //     .categoryId;
                          });
                        },
                      ),
                      SizedBox(height: 16.h),
                      CustomDropdownWidget(
                        enabled: mainCategoryId != null,
                        textTitle: l10n.selectBrand,
                        hintText: mainCategoryId != null
                            ? l10n.selectBrandHint
                            : l10n.selectCategoryFirst,
                        isRequired: false,
                        items: [],
                        // TODO: Populate items from brands list
                        onChanged: (value) {
                          setState(() {
                            // TODO: Get the actual brand ID from the selected value
                            // brandId = brands
                            //     .firstWhere((brand) => brand.name == value)
                            //     .id;
                          });
                        },
                      ),
                      // GetCategoryNamesSuccessWidget(
                      //   mainAndSubCategories: [],
                      //   //  cubitCategories: cubitCategories,
                      //   //    cubitAddProduct: cubitAddProduct
                      // ),
                      // CustomCardToAllDropDown(
                      //     // cubitAddProduct: cubitAddProduct,
                      //     // cubitCategories: getCategoryNamesCubit,
                      //     ),
                      SizedBox(height: 26.h),
                      // ================= for Attributes Fields =========
                      Container(
                        width: double.maxFinite,
                        decoration: BoxDecoration(
                            color: theme.cardColor,
                            border: Border.all(color: theme.dividerColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SectionTitleWidget(title: l10n.productAttributes),
                              SizedBox(height: 20.h),
                              SizedBox(
                                child: Column(
                                  children: List.generate(keys.length, (index) {
                                    return Padding(
                                      padding:
                                          EdgeInsets.symmetric(vertical: 5.0.h),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          CustomSimpleTextFormField(
                                            textController: keys[index],
                                            hintText: l10n.attribute,
                                          ),
                                          CustomSimpleTextFormField(
                                            textController: values[index],
                                            hintText: l10n.value,
                                          ),
                                          IconButton(
                                            icon: Icon(Icons.remove_circle,
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
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        setState(() {
                                          keys.add(TextEditingController());
                                          values.add(TextEditingController());
                                        });
                                      },
                                      child: SizedBox(
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.add_circle_outline_sharp,
                                              size: 20,
                                              color: theme.colorScheme.primary,
                                            ),
                                            Text(" ${l10n.addMore}"),
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
              // for tow Button in down
              Padding(
                padding: const EdgeInsets.all(25.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    BlocConsumer<AddProductToStoreCubit,
                        AddProductToStoreState>(
                      listener: (context, state) {
                        if (state is AddProductToStoreSuccess) {
                          Navigator.of(context).pop();
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.productAddedSuccess)),
                          );
                        }
                        if (state is AddProductToStoreFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(l10n.productAddFailed)),
                          );
                        }
                      },
                      builder: (context, state) {
                        return StorePrimaryButton(
                          isLoading: state is AddProductToStoreLoading,
                          onTap: () async {
                            if (_formKey.currentState!.validate()) {
                              context.read<ProductsCubit>().addProduct(
                                    nameProductController.text,
                                    double.parse(priceProductController.text),
                                    numberProductController.text,
                                    oldPriceController.text.isNotEmpty
                                        ? double.parse(oldPriceController.text)
                                        : 0,
                                    shortDescriptionController.text,
                                    mainImageProductFile!,
                                    [
                                      if (subOneImageProductFile != null)
                                        subOneImageProductFile!,
                                      if (subTwoImageProductFile != null)
                                        subTwoImageProductFile!,
                                      if (subThreeImageProductFile != null)
                                        subThreeImageProductFile!,
                                    ],
                                    mainCategoryId ?? 0,
                                    subCategoryId,
                                    brandId,
                                  );
                              // Form is valid, proceed with submission
                              // final cubit =
                              //     context.read<AddProductToStoreCubit>();
                              // cubit.nameProductController.text =
                              //     nameProductController.text;
                              // cubit.priceProductController.text =
                              //     priceProductController.text;
                              // cubit.numberProductController.text =
                              //     numberProductController.text;
                              // cubit.keys = context
                              //     .read<AttributeProductCubit>()
                              //     .state
                              //     .keys;
                              // cubit.values = context
                              //     .read<AttributeProductCubit>()
                              //     .state
                              //     .values;
                              // await cubit.addProductToStore(
                              //   tags,
                              //   shortDescriptionController.text,
                              //   oldPriceController.text.isNotEmpty
                              //       ? num.parse(oldPriceController.text)
                              //       : 0,
                              // );
                            } else {
                              // Form is invalid, scroll to top to show errors
                              _scrollController.animateTo(
                                0,
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          },
                          title: l10n.confirm,
                          width: 280.w,
                          height: 50.h,
                          buttonColor: theme.colorScheme.primary,
                        );
                      },
                    ),
                    SizedBox(width: 8.w),
                    StorePrimaryButton(
                      onTap: () => Navigator.of(context).pop(),
                      title: l10n.cancel,
                      width: 100.w,
                      height: 50.h,
                      buttonColor: theme.disabledColor,
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
