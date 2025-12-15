import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/update_offer_cubit/update_offer_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/card_product_bouns_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/card_product_discount_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/custom_select_item_dialog.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/offer_default_value_widget.dart'
    show OfferDefaultValueWidget;
import 'package:sindbad_management_app/features/profile_feature/ui/widget/offer_info_text_field_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/offer_type_radio_widget.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/required_text.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/section_title_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/action_button_widget.dart';

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
  List<OfferProductsEntity> listProductForUpdate = [];

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
    listProductForUpdate = List<OfferProductsEntity>.from(widget.listProducts);
    selectedItems = List<OfferProductsEntity>.from(widget.listProducts);
  }

  String convertFromApi(DateTime apiDate) {
    try {
      // Format the DateTime object to the desired string format
      return DateFormat("yyyy/MM/dd").format(apiDate);
    } catch (e) {
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

    for (var item in listProductForUpdate) {
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
        percentage: offerType == 1 ? discountRateNotifier.value : 0,
        finalPrice: offerType == 1 ? newPrice : 0,
        amountToBuy: offerType == 2 ? numberToBuyNotifier.value : 0,
        amountToGet: offerType == 2 ? numberToGetNotifier.value : 0,
        isDeleted: item.isDeleted,
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
                  discountRate: discountRateNotifier.value,
                  numberToBuy: numberToBuyNotifier.value,
                  numberToGet: numberToGetNotifier.value,
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
                        selectedItems: selectedItems!,
                        onConfirm: onItemsSelected,
                        listProductForUpdate: listProductForUpdate,
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
                                  listProductForUpdate
                                      .firstWhere((item) =>
                                          item.productId ==
                                          selectedItems![index].productId)
                                      .isDeleted = true;
                                  selectedItems!.removeAt(index);
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
                                  listProductForUpdate[index].isDeleted = true;
                                  selectedItems!.removeAt(index);
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
                        if (state is UpdateOfferLoading) {
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

                            if (selectedItems!.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content:
                                      Text('من فضلك قم بختيار منتجات العرض.'),
                                ),
                              );
                              return;
                            }

                            listProduct = listProductForUpdate.map((item) {
                              return OfferHeadOffer(
                                id: item.productOfferId,
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
                                isDeleted: item.isDeleted,
                              );
                            }).toList();
                            populateListProduct();
                            await context.read<UpdateOfferCubit>().updateOffer(
                                  offerTitleConroller.text,
                                  startOfferFormat,
                                  endOfferFormat,
                                  listProductForUpdate.length,
                                  offerType,
                                  listProduct,
                                  widget.offerHeadId,
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
