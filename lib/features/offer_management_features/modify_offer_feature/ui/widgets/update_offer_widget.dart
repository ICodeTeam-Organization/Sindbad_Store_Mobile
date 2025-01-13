import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/models/offer_data_model/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/add_offer_cubit/add_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/update_offer_cubit/update_offer_cubit.dart';
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

class UpdateOfferWidget extends StatefulWidget {
  final String offerTitle;
  final DateTime startOffer;
  final DateTime endOffer;
  final int offerType;
  final int discountRate;
  final int numberToBuy;
  final int numberToGet;
  // final List<OfferHeadOffer> listProduct;
  final List<OfferProductsEntity> listProducts;
  final int offerHeadId;

  const UpdateOfferWidget({
    super.key,
    required this.offerTitle,
    required this.startOffer,
    required this.endOffer,
    required this.offerType,
    required this.discountRate,
    required this.numberToBuy,
    required this.numberToGet,
    required this.listProducts,
    required this.offerHeadId,
  });

  @override
  State<UpdateOfferWidget> createState() => _UpdateOfferWidgetState();
}

class _UpdateOfferWidgetState extends State<UpdateOfferWidget> {
  late final TextEditingController offerTitleConroller;
  late final TextEditingController startOfferConroller;
  late final TextEditingController endOfferConroller;
  late final ValueNotifier<int> discountRateNotifier;
  late final ValueNotifier<int> numberToBuyNotifier;
  late final ValueNotifier<int> numberToGetNotifier;

  List<OfferProductsEntity>? selectedItems;
  String? selectedOption; // Nullable variable for safe reassignment
  bool isDiscountDefaultValue = true; // Default state
  int offerType = 1; // Default offer type
  List<OfferHeadOffer> listProduct = [];

  @override
  void initState() {
    super.initState();
    offerTitleConroller = TextEditingController(text: widget.offerTitle);
    startOfferConroller =
        TextEditingController(text: convertFromApi(widget.startOffer));
    endOfferConroller =
        TextEditingController(text: convertFromApi(widget.endOffer));

    discountRateNotifier = ValueNotifier<int>(widget.discountRate);
    numberToBuyNotifier = ValueNotifier<int>(widget.numberToBuy);
    numberToGetNotifier = ValueNotifier<int>(widget.numberToGet);
    selectedOption = widget.offerType == 1 ? 'Percent' : 'Bonus';
    isDiscountDefaultValue = widget.offerType == 1;
    offerType = widget.offerType;
    selectedItems = List<OfferProductsEntity>.from(widget.listProducts);
  }

  String convertFromApi(DateTime apiDate) {
    try {
      // Format the DateTime object to the desired string format
      return DateFormat("yyyy/MM/dd").format(apiDate);
    } catch (e) {
      // Handle any unexpected errors (rare for DateTime objects)
      print("Error formatting date: $e");
      // Fallback: Return an empty string or any default value
      return '';
    }
  }

