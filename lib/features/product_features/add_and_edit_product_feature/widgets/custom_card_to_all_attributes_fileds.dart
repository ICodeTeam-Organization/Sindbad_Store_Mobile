import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/styles/Colors.dart';
import '../../../../core/styles/text_style.dart';
import '../ui/manger/cubit/add_attribute_product.dart/add_attribute_product_dart_cubit.dart';
import 'custom_simple_text_form_field.dart';

class CustomCardToAllAttributesFileds extends StatelessWidget {
  const CustomCardToAllAttributesFileds({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final AddAttributeProductDartCubit cubitAttribute =
        context.read<AddAttributeProductDartCubit>();
    return Card(
      elevation: 4.0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      color: Colors.white,
      child: Container(
        // width: 363.0.w,
        // height: 184.0.h,
        decoration: BoxDecoration(
            //  border: Border.all(width: 2.0.w, color: Colors.black),
            ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // container Title
            Align(
              alignment: Alignment.topRight,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 14.0.h, top: 10.h, right: 14.0.w),
                child: Text(
                  " خصائص المنتج",
                  style: KTextStyle.textStyle16
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // Flexible(
            Flexible(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  BlocBuilder<AddAttributeProductDartCubit,
                      AddAttributeProductDartState>(builder: (context, state) {
                    if (state is AddAttributeProductDartSuccess) {
                      return Column(
                        children: List.generate(state.keys.length, (index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 8.0.h),
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
                        }),
                      );
                    }

                    return SizedBox(); //  working [if in Initial state or else]
                  }),
                  IconButton(
                    icon: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.add_circle_outline_sharp,
                          size: 20,
                          color: AppColors.primary,
                        ),
                        Text(" أضف المزيد"),
                      ],
                    ),
                    onPressed: () {
                      cubitAttribute.addField();
                    },
                  ),
                  //  Text("أضف خاصية"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
