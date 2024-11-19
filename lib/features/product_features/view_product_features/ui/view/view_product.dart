import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

import '../../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../core/styles/text_style.dart';
import '../../../../offer_features/view_offer_feature/ui/widgets/action_button_widget.dart';
import '../../data/data_source/view_product_remote_data_source.dart';
import 'fake_data _for_test.dart/test_data_cat.dart';
import 'widgets/button_custom.dart';
import 'widgets/image_card_custom.dart';
import 'widgets/sub_category_card_custom.dart';
import 'widgets/text_style_detials.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    int indexSelected = 0;

    final List<Map<String, dynamic>> products = List.generate(
        10,
        (index) => {
              'name': 'MacBook 7',
              'id': '12342345',
              'price': '1500',
              'imageUrl': 'https://via.placeholder.com/100',
            });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            tital: '',
          ),
          SizedBox(height: 20.h),
          CustomTabBarWidget(
            length: 3,
            tabs: [
              Text(
                "جميع المنتجات",
                style: KTextStyle.textStyle16,
              ),
              Text(
                "جميع المنتجات",
                style: KTextStyle.textStyle16,
              ),
              Text(
                "جميع المنتجات",
                style: KTextStyle.textStyle16,
              ),
            ],
            tabViews: [
              SizedBox(
                height: 56.h,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: FakeDataApi().subCategs.length,
                    itemBuilder: (context, index) {
                      return ChipCustom(
                        title: FakeDataApi().subCategs[index],
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                            debugPrint('isSelected: $indexSelected');
                          });
                        },
                        isSelected: indexSelected == index,
                      );
                    }),
              ),
              SizedBox(
                height: 56.h,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: FakeDataApi().subCategs.length,
                    itemBuilder: (context, index) {
                      return ChipCustom(
                        title: FakeDataApi().subCategs[index],
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                            debugPrint('isSelected: $indexSelected');
                          });
                        },
                        isSelected: indexSelected == index,
                      );
                    }),
              ),
              SizedBox(
                height: 56.h,
                child: ListView.builder(
                    physics: AlwaysScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: FakeDataApi().subCategs.length,
                    itemBuilder: (context, index) {
                      return ChipCustom(
                        title: FakeDataApi().subCategs[index],
                        isSelected: indexSelected == index,
                        onTap: () {
                          setState(() {
                            indexSelected = index;
                            debugPrint('isSelected: $indexSelected');
                          });
                        },
                      );
                    }),
              ),
            ],
          ),
          SizedBox(height: 20.h),
          // =================  Start Sub Category  ======================
          // SizedBox(
          //   height: 56.h,
          //   child: ListView.builder(
          //       physics: AlwaysScrollableScrollPhysics(),
          //       scrollDirection: Axis.horizontal,
          //       itemCount: FakeDataApi().subCategs.length,
          //       itemBuilder: (context, index) {
          //         return ChipCustom(
          //           title: FakeDataApi().subCategs[index],
          //           onTap: () {
          //             setState(() {
          //               indexSelected = index;
          //               debugPrint('isSelected: $indexSelected');
          //             });
          //           },
          //           isSelected: indexSelected == index,
          //         );
          //       }),
          // ),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ActionButtonWidget(
                  title: 'إضافة منتج',
                  iconPath: 'assets/add.svg',
                ),
                ActionButtonWidget(
                  title: 'إيقاف منتج',
                  iconPath: 'assets/add.svg',
                ),
              ],
            ),
          ),
          // =================  Start Products View  ======================
          Expanded(
            child: ListView.builder(
              // padding: EdgeInsets.all(0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  // margin:
                  //     const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  padding: const EdgeInsets.only(top: 26, bottom: 26, left: 7),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColors.background : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    // border: Border.all(color: Colors.redAccent, width: 1.5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Check Box
                      Checkbox(
                        // checkColor: Colors.white, // لون العلامة ✓
                        // activeColor: Colors.green, // لون المربع عند التحديد
                        side: BorderSide(
                          color: Colors.red, // لون الحواف
                          width: 1.0, // سماكة الحواف
                        ),
                        value: false,
                        onChanged: (bool? value) {
                          // Checkbox action
                        },
                      ),
                      ImageCardCustom(),
                      const SizedBox(width: 10),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                TextStyleTitleDataProductBold(
                                    title: ': اسم المنتج'),
                                TextStyleDataProductGreyDark(
                                    dataProduct: product['name']),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                TextStyleTitleDataProductBold(
                                    title: ': رقم المنتج'),
                                TextStyleDataProductGreyDark(
                                    dataProduct: product['id']),
                              ],
                            ),
                            const SizedBox(height: 4),
                            Row(
                              children: [
                                Text(
                                  'السعر: ',
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${product['price']}',
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.red,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10.w),
                      // Action Buttons
                      Column(
                        children: [
                          CustomButton(
                            text: 'تعديل',
                            icon: Icons.edit,
                            onPressed: () {
                              // تنفيذ الإجراء عند الضغط
                              // print('Button Pressed!');
                            },
                          ),
                          SizedBox(height: 5.h),
                          CustomButton(
                              text: 'حذف',
                              icon: Icons.edit,
                              onPressed: () {
                                // تنفيذ الإجراء عند الضغط
                                // print('Button Pressed!');
                              }),
                        ],
                      ),
                      // Checkbox
                      SizedBox(width: 8.w),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      // ),
    );
  }
}