  DateTime? convertToDateTime(String inputDate) {
    try {
      // Parse the input date string
      DateTime parsedDate = DateFormat('yyyy/MM/dd').parse(inputDate);

      // Update the desired time component
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
      print('${formatDateTime(startOfferFormat)}***************************');
      print(formatDateTime(endOfferFormat));
    } else {
      print("Invalid date format");
      return; // Exit if dates are invalid
    }

    for (var item in selectedItems!) {
      final int newPrice =
          calculateNewPrice(item.oldPrice!, discountRateNotifier.value).toInt();

      OfferHeadOffer offer = OfferHeadOffer(
        id: item.productId,
        productId: item.productId,
        type: offerType,
        startDate: startOfferFormat,
        endDate: endOfferFormat,
        name: item.productTitle.toString(),
        mainImageUrl: item.productImage.toString(),
        priceBeforeDiscount: item.oldPrice?.toInt() ?? 0,
        percentage: offerType == 1 ? discountRateNotifier.value : null,
        finalPrice: offerType == 1 ? newPrice : null,
        amountToBuy: offerType == 2 ? numberToBuyNotifier.value : null,
        amountToGet: offerType == 2 ? numberToGetNotifier.value : null,
      );

      // Add the offer object to the list
      listProduct.add(offer);
    }
  }

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
                          selectedOption = value;
                          isDiscountDefaultValue = true;
                          offerType = 1; // Update offerType
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
                          selectedOption = value;
                          isDiscountDefaultValue = false;
                          offerType = 2; // Update offerType
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
                        discountRate: discountRateNotifier.value,
                        onDiscountRateChanged: (newRate) {
                          setState(() {
                            discountRateNotifier.value = newRate;
                          });
                        },
                      )
                    : DefaultValueBounsWidget(
                        numberToBuy: numberToBuyNotifier.value,
                        numberToGet: numberToGetNotifier.value,
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
                        selectedItems: selectedItems!,
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
                    itemCount: selectedItems!.length,
                    itemBuilder: (context, index) {
                      return isDiscountDefaultValue
                          ? CardProductDiscountWidget(
                              productName: selectedItems![index].productTitle,
                              productImage: selectedItems![index].productImage,
                              oldPrice: selectedItems![index].oldPrice!,
                              newPrice: calculateNewPrice(
                                  selectedItems![index].oldPrice!,
                                  discountRateNotifier.value),
                              discountRate: discountRateNotifier.value,
                              onTapQuit: () {
                                setState(() {
                                  selectedItems!.removeAt(index);
                                  // listProduct.removeAt(index);
                                });
                              },
                              discountRateNotifier: discountRateNotifier,
                            )
                          : CardProductBounsWidget(
                              productName: selectedItems![index].productTitle,
                              productImage: selectedItems![index].productImage,
                              numberToBuy: numberToBuyNotifier.value,
                              numberToGet: numberToGetNotifier.value,
                              onTapQuit: () {
                                setState(() {
                                  selectedItems!.removeAt(index);
                                  // listProduct.removeAt(index);
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
                    BlocConsumer<UpdateOfferCubit, UpdateOfferState>(
                      listener: (context, state) {
                        if (state is UpdateOfferFailure) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.errorMessage.toString())),
                          );
                        } else if (state is UpdateOfferSuccess) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                                content: Text(state.updateOffer.toString())),
                          );
                          Navigator.pop(context);
                          context.read<OfferCubit>().getOffer(100, 1);
                        }
                      },
                      builder: (context, state) {
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

                            if (selectedItems!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('من فضلك قم بختيار منتجات العرض.'),
                                ),
                              );
                              return;
                            }

                            listProduct = selectedItems!.map((item) {
                              return OfferHeadOffer(
                                productId: item.productId,
                                name: item.productTitle,
                                mainImageUrl: item.productImage,
                                type: offerType,
                                percentage: item.discountRate,
                                priceBeforeDiscount: item.oldPrice,
                                finalPrice: item.newPrice,
                                amountToBuy: item.numberToBuy,
                                amountToGet: item.numberToGet,
                                startDate: startOfferFormat,
                                endDate: endOfferFormat,
                              );
                            }).toList();
                            print('offerTitle: ${offerTitleConroller.text}');
                            print('startOffer: ${startOfferFormat}');
                            print('endOffer: ${endOfferFormat}');
                            print('offerType: ${offerType}');
                            print(
                                'discountRate: ${discountRateNotifier.value}');
                            print('numberToBuy: ${numberToBuyNotifier.value}');
                            print('numberToGet: ${numberToGetNotifier.value}');
                            listProduct.forEach((offer) {
                              print('''
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
OfferHeadOffer:
productId: ${offer.productId},
name: ${offer.name},
mainImageUrl: ${offer.mainImageUrl},
type: ${offer.type},
percentage: ${offer.percentage},
priceBeforeDiscount: ${offer.priceBeforeDiscount},
finalPrice: ${offer.finalPrice},
amountToBuy: ${offer.amountToBuy},
amountToGet: ${offer.amountToGet},
startDate: ${offer.startDate},
endDate: ${offer.endDate},
\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
                            ''');
                            });
                            populateListProduct();
                            await context.read<UpdateOfferCubit>().updateOffer(
                                  offerTitleConroller.text,
                                  startOfferFormat,
                                  endOfferFormat,
                                  selectedItems!.length,
                                  offerType,
                                  listProduct,
                                  widget.offerHeadId,
                                );
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
