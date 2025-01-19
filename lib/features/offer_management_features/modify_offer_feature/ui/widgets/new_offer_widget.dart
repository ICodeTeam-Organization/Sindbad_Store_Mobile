import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/add_offer_cubit/add_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/card_product_bouns_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/card_product_discount_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/custom_select_item_dialog.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/default_value_bouns_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/default_value_discount_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/horizontal_title_and_text_field.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/required_text.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class NewOfferWidget extends StatefulWidget {
  const NewOfferWidget({super.key});

  @override
  State<NewOfferWidget> createState() => _NewOfferWidgetState();
}

class _NewOfferWidgetState extends State<NewOfferWidget> {
  TextEditingController offerTitleConroller = TextEditingController();
  TextEditingController startOfferConroller = TextEditingController();
  TextEditingController endOfferConroller = TextEditingController();
  int offerType = 1;
  final ValueNotifier<int> discountRateNotifier = ValueNotifier<int>(10);
  final ValueNotifier<int> numberToBuyNotifier = ValueNotifier<int>(2);
  final ValueNotifier<int> numberToGetNotifier = ValueNotifier<int>(1);

  List<OfferProductsEntity> selectedItems = [];
  String selectedOption = 'Percent';
  bool isDiscountDefaultValue = true;

  // Default values for bonus configuration
  int discountRate = 10; // Default "Percent Rate" value
  int numberToBuy = 2; // Default "Buy X" value
  int numberToGet = 1; // Default "Get Y" value

  // List<AddOfferDto> listProduct = [];
  List<Map<String, dynamic>> listProduct = [
    // {
    //   "id": 195,
    //   "type": 1,
    //   "percentage": 10,
    //   "finalPrice": 90,
    //   "amountToBuy": null,
    //   "amountToGet": null,
    //   "startDate": "2024-12-01",
    //   "endDate": "2024-12-31",
    //   "productId": "001"
    // },
    // {
    //   "id": 199,
    //   "type": 2,
    //   "percentage": null,
    //   "finalPrice": null,
    //   "amountToBuy": 2,
    //   "amountToGet": 1,
    //   "startDate": "2024-12-01",
    //   "endDate": "2024-12-31",
    //   "productId": "002"
    // }
  ];

  @override
  void initState() {
    super.initState();
    isDiscountDefaultValue = selectedOption == 'Percent';
    discountRateNotifier.value = discountRate;
    numberToBuyNotifier.value = numberToBuy;
    numberToGetNotifier.value = numberToGet;
  }

  DateTime? convertToDateTime(String inputDate) {
    try {
      // Parse the input date string
      DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(inputDate);

      // Add the desired time component
      DateTime dateWithTime = DateTime(
        parsedDate.year,
        parsedDate.month,
        parsedDate.day,
        03, // Hour
        00, // Minute
        00, // Second
        000, // Milliseconds
      );

      // Return the DateTime in UTC
      return dateWithTime.toUtc();
    } catch (e) {
      // Return null if the input is invalid
      return null;
    }
  }

  void populateListProduct() {
    listProduct.clear(); // Clear the list to avoid duplicates on re-population

    // Parse and format the start and end offer dates
    DateTime? startOfferFormat = convertToDateTime(startOfferConroller.text);
    DateTime? endOfferFormat = convertToDateTime(endOfferConroller.text);

    // Helper function to format DateTime
    String? formatDateTime(DateTime? dateTime) {
      if (dateTime == null) return null;
      return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
          .format(dateTime.toUtc());
    }

    if (startOfferFormat != null && endOfferFormat != null) {
      print(
          '${formatDateTime(startOfferFormat)}***************************'); // Output: 2024-12-03T09:55:12.120Z
      print(formatDateTime(endOfferFormat)); // Output: 2024-12-03T09:55:12.120Z
    } else {
      print("Invalid date format");
      return; // Exit if dates are invalid
    }

    for (var item in selectedItems) {
      final int newPrice =
          calculateNewPrice(item.oldPrice!, discountRateNotifier.value).toInt();

      // Create a map to hold the offer details for each product
      Map<String, dynamic> offerMap = {
        "id": item.productId,
        "productId": item.productId, // Product ID
        "type": offerType, // Offer type (either 1 or 2)
        "startDate": formatDateTime(startOfferFormat), // Formatted start date
        "endDate": formatDateTime(endOfferFormat), // Formatted end date
        "name": item.productTitle.toString(), // Offer type (either 1 or 2)
        "mainImageUrl":
            item.productImage.toString(), // Offer type (either 1 or 2)
        "priceBeforeDiscount":
            item.oldPrice?.toInt(), // Offer type (either 1 or 2)
      };

      if (offerType == 1) {
        // For discount offers
        offerMap["percentage"] =
            discountRateNotifier.value; // Discount percentage
        offerMap["finalPrice"] = newPrice; // Discounted price
        offerMap["amountToBuy"] = null; // Not applicable
        offerMap["amountToGet"] = null; // Not applicable
      } else if (offerType == 2) {
        // For "buy X, get Y" offers
        offerMap["percentage"] = null; // Not applicable
        offerMap["finalPrice"] = null; // Not applicable
        offerMap["amountToBuy"] = numberToBuyNotifier.value; // Amount to buy
        offerMap["amountToGet"] = numberToGetNotifier.value; // Amount to get
      }

      // Add the map to the list
      listProduct.add(offerMap);
    }
  }

