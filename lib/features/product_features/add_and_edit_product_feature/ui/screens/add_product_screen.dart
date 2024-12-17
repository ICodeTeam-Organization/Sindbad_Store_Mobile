import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../widgets/custom_card_to_all_attributes_fileds.dart';
import '../../widgets/custom_card_to_all_drop_down.dart';
import '../../widgets/custom_card_to_all_images.dart';
import '../../widgets/custom_card_to_all_text_fileds.dart';
import '../../widgets/two_button_in_down_add_product.dart';

class AddProductScreen extends StatelessWidget {
  const AddProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CustomAppBar(
                // onPressed: () {},
                tital: 'إضافة منتج',
              ),
              SizedBox(height: 32.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.0.w),
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      //  ================= for text filed =========
                      CustomCardToAllTextFileds(),
                      SizedBox(height: 26.h),
                      //  ================= for Add Images =========
                      CustomCardToAllImages(),
                      SizedBox(height: 26.h),
                      //  ================= for drop down =========
                      CustomCardToAllDropDown(),
                      // Flexible(
                      SizedBox(height: 26.h),
                      CustomCardToAllAttributesFileds(),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              // for tow Button in down
              TwoButtonInDownAddproduct()
            ],
          ),
        ),
      ),
    );
  }
}
