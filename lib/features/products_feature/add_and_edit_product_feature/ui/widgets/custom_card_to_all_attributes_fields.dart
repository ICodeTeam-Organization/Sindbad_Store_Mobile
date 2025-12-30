import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';
import 'package:sindbad_management_app/features/products_feature/add_and_edit_product_feature/ui/manger/cubit/attribute_product/attribute_product_cubit.dart';
import '../../../../../config/styles/colors.dart';
import 'custom_simple_text_form_field.dart';

class CustomCardToAllAttributesFields extends StatelessWidget {
  const CustomCardToAllAttributesFields({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
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
            SectionTitleWidget(title: "خصائص المنتج"),
            SizedBox(height: 20.h),
            SizedBox(
              /// it was here a Flexible() widget
              child: BlocBuilder<AttributeProductCubit, AttributeProduct>(
                  builder: (context, state) {
                return Column(
                  children: List.generate(state.keys.length, (index) {
                    return Padding(
                      padding: EdgeInsets.symmetric(vertical: 5.0.h),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomSimpleTextFormField(
                            textController: state.keys[index],
                            hintText: 'خاصية',
                          ),
                          CustomSimpleTextFormField(
                            textController: state.values[index],
                            hintText: 'قيمة',
                          ),
                          IconButton(
                            icon: Icon(Icons.remove_circle, size: 20.sp),
                            onPressed: () {
                              context
                                  .read<AttributeProductCubit>()
                                  .removeField(index);
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
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      //  context.read<AttributeProductCubit>().addField();
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
        ),
      ),
    );
  }
}
