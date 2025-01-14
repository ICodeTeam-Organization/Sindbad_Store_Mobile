import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/a.dart';
import '../../domain/entities/edit_product_entities/product_details_entity.dart';
import '../../domain/entities/edit_product_entities/product_images_entity.dart';
import '../widgets/custom_add_image_widget.dart';
import '../widgets/custom_simple_text_form_field.dart';
import '../widgets/custom_text_form_widget.dart';

class EditProductScreen extends StatefulWidget {
  // final int productId;
  final ProductDetailsEntity productDetailsEntity;

  const EditProductScreen({
    super.key,
    required this.productDetailsEntity,
    // required this.productId,
  });

  @override
  State<EditProductScreen> createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  late List<ProductImagesEntity> subImagesProduct;
  // final List<TextEditingController> _keys = [];
  // final List<TextEditingController> _values = [];

  @override
  void initState() {
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
                                      textController: TextEditingController(
                                          text: widget
                                              .productDetailsEntity.priceProduct
                                              .toString()),
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
                                textController: TextEditingController(
                                    text: widget.productDetailsEntity
                                        .descriptionProduct),
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
                                    ),
                                    CustomBoxAddImageForEditProductScreen(
                                      boxNumber: 3,
                                      initialImageUrl: subImagesProduct.length >
                                              1
                                          ? subImagesProduct[1].imageUrlProduct
                                          : null,
                                    ),
                                    CustomBoxAddImageForEditProductScreen(
                                      boxNumber: 4,
                                      initialImageUrl: subImagesProduct.length >
                                              2
                                          ? subImagesProduct[2].imageUrlProduct
                                          : null,
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
                      Card(
                        elevation: 4.0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        color: Colors.white,
                        child: Container(
                          width: 363.w,
                          height: 440.h,
                          decoration: BoxDecoration(),
                          margin: EdgeInsets.only(bottom: 20.h),
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
                                    " نوع المنتج",
                                    style: KTextStyle.textStyle16
                                        .copyWith(fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10.h),
                              // CustomDropdownWidget(
                              //   textTitle: 'أختر الفئة',
                              //   hintText: "قم بإختيار الفئة المناسبة",
                              //   items: widget.mainCategoryList,
                              //   initialItem: widget.selectedCategory,
                              // ),
                              // SizedBox(height: 10.h),
                              // CustomDropdownWidget(
                              //   textTitle: 'أختر قسم الفئة',
                              //   hintText: "قم بإختيار قسم الفئة المناسب",
                              //   items: widget.subCategoryList,
                              //   initialItem: widget.selectedSubCategory,
                              // ),
                              // SizedBox(height: 10.h),
                              // CustomDropdownWidget(
                              //   textTitle: 'أختر إسم البراند',
                              //   hintText: "قم بإختيار البراند المناسب",
                              //   items: widget.brandList,
                              //   initialItem: widget.selectedBrand,
                              // ),
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
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // for (int index = 0;
                                      //     index < _keys.length;
                                      //     index++)
                                      //   Padding(
                                      //     padding: EdgeInsets.symmetric(
                                      //         vertical: 8.0.h),
                                      //     child: Row(
                                      //       mainAxisAlignment:
                                      //           MainAxisAlignment.center,
                                      //       children: [
                                      //         CustomSimpleTextFormField(
                                      //           textController: _keys[index],
                                      //           hintText: 'خاصية',
                                      //         ),
                                      //         SizedBox(width: 20.w),
                                      //         CustomSimpleTextFormField(
                                      //           textController: _values[index],
                                      //           hintText: 'قيمة',
                                      //         ),
                                      //         IconButton(
                                      //           icon: Icon(Icons.remove_circle,
                                      //               size: 20),
                                      //           onPressed: () =>
                                      //               _removeField(index),
                                      //         ),
                                      //       ],
                                      //     ),
                                      //   ),
                                      // IconButton(
                                      //   icon: Row(
                                      //     mainAxisAlignment:
                                      //         MainAxisAlignment.center,
                                      //     children: [
                                      //       Icon(
                                      //         Icons.add_circle_outline_sharp,
                                      //         size: 20,
                                      //         color: AppColors.primary,
                                      //       ),
                                      //       Text(" أضف المزيد"),
                                      //     ],
                                      //   ),
                                      //   onPressed: _addField,
                                      // ),
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
                    onTap: () {
                      // Handle confirmation
                    },
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
