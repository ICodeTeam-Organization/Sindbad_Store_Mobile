import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_card_to_all_attributes_fields.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_card_to_all_drop_down.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_card_to_all_text_fields.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/two_button_in_down_add_product.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';
import 'custom_card_product_images_for_add_and_edit_product.dart';

class AddProductScreenBody extends StatefulWidget {
  const AddProductScreenBody({
    super.key,
    required this.onSuccessCallback,
  });

  final VoidCallback? onSuccessCallback;

  @override
  State<AddProductScreenBody> createState() => _AddProductScreenBodyState();
}

class _AddProductScreenBodyState extends State<AddProductScreenBody> {
  late AddProductToStoreCubit cubitAddProduct;
  late GetCategoryNamesCubit getCategoryNamesCubit;

  @override
  void initState() {
    cubitAddProduct = context.read<AddProductToStoreCubit>();
    getCategoryNamesCubit = context.read<GetCategoryNamesCubit>();
    context
        .read<GetCategoryNamesCubit>()
        .getMainAndSubCategory(); // call fun fetch Main And Sub Category

    super.initState();
  }

  final TextEditingController shortDescriptionController =
      TextEditingController();
  final TextEditingController oldPriceController = TextEditingController();

  final List<String> tags = [];

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
                //  ================= for text filed =========
                CustomCardToAllTextFields(
                  cubitAddProduct: cubitAddProduct,
                  oldPriceController: oldPriceController,
                  shortDescriptionController: shortDescriptionController,
                  tags: tags, // this is for tags
                ),
                SizedBox(height: 26.h),
                //  ================= for Add Images =========
                CustomCardProductImagesForAddAndEditProduct(
                  cubitAddProduct: cubitAddProduct,
                  mainImageUrlProduct: null, // not used because for edit page
                  subImagesProduct: [], // not used because for edit page
                ),
                SizedBox(height: 26.h),
                //  ================= for drop down =========
                CustomCardToAllDropDown(
                  cubitAddProduct: cubitAddProduct,
                  cubitCategories: getCategoryNamesCubit,
                ),
                SizedBox(height: 26.h),
                //  ================= for Attributes Fields =========
                CustomCardToAllAttributesFields(),
              ],
            ),
          ),
        ),
        // for tow Button in down
        Padding(
          padding: const EdgeInsets.all(25.0),
          child: TwoButtonInDownAddProduct(
            onSuccessCallback: widget.onSuccessCallback,
            cubitAddProduct: cubitAddProduct,
            oldPrice: oldPriceController.text.isNotEmpty
                ? num.parse(oldPriceController.text)
                : 0,
            shortDescription: shortDescriptionController.text,
            tags: tags,
          ),
        )
      ],
    );
  }
}
