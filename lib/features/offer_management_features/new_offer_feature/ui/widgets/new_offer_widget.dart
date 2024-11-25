import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/card_product_bouns_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/card_product_discount_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/custom_select_item_dialog.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/default_value_bouns_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/default_value_discount_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/horizontal_title_and_text_field.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/required_text.dart';
import 'package:sindbad_management_app/features/offer_management_features/new_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class NewOfferWidget extends StatefulWidget {
  const NewOfferWidget({super.key});

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  final ValueNotifier<double> discountRateNotifier = ValueNotifier<double>(0);
  final ValueNotifier<int> buysCountNotifier = ValueNotifier<int>(0);
  final ValueNotifier<int> freesCountNotifier = ValueNotifier<int>(0);
  TextEditingController startDateConroller = TextEditingController();
  TextEditingController endDateConroller = TextEditingController();
  List<Item> selectedItems = [];
  String selectedOption = 'Discount';
  bool isDiscountDefaultValue = true;

  // Default values for bonus configuration
  double discountRate = 15; // Default "Discount Rate" value
  int buysCount = 2; // Default "Buy X" value
  int freesCount = 1; // Default "Get Y" value

  // List of all items
  final List<Item> items = [
    Item(title: "MacBook Air", imageUrl: "assets/image_example.png"),
    Item(title: "Item 2", imageUrl: "assets/image_example.png"),
    Item(title: "Item 3", imageUrl: "assets/image_example.png"),
    Item(title: "Item 4", imageUrl: "assets/image_example.png"),
    Item(title: "Item 5", imageUrl: "assets/image_example.png"),
    Item(title: "Item 6", imageUrl: "assets/image_example.png"),
    Item(title: "Item 7", imageUrl: "assets/image_example.png"),
    Item(title: "Item 8", imageUrl: "assets/image_example.png"),
    Item(title: "Item 9", imageUrl: "assets/image_example.png"),
    Item(title: "Item 10", imageUrl: "assets/image_example.png"),
  ];

  @override
  void initState() {
    super.initState();
    isDiscountDefaultValue = selectedOption == 'Discount';
    discountRateNotifier.value = discountRate;
    buysCountNotifier.value = buysCount;
    freesCountNotifier.value = freesCount;
  }

  // Function to calculate discounted price
  double calculateNewPrice(double lastPrice, double discountRate) {
    return lastPrice - (lastPrice * discountRate / 100);
  }

  // Function to handle selection confirmation
  void onItemsSelected(List<Item> selectedItems) {
    setState(() {
      this.selectedItems = selectedItems;
    });
  }

  @override
  void dispose() {
    super.dispose();
    startDateConroller.dispose();
    endDateConroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.maxFinite,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SectionTitleWidget(title: 'معلومات العرض'),
                SizedBox(height: 20.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RequiredText(title: 'اسم العرض '),
                    SizedBox(height: 10.h),
                    TextFormField(
                      decoration: InputDecoration(
                        hintText: 'أكتب اسم العرض...',
                        hintStyle: KTextStyle.textStyle12.copyWith(
                          color: AppColors.greyLight,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.greyBorder,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0,
                          ),
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                HorizontalTitleAndTextField(
                  title: 'بداية العرض ',
                  info: startDateConroller,
                  isDate: true,
                ),
                SizedBox(height: 40.h),
                HorizontalTitleAndTextField(
                  title: 'نهاية العرض ',
                  info: endDateConroller,
                  isDate: true,
                ),
                SizedBox(height: 40.h),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitleWidget(title: 'نوع الخصم'),
                    SizedBox(height: 10.h),
                    RadioListTile<String>(
                      title: Text(
                        'خصم مبلغ من منتج',
                        style: KTextStyle.textStyle13.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      value: 'Discount',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isDiscountDefaultValue = true;
                        });
                      },
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    ),
                    RadioListTile<String>(
                      title: Text(
                        'اشتري x واحصل على y',
                        style: KTextStyle.textStyle13.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      value: 'Bouns',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isDiscountDefaultValue = false;
                        });
                      },
                      activeColor: AppColors.primary,
                      visualDensity: VisualDensity(horizontal: 0, vertical: -4),
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                SectionTitleWidget(title: 'القيمة الأفتراضية'),
                SizedBox(height: 20.h),
                isDiscountDefaultValue
                    ? DefaultValueDiscountWidget(
                        discountRate: discountRate,
                        onDiscountRateChanged: (newRate) {
                          setState(() {
                            discountRateNotifier.value = newRate;
                          });
                        },
                      )
                    : DefaultValueBounsWidget(
                        buysCount: buysCount,
                        freesCount: freesCount,
                        onBuysCountChanged: (newBuysCount) {
                          setState(() {
                            buysCountNotifier.value = newBuysCount;
                            print(buysCountNotifier.value);
                          });
                        },
                        onFreesCountChanged: (newFreesCount) {
                          setState(() {
                            freesCountNotifier.value = newFreesCount;
                          });
                        },
                      ),
              ],
            ),
          ),
        ),
        SizedBox(height: 10.h),
        Container(
          width: double.maxFinite,
          color: AppColors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text.rich(
                  TextSpan(
                    text: 'اختر  المنتجات ',
                    style: KTextStyle.textStyle14.copyWith(
                      color: AppColors.greyLight,
                    ),
                    children: <TextSpan>[
                      TextSpan(
                        text: '*',
                        style: KTextStyle.textStyle13.copyWith(
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10.h),
                ActionButtonWidget(
                  title: 'تصفح المنتجات',
                  iconPath: 'assets/add.svg',
                  width: 333,
                  height: 50,
                  onTap: () async {
                    final result = await showDialog<List<Item>>(
                      context: context,
                      builder: (context) => CustomSelectItemDialog(
                        items: items,
                        selectedItems: selectedItems,
                        onConfirm: onItemsSelected,
                      ),
                    );

                    if (result != null) {
                      setState(() {
                        selectedItems = result;
                      });
                    }
                  },
                ),
                SizedBox(height: 10.h),
                SizedBox(
                  width: double.maxFinite,
                  height: 500.h,
                  child: ListView.builder(
                    itemCount: selectedItems.length,
                    itemBuilder: (context, index) {
                      return isDiscountDefaultValue
                          ? CardProductDiscountWidget(
                              productName: selectedItems[index].title,
                              productImage: selectedItems[index].imageUrl,
                              lastPrice: 4000,
                              newPrice: calculateNewPrice(4000, discountRate),
                              discountRate: discountRateNotifier.value,
                              onTapQuit: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                              },
                              discountRateNotifier: discountRateNotifier,
                            )
                          : CardProductBounsWidget(
                              productName: selectedItems[index].title,
                              productImage: selectedItems[index].imageUrl,
                              buysCount: buysCountNotifier.value,
                              freesCount: freesCountNotifier.value,
                              onTapQuit: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                              },
                              buysCountNotifier: buysCountNotifier,
                              freesCountNotifier: freesCountNotifier,
                            );
                    },
                  ),
                ),
                // Bottom Buttons
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context); // Cancel and close dialog
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        width: 100.w,
                        decoration: BoxDecoration(
                          color: AppColors.greyLight,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          'الغاء',
                          style: KTextStyle.textStyle16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        width: 195.w,
                        decoration: BoxDecoration(
                          color: AppColors.primary,
                          borderRadius: BorderRadius.circular(5.r),
                        ),
                        child: Text(
                          'تاكيد',
                          style: KTextStyle.textStyle16.copyWith(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
