import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/utils/route.dart';

class StoreHomePageListViewWidget extends StatelessWidget {
  const StoreHomePageListViewWidget({
    super.key,
    required this.bondNum,
    required this.date,
    required this.itemNum,
  });
  final String bondNum;
  final String date;
  final String itemNum;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        padding: EdgeInsets.zero,
        itemCount: 10,
        itemBuilder: (context, i) {
          return InkWell(
            onTap: () {
              GoRouter.of(context)
                  .push(AppRouter.storeRouters.kStoreOrderProcessing);
            },
            child: Container(
              margin: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 8.w),
              height: 100.h,
              width: 343.w,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: AppColors.primaryColor,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        offset: Offset(-1, 1),
                        blurRadius: 1)
                  ]),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Text(
                        "رقم الطلب:  ",
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.greyHint),
                      ),
                      Text(
                        bondNum,
                        style: KTextStyle.secondaryTitle
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "التاريخ:  ",
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.greyHint),
                      ),
                      Text(
                        date,
                        style: KTextStyle.secondaryTitle
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        "عدد الاصناف:  ",
                        style: KTextStyle.secondaryTitle
                            .copyWith(color: AppColors.greyHint),
                      ),
                      Text(
                        itemNum,
                        style: KTextStyle.secondaryTitle
                            .copyWith(fontWeight: FontWeight.w400),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          );
        });
  }
}
