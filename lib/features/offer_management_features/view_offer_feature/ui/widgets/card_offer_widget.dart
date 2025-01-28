import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/functions/view_offer_functions.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/all_action_button_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/container_status_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/remaining_notice_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/text_grey_light_widget.dart';

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
  int result = 0;
  String specialCase = '';
  dynamic remainingDays;
  bool? isRemainingDays;
  String? offerTypeTitle;
  String? isActiveTitleButton;
  @override
  void initState() {
    super.initState();
    ViewOfferFunctions.offerActiveTitleButton(
        widget.isActive, isActiveTitleButton!);
    ViewOfferFunctions.offerTypetitle(widget.typeName, offerTypeTitle!,
        widget.discountRate!, widget.numberToBuy!, widget.numberToGet!);
    ViewOfferFunctions.calculateRemainigDays(
        widget.endOffer, isRemainingDays!, result);
    ViewOfferFunctions.specialCasesInRemainigDays(
        result, specialCase, remainingDays);
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
                      EdgeInsets.only(top: 20.h, bottom: 20.h, right: 10.w),
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
                      SizedBox(height: 10.h),
                      TextGrayLightWidget(title: offerTypeTitle),
                      SizedBox(height: 10.h),
                      Row(
                        children: [
                          TextGrayLightWidget(title: "من "),
                          TextGrayLightWidget(
                              title:
                                  "${widget.startOffer.year}/${widget.startOffer.month}/${widget.startOffer.day}"),
                          TextGrayLightWidget(title: " الى  "),
                          TextGrayLightWidget(
                              title:
                                  "${widget.endOffer.year}/${widget.endOffer.month}/${widget.endOffer.day}"),
                        ],
                      ),
                      SizedBox(height: 20.h),
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
                          SizedBox(width: 5.w),
                          TextGrayLightWidget(title: "عدد المنتجات"),
                          SizedBox(width: 15.w),
                          widget.isActive == true
                              ? ContainerStatusWidget(
                                  color: AppColors.greenOpacity,
                                  iconPath: "assets/circle_green.svg",
                                  title: "نشط",
                                )
                              : ContainerStatusWidget(
                                  color: AppColors.redOpacity,
                                  iconPath: "assets/circle_red.svg",
                                  title: "غير نشط",
                                ),
                        ],
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.h, bottom: 20.h, left: 10.w),
                  child: Column(
                    children: [
                      RemainingNoticeWidget(
                        remainingDays: remainingDays,
                        specialCase: specialCase,
                        isRemainingDays: isRemainingDays,
                      ),
                      SizedBox(height: 10.h),
                      AllActionButtonWidget(
                        isActiveTitleButton: isActiveTitleButton!,
                        isActive: widget.isActive,
                        onUpdateTap: widget.onUpdateTap!,
                        onChangeStatusTap: widget.onChangeStatusTap!,
                        onDeleteTap: widget.onDeleteTap!,
                      )
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
