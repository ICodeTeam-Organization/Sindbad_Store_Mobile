import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_features/view_offer_feature/ui/widgets/action_button_widget.dart';

class ViewOfferScreen extends StatefulWidget {
  const ViewOfferScreen({super.key});

  @override
  State<ViewOfferScreen> createState() => _ViewOfferScreenState();
}

class _ViewOfferScreenState extends State<ViewOfferScreen> {
    DateTime startOffer = DateTime.utc(2024, 5, 1);
    DateTime endOffer = DateTime.utc(2024, 5, 30);
    DateTime dateNow = DateTime.now();
    int result = 0;
  @override
  void initState() {
    super.initState();
    dateNow = dateNow.toUtc();
    if (dateNow.month>endOffer.month && dateNow.day>endOffer.day) {
      result = ((30+endOffer.day)-dateNow.day)
      + (30*((11+endOffer.month)-dateNow.month))
      + (360*((endOffer.year-1)-dateNow.year));
    }
  }
  @override
  Widget build(BuildContext context) {    
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.transparent,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                tital: 'العروض',
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ActionButtonWidget(
                  title: 'إضافة عرض',
                  iconPath: "assets/add.svg",
                )
              ),
              Container(
                height: 160.h,
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
                              Text("يوم الجمعة",style: KTextStyle.textStyle14.copyWith(color: AppColors.blackDark,),),
                            ],
                          ),
                          SizedBox(height: 15.h,),
                          Text("10% من إجمالي الخصم",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                          SizedBox(height: 10.h,),
                          Row(
                            children: [
                              Text("من ",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              Text("${startOffer.year}/${startOffer.month}/${startOffer.day}",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              Text(" الى  ",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                              Text("${endOffer.year}/${endOffer.month}/${endOffer.day}",style: KTextStyle.textStyle11.copyWith(color: AppColors.greyLight,),),
                            ],
                          ),
                          SizedBox(height: 20.h,),
                          Row(
                            children: [
                              Container(
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
                                    child: Text("17",style: KTextStyle.textStyle9.copyWith(color: AppColors.primary,),),
                                    radius: 12.5,
                                    backgroundColor: AppColors.primaryBackground,
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
                          Row(
                            children: [
                              Text('( متبقي ',style: KTextStyle.textStyle8.copyWith(color: AppColors.greyLight,),),
                              Text(result.toString(),style: KTextStyle.textStyle8.copyWith(color: AppColors.primary,),),
                              Text(' أيام على الانتهاء )',style: KTextStyle.textStyle8.copyWith(color: AppColors.greyLight,),),
                            ],
                          ),
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
      ),
    );
  }
}