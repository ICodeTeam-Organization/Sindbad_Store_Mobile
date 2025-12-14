import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/change_status_offer_cubit/change_status_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/delete_offer_cubit/delete_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/card_message_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/card_offer_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/custom_dialog_widget.dart';

class ViewOfferBody extends StatefulWidget {
  const ViewOfferBody({super.key});

  @override
  State<ViewOfferBody> createState() => _ViewOfferBodyState();
}

class _ViewOfferBodyState extends State<ViewOfferBody> {
  @override
  void initState() {
    super.initState();
    context.read<OfferCubit>().getOffer(100, 1);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
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
            BlocBuilder<OfferCubit, OfferState>(
              builder: (context, state) {
                if (state is OfferSuccess) {
                  return state.offer.isEmpty
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
                            itemCount: state.offer.length,
                            physics: const AlwaysScrollableScrollPhysics(),
                            itemBuilder: (context, i) {
                              late int offerHeadId = state.offer[i].offerId;
                              return Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      context.push(AppRoutes.offerDetails,
                                          extra: [
                                            state.offer[i].offerId,
                                            state.offer[i].offerTitle,
                                            state.offer[i].typeName
                                          ]);
                                    },
                                    child: CardOfferWidget(
                                      offerId: state.offer[i].offerId,
                                      offerTitle: state.offer[i].offerTitle,
                                      typeName: state.offer[i].typeName,
                                      isActive: state.offer[i].isActive,
                                      startOffer: state.offer[i].startOffer,
                                      endOffer: state.offer[i].endOffer,
                                      countProducts:
                                          state.offer[i].countProducts,
                                      numberToBuy: state.offer[i].numberToBuy,
                                      numberToGet: state.offer[i].numberToGet,
                                      discountRate: state.offer[i].discountRate,

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
                                          context:
                                              context, // Ensure this context has access to the provider
                                          builder:
                                              (BuildContext dialogContext) {
                                            return BlocConsumer<
                                                ChangeStatusOfferCubit,
                                                ChangeStatusOfferState>(
                                              listener: (context, state) {
                                                if (state
                                                    is ChangeStatusOfferFailure) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(state
                                                            .errorMessage)),
                                                  );
                                                  Navigator.pop(
                                                      dialogContext); // Close the dialog
                                                } else if (state
                                                    is ChangeStatusOfferSuccess) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(
                                                    SnackBar(
                                                        content: Text(state
                                                            .changeStatusOffer)),
                                                  );
                                                  context
                                                      .read<OfferCubit>()
                                                      .getOffer(100, 1);

                                                  Navigator.pop(
                                                      dialogContext); // Close the dialog
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is ChangeStatusOfferLoading) {
                                                  return CustomDialogWidget(
                                                    isLoading: true,
                                                    isWarning: false,
                                                    confirmText:
                                                        'نعم , قم بتغيير الحالة',
                                                    title:
                                                        'هل انت متأكد من تغيير حالة العرض ؟',
                                                    subtitle: '',
                                                    iconPath:
                                                        "assets/change_status.svg",
                                                    onConfirm: () {},
                                                  );
                                                }
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
                                                    await context
                                                        .read<
                                                            ChangeStatusOfferCubit>()
                                                        .changeStatusOffer(
                                                            offerHeadId);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },

                                      //here Change Status button
                                      onDeleteTap: () {
                                        showDialog(
                                          context: context,
                                          builder:
                                              (BuildContext contextDialog) {
                                            return BlocConsumer<
                                                DeleteOfferCubit,
                                                DeleteOfferState>(
                                              listener: (context, state) {
                                                if (state
                                                    is DeleteOfferFailure) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                    state.errorMessage
                                                        .toString(),
                                                  )));
                                                  Navigator.pop(context);
                                                } else if (state
                                                    is DeleteOfferSuccess) {
                                                  ScaffoldMessenger.of(context)
                                                      .showSnackBar(SnackBar(
                                                          content: Text(
                                                    state.deleteOffer
                                                        .toString(),
                                                  )));
                                                  context
                                                      .read<OfferCubit>()
                                                      .getOffer(100, 1);
                                                  Navigator.pop(context);
                                                }
                                              },
                                              builder: (context, state) {
                                                if (state
                                                    is DeleteOfferLoading) {
                                                  return CustomDialogWidget(
                                                    isLoading: true,
                                                    title:
                                                        'هل انت متأكد من الحذف ؟',
                                                    subtitle:
                                                        'يوجد بيانات مرتبطة بهذا المدخل',
                                                    onConfirm: () {},
                                                  );
                                                }

                                                return CustomDialogWidget(
                                                  title:
                                                      'هل انت متأكد من الحذف ؟',
                                                  subtitle:
                                                      'يوجد بيانات مرتبطة بهذا المدخل',
                                                  onConfirm: () async {
                                                    await context
                                                        .read<
                                                            DeleteOfferCubit>()
                                                        .deleteOffer(
                                                            offerHeadId);
                                                  },
                                                );
                                              },
                                            );
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  if (i == state.offer.length - 1)
                                    SizedBox(
                                      height: 120.h,
                                    ),
                                ],
                              );
                            },
                          ),
                        );
                } else if (state is OfferFailuer) {
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
                } else if (state is OfferLoading) {
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
    );
  }
}
