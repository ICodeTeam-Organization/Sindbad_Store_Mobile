import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/offer_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class CardOfferWidget extends StatefulWidget {
  final String offerName;
  final String offerType;
  final DateTime startOffer;
  final DateTime endOffer;
  final int countProducts;
  final bool isActive;
  const CardOfferWidget({super.key, required this.offerName, required this.offerType, required this.startOffer, required this.endOffer, required this.countProducts, required this.isActive});

  @override
  State<CardOfferWidget> createState() => _CardOfferWidgetState();
}

class _CardOfferWidgetState extends State<CardOfferWidget> {
    String? offerName;
    String? offerType;
    DateTime? startOffer;
    DateTime? endOffer;
    int? countProducts;
    bool? isActive;

    DateTime dateNow = DateTime.now();
    int result = 0;
    bool? isRemainingDays;

  @override
  void initState() {
    super.initState();
    offerName = widget.offerName;
    offerType = widget.offerName;
    startOffer = widget.startOffer;
    endOffer = widget.endOffer;
    countProducts = widget.countProducts;
    isActive = widget.isActive;
    remainigDays();

  }
    void remainigDays(){
      dateNow = dateNow.toUtc();
      if (dateNow.year<=endOffer!.year) {
        if (dateNow.day==31) {
        result = ((31+endOffer!.day)-dateNow.day)
        + (30*((11+endOffer!.month)-dateNow.month))
        + (360*((endOffer!.year-1)-dateNow.year));
        }
        result = ((30+endOffer!.day)-dateNow.day)
        + (30*((11+endOffer!.month)-dateNow.month))
        + (360*((endOffer!.year-1)-dateNow.year));
        isRemainingDays = true;
        if (result<=0) {
        isRemainingDays = false;
        }
      }
    }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
          color: AppColors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 200.h,
                color: AppColors.white,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text("أسم العرض : ",style: KTextStyle.textStyle14.copyWith(color: AppColors.greyDark,),),
                              Text(offerName!,style: KTextStyle.textStyle14.copyWith(color: AppColors.blackDark,),),
                            ],
                          ),
                          SizedBox(height: 15.h,),
                          Text(offerType!,style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Text("من ",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              Text("${startOffer!.year}/${startOffer!.month}/${startOffer!.day}",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              Text(" الى  ",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              Text("${endOffer!.year}/${endOffer!.month}/${endOffer!.day}",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            children: [
                              SizedBox(
                                width: 37.5.w,
                                height: 35.h,
                                child: Stack(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: SvgPicture.asset(
                                      "assets/bag_amount.svg",
                                      width: 20.w,
                                      height: 20.h,
                                      ),
                                    ),
                                  CircleAvatar(
                                    radius: 12.5,
                                    backgroundColor: AppColors.primaryBackground,
                                    child: Text(countProducts.toString(),style: KTextStyle.textStyle9.copyWith(color: AppColors.primary,),),
                                    ),
                                 ]
                                ),
                              ),
                              SizedBox(width: 5.w,),
                              Text("عدد الأصناف",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              SizedBox(width: 15.w,),
                              SvgPicture.asset(
                                "assets/circle_green.svg",
                                width: 9.w,
                                height: 9.h,
                              ),
                              SizedBox(width: 5.w,),
                              Text("نشط",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(25.0),
                      child: Column(
                        children: [
                          isRemainingDays == true ?
                          Row(
                            children: [
                              Text('( متبقي ',style: KTextStyle.textStyle8.copyWith(color: AppColors.greyLight,),),
                              Text(result.toString(),style: KTextStyle.textStyle8.copyWith(color: AppColors.primary,),),
                              Text(' أيام على الانتهاء )',style: KTextStyle.textStyle8.copyWith(color: AppColors.greyLight,),),
                            ],
                          ):
                          Text(' ( انتهاء العرض   ) ',style: KTextStyle.textStyle8.copyWith(color: AppColors.greyLight,),),
                          SizedBox(height: 10.h,),
                          ActionButtonWidget(
                            title: 'تعديل عرض',
                            iconPath: "assets/update.svg",
                            isSolid: false,
                          ),
                          SizedBox(height: 5.h,),
                          ActionButtonWidget(
                            title: 'ايقاف عرض',
                            iconPath: "assets/stop.svg",
                            isSolid: false,
                          ),
                          SizedBox(height: 5.h,),
                          ActionButtonWidget(
                            title: 'حذف عرض',
                            iconPath: "assets/delete.svg",
                            isSolid: false,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
      ),
    );
  }
}