import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import '../../../../../core/styles/Colors.dart';
import '../manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import 'custom_simple_text_form_field.dart';

class CustomCardToAllAttributesFields extends StatelessWidget {
  final AddAttributeProductDartCubit cubitAttribute;

  const CustomCardToAllAttributesFields({
    super.key,
    required this.cubitAttribute,
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
            BlocBuilder<AddAttributeProductDartCubit,
                AddAttributeProductDartState>(builder: (context, state) {
              if (state is AddAttributeProductDartSuccess) {
                return SizedBox(
                  /// it was here a Flexible() widget
                  child: Column(
                    children: List.generate(state.keys.length, (index) {
                      return Padding(
                        padding: EdgeInsets.symmetric(vertical: 5.0.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            CustomSimpleTextFormField(
                              textController: cubitAttribute.keys[index],
                              hintText: 'خاصية',
                            ),
                            CustomSimpleTextFormField(
                              textController: cubitAttribute.values[index],
                              hintText: 'قيمة',
                            ),
                            IconButton(
                              icon: Icon(Icons.remove_circle, size: 20.sp),
                              onPressed: () {
                                cubitAttribute.removeField(index);
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
        ),
      ),
    );
  }
}