  // void populateListProduct() {
  //   listProduct.clear(); // Clear the list to avoid duplicates on re-population
  //   for (var item in selectedItems) {
  //     // Calculate the new price for the item
  //     final int newPrice =
  //         calculateNewPrice(item.productIPrice!, discountRateNotifier.value)
  //             .toInt();

  //     if (offerType == 1) {
  //       // If offerType is 1, set percentage, finalPrice, and leave amountToBuy and amountToGet as null
  //       listProduct.add(
  //         AddOfferDto(
  //           id: item.productId,
  //           type: offerType,
  //           startDate: startOfferConroller.text, // Parse date
  //           endDate: endOfferConroller.text, // Parse date
  //           productId: item.productId,
  //           percentage: discountRateNotifier.value,
  //           finalPrice: newPrice,
  //           amountToBuy: null, // Null for amountToBuy
  //           amountToGet: null, // Null for amountToGet
  //         ),
  //       );
  //     } else if (offerType == 2) {
  //       // If offerType is 2, set amountToBuy and amountToGet, leave percentage and finalPrice as null
  //       listProduct.add(
  //         AddOfferDto(
  //           id: item.productId,
  //           type: offerType,
  //           startDate: startOfferConroller.text, // Parse date
  //           endDate: endOfferConroller.text, // Parse date
  //           productId: item.productId,
  //           percentage: null, // Null for percentage
  //           finalPrice: null, // Null for finalPrice
  //           amountToBuy: numberToBuyNotifier.value,
  //           amountToGet: numberToGetNotifier.value,
  //         ),
  //       );
  //     }
  //   }
  // }

  // Function to calculate discounted price
  num calculateNewPrice(num oldPrice, int discountRate) {
    return oldPrice - (oldPrice * discountRate / 100);
  }

