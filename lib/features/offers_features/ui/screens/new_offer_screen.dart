import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/card_product_bouns_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/card_product_discount_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/custom_select_item_dialog.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/offer_default_value_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/offer_info_text_field_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/offer_type_radio_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/required_text.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';

class NewOfferScreen extends StatefulWidget {
  const NewOfferScreen({super.key});

  @override
  State<NewOfferScreen> createState() => _NewOfferScreenState();
}

class _NewOfferScreenState extends State<NewOfferScreen> {
  TextEditingController nameController = TextEditingController();
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
    //  DateTime? startOfferFormat = convertToDateTime(startOfferConroller.text);
    // DateTime? endOfferFormat = convertToDateTime(endOfferConroller.text);
    // Helper function to format DateTime
    // String? formatDateTime(DateTime? dateTime) {
    //   if (dateTime == null) return null;
    //   return DateFormat("yyyy-MM-dd'T'HH:mm:ss.SSS'Z'")
    //       .format(dateTime.toUtc());
    // }

    // for (var item in selectedItems) {
    //   final int newPrice =
    //       calculateNewPrice(item.oldPrice!, discountRateNotifier.value).toInt();

    //   // Create a map to hold the offer details for each product
    //   Map<String, dynamic> offerMap = {
    //     "id": item.productId, // Product Offer ID
    //     "productId": item.productId, // Product ID
    //     "type": offerType, // Offer type (either 1 or 2)
    //     "startDate": formatDateTime(startOfferFormat), // Formatted start date
    //     "endDate": formatDateTime(endOfferFormat), // Formatted end date
    //     "name": item.productTitle.toString(), // Product name
    //     "mainImageUrl": item.productImage.toString(), // Product mainImageUrl
    //     "priceBeforeDiscount": item.oldPrice?.toInt(), // Product price
    //   };

    //   if (offerType == 1) {
    //     // For discount offers
    //     offerMap["percentage"] =
    //         discountRateNotifier.value; // Discount percentage
    //     offerMap["finalPrice"] = newPrice; // Discounted price
    //     offerMap["amountToBuy"] = 0; // Not applicable
    //     offerMap["amountToGet"] = 0; // Not applicable
    //   } else if (offerType == 2) {
    //     // For "buy X, get Y" offers
    //     offerMap["percentage"] = 0; // Not applicable
    //     offerMap["finalPrice"] = item.oldPrice; // Not applicable
    //     offerMap["amountToBuy"] = numberToBuyNotifier.value; // Amount to buy
    //     offerMap["amountToGet"] = numberToGetNotifier.value; // Amount to get
    //   }

