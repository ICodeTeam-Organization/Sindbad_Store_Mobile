import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/custom_delete_dialog_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/remaining_notice.dart';

class CardOfferWidget extends StatefulWidget {
  final int? offerId;
  final String offerTitle;
  final String typeName;
  final bool isActive;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final num? numberToBuy;
  final num? numberToGet;
  final num? discountRate;
  final void Function()? onDeleteTap;
  final void Function()? onChangeStatusTap;
  final void Function()? onUpdateTap;

  const CardOfferWidget({
    super.key,
    required this.offerId,
    required this.offerTitle,
    required this.typeName,
    required this.isActive,
    required this.startOffer,
    required this.endOffer,
    required this.countProducts,
    this.numberToBuy,
    this.numberToGet,
    this.discountRate,
    this.onDeleteTap,
    this.onChangeStatusTap,
    this.onUpdateTap,
  });

  @override
  State<CardOfferWidget> createState() => _CardOfferWidgetState();
}

class _CardOfferWidgetState extends State<CardOfferWidget> {
  DateTime dateNow = DateTime.now();
  int result = 0;
  String specialCase = '';
  dynamic remainingDays;
  bool? isRemainingDays;
  String? offerTypeTitle;
  String? isActiveTitleButton;

  @override
  void initState() {
    super.initState();
    remainigDays();
    selectedOffer();
    if (widget.isActive == true) {
      isActiveTitleButton = 'ايقاف عرض';
    } else {
      isActiveTitleButton = 'تنشيط عرض';
    }
    if (result == 1) {
      specialCase = '';
      remainingDays = 'يوم واحد ';
    } else if (result == 2) {
      specialCase = '';
      remainingDays = 'يومين ';
    } else if (result > 2 && result < 11) {
      specialCase = ' أيام ';
      remainingDays = result;
    } else if (result > 10) {
      specialCase = ' يوم ';
      remainingDays = result;
    }
  }

  void remainigDays() {
    dateNow = dateNow.toUtc();
    if (dateNow.year <= widget.endOffer.year) {
      if (dateNow.day == 31) {
        result = ((31 + widget.endOffer.day) - dateNow.day) +
            (30 * ((11 + widget.endOffer.month) - dateNow.month)) +
            (360 * ((widget.endOffer.year - 1) - dateNow.year));
      }
      result = ((30 + widget.endOffer.day) - dateNow.day) +
          (30 * ((11 + widget.endOffer.month) - dateNow.month)) +
          (360 * ((widget.endOffer.year - 1) - dateNow.year));
      isRemainingDays = true;
      if (result <= 0) {
        isRemainingDays = false;
      }
    }
  }

  void selectedOffer() {
    if (widget.typeName == 'Percent') {
      offerTypeTitle = '${widget.discountRate}% من إجمالي الخصم';
    } else if (widget.typeName == 'Bonus') {
      offerTypeTitle =
          ' اشتري ${widget.numberToBuy} واحصل على ${widget.numberToGet}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            color: AppColors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(top: 20.h, bottom: 20.h, right: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "أسم العرض : ",
                            style: KTextStyle.textStyle14.copyWith(
                              color: AppColors.greyDark,
                            ),
                          ),
                          SizedBox(
                            // color: Colors.red,
                            width: 130.w,
                            child: Table(
                              children: [
                                TableRow(
                                  children: [
                                    Text(
                                      widget.offerTitle,
                                      style: KTextStyle.textStyle14.copyWith(
                                        color: AppColors.blackDark,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 15.h,
                      ),
                      Text(
                        offerTypeTitle!,
                        style: KTextStyle.textStyle11.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      SizedBox(
                        height: 10.h,
                      ),
                      Row(
                        children: [
                          Text(
                            "من ",
                            style: KTextStyle.textStyle11.copyWith(
                              color: AppColors.greyLight,
                            ),
                          ),
                          Text(
                            "${widget.startOffer.year}/${widget.startOffer.month}/${widget.startOffer.day}",
                            style: KTextStyle.textStyle11.copyWith(
                              color: AppColors.greyLight,
                            ),
                          ),
                          Text(
                            " الى  ",
                            style: KTextStyle.textStyle11.copyWith(
                              color: AppColors.greyLight,
                            ),
                          ),
                          Text(
                            "${widget.endOffer.year}/${widget.endOffer.month}/${widget.endOffer.day}",
                            style: KTextStyle.textStyle11.copyWith(
                              color: AppColors.greyLight,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          SizedBox(
                            width: 35.w,
                            height: 42.5.h,
                            child: Stack(children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: SvgPicture.asset(
                                  "assets/bag_amount.svg",
                                  width: 22.5.w,
                                  height: 22.5.h,
                                ),
                              ),
                              Container(
                                alignment: Alignment.center,
                                height: 20.h,
                                width: 20.w,
                                decoration: BoxDecoration(
                                    color: AppColors.primaryBackground,
                                    borderRadius: BorderRadius.circular(100.r),
                                    border: Border.all(
                                        color: AppColors.white, width: 2.w)),
                                child: Text(widget.countProducts.toString(),
                                    style: TextStyle(
                                        color: AppColors.primary,
                                        fontSize: 9.sp,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ]),
                          ),
                          SizedBox(
                            width: 5.w,
                          ),
                          Text(
                            "عدد المنتجات",
                            style: KTextStyle.textStyle11.copyWith(
                              color: AppColors.greyLight,
                            ),
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                          widget.isActive == true
                              ? Container(
                                  width: 75.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.greenOpacity,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/circle_green.svg",
                                        width: 9.w,
                                        height: 9.h,
                                      ),
                                      Text(
                                        "نشط",
                                        style: KTextStyle.textStyle11.copyWith(
                                          color: AppColors.blackLight,
                                        ),
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  width: 75.w,
                                  decoration: BoxDecoration(
                                      color: AppColors.redOpacity,
                                      borderRadius: BorderRadius.circular(100)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SvgPicture.asset(
                                        "assets/circle_red.svg",
                                        width: 9.w,
                                        height: 9.h,
                                      ),
                                      Text(
                                        "غير نشط",
                                        style: KTextStyle.textStyle11.copyWith(
                                          color: AppColors.blackLight,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(25.0),
                  child: Column(
                    children: [
                      isRemainingDays == true
                          ? RemainingNotice(
                              remainingDays: remainingDays,
                              specialCase: specialCase,
                            )
                          : Text(' (  انتهاء العرض  ) ',
                              style: KTextStyle.textStyle8.copyWith(
                                color: AppColors.greyLight,
                              )),
                      SizedBox(
                        height: 10.h,
                      ),
                      ActionButtonWidget(
                        title: 'تعديل عرض',
                        iconPath: "assets/update.svg",
                        isSolid: false,
                        onTap: widget.onUpdateTap,
                      ),
                      SizedBox(
                        height: 5.h,
                      ),
                      widget.isActive
                          ? ActionButtonWidget(
                              title: isActiveTitleButton!,
                              iconPath: "assets/stop.svg",
                              isSolid: false,
                              onTap: widget.onChangeStatusTap,
                            )
                          : ActionButtonWidget(
                              title: isActiveTitleButton!,
                              iconPath: "assets/active.svg",
                              isSolid: false,
                              onTap: widget.onChangeStatusTap,
                            ),
                      SizedBox(
                        height: 5.h,
                      ),
                      ActionButtonWidget(
                        title: 'حذف عرض',
                        iconPath: "assets/delete.svg",
                        isSolid: false,
                        onTap: widget.onDeleteTap,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