  // Function to handle selection confirmation
  void onItemsSelected(List<OfferProductsEntity> selectedItems) {
    setState(() {
      this.selectedItems = selectedItems;
    });
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
                      controller: offerTitleConroller,
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
                  info: startOfferConroller,
                  isDate: true,
                ),
                SizedBox(height: 40.h),
                HorizontalTitleAndTextField(
                  title: 'نهاية العرض ',
                  info: endOfferConroller,
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
                      value: 'Percent',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isDiscountDefaultValue = true;
                          offerType = 1;
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
                      value: 'Bonus',
                      groupValue: selectedOption,
                      onChanged: (value) {
                        setState(() {
                          selectedOption = value!;
                          isDiscountDefaultValue = false;
                          offerType = 2;
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
                        numberToBuy: numberToBuy,
                        numberToGet: numberToGet,
                        onNumberToBuyChanged: (newBuysCount) {
                          setState(() {
                            numberToBuyNotifier.value = newBuysCount;
                            print(numberToBuyNotifier.value);
                          });
                        },
                        onNumberToGetChanged: (newNumberToGet) {
                          setState(() {
                            numberToGetNotifier.value = newNumberToGet;
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
                  width: double.infinity,
                  height: 50,
                  onTap: () async {
                    final result = await showDialog<List<OfferProductsEntity>>(
                      context: context,
                      builder: (context) => CustomSelectItemDialog(
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
                              productName: selectedItems[index].productTitle,
                              productImage: selectedItems[index].productImage,
                              oldPrice: selectedItems[index].oldPrice!,
                              newPrice: calculateNewPrice(
                                  selectedItems[index].oldPrice!, discountRate),
                              discountRate: discountRateNotifier.value,
                              onTapQuit: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                });
                              },
                              discountRateNotifier: discountRateNotifier,
                            )
                          : CardProductBounsWidget(
                              productName: selectedItems[index].productTitle,
                              productImage: selectedItems[index].productImage,
                              numberToBuy: numberToBuyNotifier.value,
                              numberToGet: numberToGetNotifier.value,
                              onTapQuit: () {
                                setState(() {
                                  selectedItems.removeAt(index);
                                  listProduct.removeAt(index);
                                });
                              },
                              numberToBuyNotifier: numberToBuyNotifier,
                              numberToGetNotifier: numberToGetNotifier,
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
                        width: 80.w,
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
                    BlocConsumer<AddOfferCubit, AddOfferState>(
                      listener: (context, state) {
                        if (state is AddOfferFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.errorMessage.toString())),
                          );
                        } else if (state is AddOfferSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.addOffer.toString())),
                          );
                          Navigator.pop(context);
                          context.read<OfferCubit>().getOffer(100, 1);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddOfferLoading) {
                          return Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            width: 180.w,
                            decoration: BoxDecoration(
                              color: AppColors.primary,
                              borderRadius: BorderRadius.circular(5.r),
                            ),
                            child: CircleAvatar(
                              backgroundColor: AppColors.transparent,
                              child: CircularProgressIndicator(
                                strokeAlign: -2,
                                // strokeWidth: 5,
                                color: AppColors.white,
                              ),
                            ),
                          );
                        }
                        return InkWell(
                          onTap: () async {
                            DateTime? startOfferFormat =
                                convertToDateTime(startOfferConroller.text);
                            DateTime? endOfferFormat =
                                convertToDateTime(endOfferConroller.text);
                            if (startOfferFormat != null &&
                                endOfferFormat != null) {
                              print(startOfferFormat
                                  .toIso8601String()); // Output: 2024-12-03T09:55:12.120Z
                              print(endOfferFormat
                                  .toIso8601String()); // Output: 2024-12-03T09:55:12.120Z

                              final differenceInDays = endOfferFormat
                                  .difference(startOfferFormat)
                                  .inDays;
                              print(differenceInDays);
                              if (differenceInDays <= 0) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                        'تاريخ انتهاء العرض يجب أن يكون بعد تاريخ بدء العرض.'),
                                  ),
                                );
                                return;
                              }
                            } else {
                              print("Invalid date format");
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'صيغة التاريخ غير صحيحة. من فضلك تحقق من التواريخ.'),
                                ),
                              );
                              return;
                            }

                            if (offerTitleConroller.text == '' ||
                                startOfferConroller.text == '' ||
                                endOfferConroller.text == '') {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text(
                                      'من فضلك قم بتعبئة جميع الحقول المطلوبة.'),
                                ),
                              );
                              return;
                            }

                            if (selectedItems.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('من فضلك قم بختيار منتجات العرض.'),
                                ),
                              );
                              return;
                            }

                            print('offerTitle: ${offerTitleConroller.text}');
                            print('startOffer: ${startOfferFormat}');
                            print('endOffer: ${endOfferFormat}');
                            print('offerType: ${offerType}');
                            print(
                                'discountRate: ${discountRateNotifier.value}');
                            print('numberToBuy: ${numberToBuyNotifier.value}');
                            print('numberToGet: ${numberToGetNotifier.value}');

// Call the function after all checks have passed
                            populateListProduct();
                            await context.read<AddOfferCubit>().addOffer(
                                  offerTitleConroller.text,
                                  startOfferFormat,
                                  endOfferFormat,
                                  selectedItems.length,
                                  offerType,
                                  listProduct,
                                );
                          },
                          child: Container(
                            alignment: Alignment.center,
                            height: 40.h,
                            width: 180.w,
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
                        );
                      },
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
