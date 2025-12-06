import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/add_offer_cubit/add_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/custom_select_item_dialog.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/offer_default_value_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/offer_info_text_field_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/offer_type_radio_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/card_product_bouns_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/card_product_discount_widget.dart';
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

  List<Map<String, dynamic>> listProduct = [];

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
        03,
        // Hour
        00,
        // Minute
        00,
        // Second
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

    for (var item in selectedItems) {
      final int newPrice =
          calculateNewPrice(item.oldPrice!, discountRateNotifier.value).toInt();

      // Create a map to hold the offer details for each product
      Map<String, dynamic> offerMap = {
        "id": item.productId, // Product Offer ID
        "productId": item.productId, // Product ID
        "type": offerType, // Offer type (either 1 or 2)
        "startDate": formatDateTime(startOfferFormat), // Formatted start date
        "endDate": formatDateTime(endOfferFormat), // Formatted end date
        "name": item.productTitle.toString(), // Product name
        "mainImageUrl": item.productImage.toString(), // Product mainImageUrl
        "priceBeforeDiscount": item.oldPrice?.toInt(), // Product price
      };

      if (offerType == 1) {
        // For discount offers
        offerMap["percentage"] =
            discountRateNotifier.value; // Discount percentage
        offerMap["finalPrice"] = newPrice; // Discounted price
        offerMap["amountToBuy"] = 0; // Not applicable
        offerMap["amountToGet"] = 0; // Not applicable
      } else if (offerType == 2) {
        // For "buy X, get Y" offers
        offerMap["percentage"] = 0; // Not applicable
        offerMap["finalPrice"] = item.oldPrice; // Not applicable
        offerMap["amountToBuy"] = numberToBuyNotifier.value; // Amount to buy
        offerMap["amountToGet"] = numberToGetNotifier.value; // Amount to get
      }

      // Add the map to the list
      listProduct.add(offerMap);
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
    final screenWidth = MediaQuery.of(context).size.width;
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
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SectionTitleWidget(title: 'معلومات العرض'),
                    SizedBox(height: 20.h),
                    OfferInfoTextFieldWidget(
                      title: 'اسم العرض',
                      controller: offerTitleConroller,
                      isDate: false,
                    ),
                    SizedBox(height: 40.h),
                    OfferInfoTextFieldWidget(
                      title: 'بداية العرض',
                      controller: startOfferConroller,
                      isDate: true,
                    ),
                    SizedBox(height: 40.h),
                    OfferInfoTextFieldWidget(
                      title: 'نهاية العرض',
                      controller: endOfferConroller,
                      isDate: true,
                    ),
                  ],
                ),
                SizedBox(height: 40.h),
                OfferTypeRadioWidget(
                  selectedOption: selectedOption,
                  onChangedDiscount: (value) {
                    setState(() {
                      selectedOption = value!;
                      isDiscountDefaultValue = true;
                      offerType = 1;
                    });
                  },
                  onChangedBouns: (value) {
                    setState(() {
                      selectedOption = value!;
                      isDiscountDefaultValue = false;
                      offerType = 2;
                    });
                  },
                ),
                SizedBox(height: 40.h),
                OfferDefaultValueWidget(
                  isDiscountDefaultValue: isDiscountDefaultValue,
                  discountRate: discountRate,
                  numberToBuy: numberToBuy,
                  numberToGet: numberToGet,
                  onDiscountRateChanged: (newRate) {
                    setState(() {
                      discountRateNotifier.value = newRate;
                    });
                  },
                  onNumberToBuyChanged: (newBuysCount) {
                    setState(() {
                      numberToBuyNotifier.value = newBuysCount;
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
                RequiredText(title: 'اختر  المنتجات '),
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
                        listProductForUpdate: [],
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
                    physics: BouncingScrollPhysics(),
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
                        Navigator.pop(context);
                      },
                      child: Container(
                        alignment: Alignment.center,
                        height: 40.h,
                        width: screenWidth <= 360 ? 80 : 100.w,
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
                          Navigator.pop(context);
                          context.read<OfferCubit>().getOffer(100, 1);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(state.addOffer.toString())),
                          );
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
                              final differenceInDays = endOfferFormat
                                  .difference(startOfferFormat)
                                  .inDays;
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
                            width: screenWidth <= 360 ? 180 : 195.w,
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
