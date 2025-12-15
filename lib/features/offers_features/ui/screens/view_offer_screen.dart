import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/dialogs/delete_confirm_dialog.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_message_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_offer_widget.dart';
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

  VoidCallback _onChangeStatusTap(int offerHeadId) {
    return () {
      showDialog(
        context: context,
        builder: (context) => CustomDialogWidget(
          isWarning: false,
          confirmText: 'نعم , قم بتغيير الحالة',
          title: 'هل انت متأكد من تغيير حالة العرض ؟',
          subtitle: '',
          iconPath: "assets/change_status.svg",
          onConfirm: () async {
            await context.read<OfferCubit>().changeStatusOffer(offerHeadId);
          },
        ),
      );
    };
  }

  VoidCallback _onUpdateTap(int offerHeadId) {
    return () {
      context.push(AppRoutes.updateOffer, extra: [offerHeadId]);
    };
  }

  VoidCallback _onDeleteTap(int offerHeadId) {
    return () {
      showDeleteConfirmDialog(
        context: context,
        title: 'هل انت متأكد من الحذف ؟',
        message: 'سيتم حذف هذا العرض, هل تريد المتابعة ',
        onConfirm: () async {
          await context.read<OfferCubit>().deleteOffer(offerHeadId);
        },
      );
    };
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
              BlocConsumer<OfferCubit, OfferState>(
                listener: (context, state) {
                  if (state is OfferLoadFailuer) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.errMessage)),
                    );
                  } else if (state is OfferAddSuccess) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('تمت إضافة العرض بنجاح')),
                    );
                    // Refresh offers list after adding
                    context.read<OfferCubit>().getOffers(100, 1);
                  }
                },
                buildWhen: (previous, current) =>
                    current is! OfferLoadInProgress ||
                    context.read<OfferCubit>().offers.isEmpty,
                builder: (context, state) {
                  final offerCubit = context.read<OfferCubit>();
                  final offers = offerCubit.offers;

                  if (state is OfferInitial ||
                      (state is OfferLoadInProgress && offers.isEmpty)) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is OfferLoadSuccess ||
                      (state is OfferLoadInProgress && offers.isNotEmpty)) {
                    return offers.isEmpty
                        ? Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await context
                                    .read<OfferCubit>()
                                    .getOffers(100, 1);
                              },
                              child: ListView(
                                physics: const AlwaysScrollableScrollPhysics(),
                                children: [
                                  CardMesssageWidget(
                                    logo: Image.asset(
                                      'assets/image_loading.png',
                                      height: 80.h,
                                      width: 80.w,
                                    ),
                                    title: 'لم تضف اي عروض حتى الان!',
                                    subTitle:
                                        'شجع عملائك على الشراء بتقديم عروض مغرية',
                                    extra: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
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
                                  ),
                                ],
                              ),
                            ),
                          )
                        : Expanded(
                            child: RefreshIndicator(
                              onRefresh: () async {
                                await context
                                    .read<OfferCubit>()
                                    .getOffers(100, 1);
                              },
                              child: ListView.builder(
                                scrollDirection: Axis.vertical,
                                itemCount: offers.length,
                                physics: const AlwaysScrollableScrollPhysics(),
                                itemBuilder: (context, i) {
                                  final offer = offers[i];
                                  final offerHeadId = offer.offerId;
                                  return Column(
                                    children: [
                                      InkWell(
                                        onTap: () {
                                          context.push(AppRoutes.offerDetails,
                                              extra: [
                                                offer.offerId,
                                                offer.offerTitle,
                                                offer.typeName
                                              ]);
                                        },
                                        child: CardOfferWidget(
                                          offerId: offer.offerId,
                                          offerTitle: offer.offerTitle,
                                          typeName: offer.typeName,
                                          isActive: offer.isActive,
                                          startOffer: offer.startOffer,
                                          endOffer: offer.endOffer,
                                          countProducts: offer.countProducts,
                                          numberToBuy: offer.numberToBuy,
                                          numberToGet: offer.numberToGet,
                                          discountRate: offer.discountRate,

                                          //here update button
                                          onUpdateTap:
                                              _onUpdateTap(offerHeadId),

                                          //here Change Status button
                                          onChangeStatusTap:
                                              _onChangeStatusTap(offerHeadId),

                                          //here Delete button
                                          onDeleteTap:
                                              _onDeleteTap(offerHeadId),
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
                            ),
                          );
                  } else if (state is OfferLoadFailuer) {
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
