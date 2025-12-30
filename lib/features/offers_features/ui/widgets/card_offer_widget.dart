import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/config/styles/colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/all_action_button_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/container_status_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/remaining_notice_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/text_grey_light_widget.dart';

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
    offerActiveTitleButton();
    offerTypetitle();
    calculateRemainigDays();
    specialCasesInRemainigDays();
  }

  void offerActiveTitleButton() {
    if (widget.isActive == true) {
      isActiveTitleButton = 'ايقاف عرض';
    } else {
      isActiveTitleButton = 'تنشيط عرض';
    }
  }

  void offerTypetitle() {
    if (widget.typeName == 'Percent') {
      offerTypeTitle = '${widget.discountRate}% من إجمالي الخصم';
    } else if (widget.typeName == 'Bonus') {
      offerTypeTitle =
          ' اشتري ${widget.numberToBuy} واحصل على ${widget.numberToGet}';
    } else {
      offerTypeTitle = ''; // Default to empty to avoid null title.
    }
  }

  void calculateRemainigDays() {
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

  void specialCasesInRemainigDays() {
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
                      // Wrap the row in SingleChildScrollView to avoid overflow
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Row(
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
                        isActive: widget.isActive,
                        isActiveTitleButton: isActiveTitleButton,
                        onUpdateTap: widget.onUpdateTap,
                        onChangeStatusTap: widget.onChangeStatusTap,
                        onDeleteTap: widget.onDeleteTap,
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
