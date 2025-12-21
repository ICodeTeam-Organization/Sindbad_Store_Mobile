import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/animated_order_item.dart';

// Global variables for order details navigation
int? idOrders;
int? idPackages;
String? orderNumbers;
String? billNumbers;
String? clocks;
String? dates;
String? itemNumbers;
String? paymentInfos;
String? orderStatuss;
Color? orderColors;

class OrderCardWidget extends StatelessWidget {
  final AllOrderEntity order;
  final int index;
  final bool animate;

  const OrderCardWidget({
    super.key,
    required this.order,
    required this.index,
    required this.animate,
  });

  Color _getOrderColor(String orderStatus) {
    // بدون فاتورة
    if (orderStatus == '2') {
      return Color(0xffE8E8E8);
    }
    // لم تسدد
    else if (orderStatus == '3') {
      return Color(0xCCFFF2F5);
    }
    // للشحن
    else if (orderStatus == '4') {
      return Color(0xffCEECF0);
    }
    // السابقة
    else if (orderStatus == '5' || orderStatus == '6') {
      return Color(0xffCDE8F6);
    }
    // غيره
    else {
      return Colors.white;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final orderColor = _getOrderColor(order.orderStatuse);

    return AnimatedOrderItem(
      index: index,
      animate: animate,
      child: Column(
        children: [
          InkWell(
            onTap: () {
              idOrders = order.idOrder;
              idPackages = order.idPackage;
              orderNumbers = order.orderNum;
              billNumbers = order.orderBill;
              dates = order.orderDates;
              itemNumbers = order.productMount;
              paymentInfos = order.payStatus;
              orderStatuss = order.orderStatuse;
              orderColors = orderColor;
              context.push(AppRoutes.details, extra: order.idPackage);
            },
            child: Container(
              margin: EdgeInsets.all(5),
              decoration: BoxDecoration(
                border: Border.all(color: AppColors.grey),
                borderRadius: BorderRadius.circular(16.r),
              ),
              width: 380.w,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // ===== TOP INFO ORDER (inlined) =====
                  Container(
                    constraints: BoxConstraints(minHeight: 50.h),
                    padding:
                        EdgeInsets.symmetric(vertical: 6.h, horizontal: 8.w),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom:
                            BorderSide(color: AppColors.greyHint, width: 0.3),
                      ),
                      color: orderColor,
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: order.orderNum.length >= 5
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(l10n.orderNumber,
                                        style: KTextStyle.textStyle12),
                                    SizedBox(height: 4.h),
                                    Text(
                                      order.orderNum,
                                      style: KTextStyle.textStyle14,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                flex: 1,
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(l10n.billNumber,
                                        style: KTextStyle.textStyle12),
                                    SizedBox(height: 4.h),
                                    Text(
                                      order.orderBill,
                                      style: KTextStyle.textStyle14,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Flexible(
                                child: Text(
                                  '${l10n.orderNumber} ${order.orderNum}',
                                  style: KTextStyle.textStyle12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                              SizedBox(width: 8.w),
                              Flexible(
                                child: Text(
                                  '${l10n.billNumber} ${order.orderBill}',
                                  style: KTextStyle.textStyle12,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                  ),
                  SizedBox(height: 10.h),
                  // ===== BOTTOM INFO ORDER (inlined) =====
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: Row(
                            children: [
                              SvgPicture.asset(
                                "assets/alarm.svg",
                                width: 24,
                                height: 24,
                              ),
                              SizedBox(width: 10.w),
                              Text(
                                order.orderDates,
                                style: KTextStyle.textStyle12,
                              ),
                            ],
                          ),
                        ),
                        Padding(
                          padding: (MediaQuery.sizeOf(context).width) >= 480
                              ? const EdgeInsets.only(left: 35)
                              : const EdgeInsets.only(left: 15),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 40.w,
                                height: 40.h,
                                child: Stack(children: [
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: SvgPicture.asset(
                                      "assets/Bag.svg",
                                      width: 24,
                                      height: 24,
                                    ),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Text(
                                      order.productMount,
                                      style: KTextStyle.textStyle12.copyWith(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ]),
                              ),
                              Text(l10n.itemCount,
                                  style: KTextStyle.textStyle12),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                  // ===== PAYMENT INFO =====
                  Container(
                    padding: EdgeInsets.only(right: 35.w, bottom: 10.w),
                    child: Row(
                      children: [
                        Text('${l10n.paymentInfo}: ',
                            style: KTextStyle.textStyle12),
                        Text(order.payStatus, style: KTextStyle.textStyle12),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
