import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/custom_simple_text_form_field.dart';

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
