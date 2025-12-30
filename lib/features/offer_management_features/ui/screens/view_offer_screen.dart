import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/features/offer_management_features/ui/widgets/card_offer_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_message_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/custom_dialog_widget.dart';

class ViewOfferScreen extends StatefulWidget {
  const ViewOfferScreen({super.key});

  @override
  State<ViewOfferScreen> createState() => _ViewOfferScreenState();
}

class _ViewOfferScreenState extends State<ViewOfferScreen> {
  @override
  void initState() {
    super.initState();
    context.read<OfferCubit>().getOffers(100, 1);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      body: SafeArea(
        child: Container(
          color:
              isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                tital: 'العروض',
                isBack: false,
              ),
              Padding(
                  padding: const EdgeInsets.all(30.0),
                  child: ActionButtonWidget(
                    title: 'إضافة عرض',
                    iconPath: 'assets/add.svg',
                    onTap: () {
                      context.push(
                        AppRoutes.newOffer,
                      );
                    },
                  )),
              BlocBuilder<OfferCubit, OfferState>(
                builder: (context, state) {
                  if (state is OfferLoadSuccess) {
                    final offers = context.read<OfferCubit>().offers;
                    return offers.isEmpty
                        ? CardMesssageWidget(
                            logo: Image.asset(
                              'assets/image_loading.png',
                              height: 80.h,
                              width: 80.w,
                            ),
                            title: 'لم تضف اي عروض حتى الان!',
                            subTitle: 'شجع عملائك على الشراء بتقديم عروض مغرية',
                            extra: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                SizedBox(height: 20.h),
                                ActionButtonWidget(
                                  title: 'إضافة عرض',
                                  iconPath: 'assets/add.svg',
                                  onTap: () {
                                    context.push(
                                      AppRoutes.newOffer,
                                    );
                                  },
                                )
                              ],
                            ),
                          )
                        : Expanded(
                            child: ListView.builder(
                              scrollDirection: Axis.vertical,
                              itemCount: offers.length,
                              physics: const AlwaysScrollableScrollPhysics(),
                              itemBuilder: (context, i) {
                                late int offerHeadId = offers[i].offerId;
                                return Column(
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        context.push(AppRoutes.offerDetails,
                                            extra: [
                                              offers[i].offerId,
                                              offers[i].offerTitle,
                                              offers[i].typeName
                                            ]);
                                      },
                                      child: CardOfferWidget(
                                        offerId: offers[i].offerId,
                                        offerTitle: offers[i].offerTitle,
                                        typeName: offers[i].typeName,
                                        isActive: offers[i].isActive,
                                        startOffer: offers[i].startOffer,
                                        endOffer: offers[i].endOffer,
                                        countProducts: offers[i].countProducts,
                                        numberToBuy: offers[i].numberToBuy,
                                        numberToGet: offers[i].numberToGet,
                                        discountRate: offers[i].discountRate,

                                        //here update button
                                        onUpdateTap: () {
                                          context.push(AppRoutes.updateOffer,
                                              extra: [
                                                offerHeadId,
                                              ]);
                                        },

                                        //here Change Status button
                                        onChangeStatusTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return CustomDialogWidget(
                                                isWarning: false,
                                                confirmText:
                                                    'نعم , قم بتغيير الحالة',
                                                title:
                                                    'هل انت متأكد من تغيير حالة العرض ؟',
                                                subtitle: '',
                                                iconPath:
                                                    "assets/change_status.svg",
                                                onConfirm: () async {
                                                  Navigator.pop(dialogContext);
                                                  await context
                                                      .read<OfferCubit>()
                                                      .changeStatusOffer(
                                                          offerHeadId);
                                                },
                                              );
                                            },
                                          );
                                        },

                                        //here Delete button
                                        onDeleteTap: () {
                                          showDialog(
                                            context: context,
                                            builder:
                                                (BuildContext dialogContext) {
                                              return CustomDialogWidget(
                                                title:
                                                    'هل انت متأكد من الحذف ؟',
                                                subtitle:
                                                    'يوجد بيانات مرتبطة بهذا المدخل',
                                                onConfirm: () async {
                                                  Navigator.pop(dialogContext);
                                                  await context
                                                      .read<OfferCubit>()
                                                      .deleteOffer(offerHeadId);
                                                },
                                              );
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    if (i == offers.length - 1)
                                      SizedBox(
                                        height: 120.h,
                                      ),
                                  ],
                                );
                              },
                            ),
                          );
                  } else if (state is OffersLoadFailuer) {
                    return Center(
                      child: CardMesssageWidget(
                        logo: Image.asset(
                          'assets/image_loading.png',
                          height: 80.h,
                          width: 80.w,
                        ),
                        title: 'هناك خطأ الرجاء المحاولة لاحقاً',
                        subTitle: state.errMessage,
                      ),
                    );
                  } else if (state is OfferLoadInProgress) {
                    return Center(child: CircularProgressIndicator());
                  } else {
                    return Center(
                      child: CardMesssageWidget(
                        logo: Image.asset(
                          'assets/image_loading.png',
                          height: 80.h,
                          width: 80.w,
                        ),
                        title: 'لم يتم جلب المعلومات!!',
                        subTitle: '',
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