    //   // Add the map to the list
    //   listProduct.add(offerMap);
    // }
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
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                tital: l10n.addOffer,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          width: double.maxFinite,
                          color: theme.cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SectionTitleWidget(title: l10n.offerInfo),
                                    SizedBox(height: 20.h),
                                    OfferInfoTextFieldWidget(
                                      title: l10n.offerName,
                                      controller: nameController,
                                      isDate: false,
                                    ),
                                    SizedBox(height: 40.h),
                                    NewOfferInfoTextFieldWidget(
                                        title: l10n.offerStart,
                                        controller: startOfferConroller,
                                        isDate: true,
                                        initialValue:
                                            DateTime.now().toString()),
                                    SizedBox(height: 40.h),
                                    OfferInfoTextFieldWidget(
                                      title: l10n.offerEnd,
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
                                  isDiscountDefaultValue:
                                      isDiscountDefaultValue,
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
                                      numberToGetNotifier.value =
                                          newNumberToGet;
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
                          color: theme.cardColor,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                RequiredText(title: l10n.selectProducts),
                                SizedBox(height: 10.h),
                                ActionButtonWidget(
                                  color: theme.colorScheme.primary,
                                  title: l10n.browseProducts,
                                  iconPath: 'assets/add.svg',
                                  width: double.infinity,
                                  height: 50,
                                  onTap: () async {
                                    final result = await showDialog<
                                        List<OfferProductsEntity>>(
                                      context: context,
                                      builder: (context) =>
                                          CustomSelectItemDialog(
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
                                if (selectedItems.isNotEmpty)
                                  ConstrainedBox(
                                    constraints: BoxConstraints(
                                      maxHeight: 400.h, // Maximum height limit
                                    ),
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics: BouncingScrollPhysics(),
                                      itemCount: selectedItems.length,
                                      itemBuilder: (context, index) {
                                        return isDiscountDefaultValue
                                            ? CardProductDiscountWidget(
                                                productName:
                                                    selectedItems[index]
                                                        .productTitle,
                                                productImage:
                                                    selectedItems[index]
                                                        .productImage,
                                                oldPrice: selectedItems[index]
                                                    .oldPrice!,
                                                newPrice: calculateNewPrice(
                                                    selectedItems[index]
                                                        .oldPrice!,
                                                    discountRate),
                                                discountRate:
                                                    discountRateNotifier.value,
                                                onTapQuit: () {
                                                  setState(() {
                                                    selectedItems
                                                        .removeAt(index);
                                                  });
                                                },
                                                discountRateNotifier:
                                                    discountRateNotifier,
                                              )
                                            : CardProductBounsWidget(
                                                productName:
                                                    selectedItems[index]
                                                        .productTitle,
                                                productImage:
                                                    selectedItems[index]
                                                        .productImage,
                                                numberToBuy:
                                                    numberToBuyNotifier.value,
                                                numberToGet:
                                                    numberToGetNotifier.value,
                                                onTapQuit: () {
                                                  setState(() {
                                                    selectedItems
                                                        .removeAt(index);
                                                  });
                                                },
                                                numberToBuyNotifier:
                                                    numberToBuyNotifier,
                                                numberToGetNotifier:
                                                    numberToGetNotifier,
                                              );
                                      },
                                    ),
                                  ),
                                if (selectedItems.isEmpty)
                                  Padding(
                                    padding:
                                        EdgeInsets.symmetric(vertical: 30.h),
                                    child: Center(
                                      child: Text(
                                        l10n.addProductsToOffer,
                                        style: KTextStyle.textStyle14.copyWith(
                                          color: theme.hintColor,
                                        ),
                                      ),
                                    ),
                                  ),
                                SizedBox(height: 10.h),
                                // Bottom Buttons
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                          color: theme.disabledColor,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Text(
                                          l10n.cancel,
                                          style:
                                              KTextStyle.textStyle16.copyWith(
                                            color: AppColors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                    InkWell(
                                      onTap: () async {
                                        DateTime? startOfferFormat =
                                            convertToDateTime(
                                                startOfferConroller.text);
                                        DateTime? endOfferFormat =
                                            convertToDateTime(
                                                endOfferConroller.text);

                                        if (startOfferFormat == null ||
                                            endOfferFormat == null) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content:
                                                  Text(l10n.invalidDateFormat),
                                            ),
                                          );
                                          return;
                                        }

                                        populateListProduct();
                                        await context
                                            .read<OfferCubit>()
                                            .addOffer(
                                              name: nameController.text,
                                              description: '',
                                              startDate: startOfferFormat,
                                              endDate: endOfferFormat,
                                              isActive: true,
                                              numberOfOrders:
                                                  selectedItems.length,
                                              offerHeadType: offerType,
                                              offerHeadOffers: listProduct,
                                            );
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        height: 40.h,
                                        width: screenWidth <= 360 ? 180 : 195.w,
                                        decoration: BoxDecoration(
                                          color: theme.colorScheme.primary,
                                          borderRadius:
                                              BorderRadius.circular(5.r),
                                        ),
                                        child: Text(
                                          l10n.confirm,
                                          style:
                                              KTextStyle.textStyle16.copyWith(
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
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
