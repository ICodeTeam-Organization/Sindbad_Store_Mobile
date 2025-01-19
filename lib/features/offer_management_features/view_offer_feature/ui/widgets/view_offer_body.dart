import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/change_status_offer_cubit/change_status_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/delete_offer_cubit/delete_offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/card_offer_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/custom_delete_dialog_widget.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/function/image_picker_function.dart';

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

  late int offerHeadId;
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
                      AppRouter.storeRouters.kNewOffer,
                    );
                  },
                )),
            BlocBuilder<OfferCubit, OfferState>(
              builder: (context, state) {
                if (state is OfferSuccess) {
                  if (state.offer.isEmpty) {
                    return CardIfEmptyWidget();
                  }
                  return Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.vertical,
                      itemCount:
                          state.offer.length, // Use the length of the list
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                print(
                                    '${state.offer[i].offerId}--------------------------------------------------');
                                if (state.offer[i].typeName == 'Percent') {
                                  context.push(
                                      AppRouter.storeRouters
                                          .kOfferProductDetailsDiscount,
                                      extra: [
                                        state.offer[i].offerTitle,
                                        state.offer[i].offerId,
                                      ]);
                                } else if (state.offer[i].typeName == 'Bonus') {
                                  context.push(
                                      AppRouter.storeRouters
                                          .kOfferProductDetailsBouns,
                                      extra: [
                                        state.offer[i].offerTitle,
                                        state.offer[i].offerId,
                                      ]);
                                }
                              },
                              child: CardOfferWidget(
                                offerId: state.offer[i].offerId,
                                offerTitle: state.offer[i].offerTitle,
                                typeName: state.offer[i].typeName,
                                isActive: state.offer[i].isActive,
                                startOffer: state.offer[i].startOffer,
                                endOffer: state.offer[i].endOffer,
                                countProducts: state.offer[i].countProducts,
                                numberToBuy: state.offer[i].numberToBuy,
                                numberToGet: state.offer[i].numberToGet,
                                discountRate: state.offer[i].discountRate,

                                ///
                                onUpdateTap: () {
                                  context.push(
                                      AppRouter.storeRouters.kUpdateOffer,
                                      extra: [
                                        state.offer[i].offerId,
                                      ]);
                                },

                                ///
                                onChangeStatusTap: () {
                                  offerHeadId = state.offer[i].offerId;
                                  showDialog(
                                    context:
                                        context, // Ensure this context has access to the provider
                                    builder: (BuildContext dialogContext) {
                                      return BlocConsumer<
                                          ChangeStatusOfferCubit,
                                          ChangeStatusOfferState>(
                                        listener: (context, state) {
                                          if (state
                                              is ChangeStatusOfferFailure) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content:
                                                      Text(state.errorMessage)),
                                            );
                                            Navigator.pop(
                                                dialogContext); // Close the dialog
                                          } else if (state
                                              is ChangeStatusOfferSuccess) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                  content: Text(
                                                      state.changeStatusOffer)),
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
                                              isDelete: false,
                                              confirmText:
                                                  'نعم , قم بتغيير الحالة',
                                              title:
                                                  'هل انت متأكد من تغيير حالة العرض ؟',
                                              subtitle: '',
                                              iconPath:
                                                  "assets/change_status.svg",
                                              onConfirm: () async {},
                                            );
                                          }
                                          return CustomDialogWidget(
                                            isDelete: false,
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
                                              print(
                                                  'Item Actived $offerHeadId');
                                              await context
                                                  .read<OfferCubit>()
                                                  .getOffer(100, 1);
                                            },
                                          );
                                        },
                                      );
                                    },
                                  );
                                },

                                ///
                                onDeleteTap: () {
                                  offerHeadId = state.offer[i].offerId;
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext contextDialog) {
                                      return BlocConsumer<DeleteOfferCubit,
                                          DeleteOfferState>(
                                        listener: (context, state) {
                                          if (state is DeleteOfferFailure) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              state.errorMessage.toString(),
                                            )));
                                            Navigator.pop(context);
                                          } else if (state
                                              is DeleteOfferSuccess) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                              state.deleteOffer.toString(),
                                            )));
                                            context
                                                .read<OfferCubit>()
                                                .getOffer(100, 1);

                                            Navigator.pop(context);
                                          }
                                        },
                                        builder: (context, state) {
                                          if (state is DeleteOfferLoading) {
                                            return CustomDialogWidget(
                                              isLoading: true,
                                              title: 'هل انت متأكد من الحذف ؟',
                                              subtitle:
                                                  'يوجد بيانات مرتبطة بهذا المدخل',
                                              onConfirm: () async {},
                                            );
                                          }

                                          return CustomDialogWidget(
                                            title: 'هل انت متأكد من الحذف ؟',
                                            subtitle:
                                                'يوجد بيانات مرتبطة بهذا المدخل',
                                            onConfirm: () async {
                                              await context
                                                  .read<DeleteOfferCubit>()
                                                  .deleteOffer(offerHeadId);
                                              print(
                                                  'Item deleted $offerHeadId');
                                              await context
                                                  .read<OfferCubit>()
                                                  .getOffer(100, 1);
                                              setState(() {});
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
                  return Center(child: Text(state.errMessage));
                } else if (state is OfferLoading) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return Center(
                    child: Container(
                      color: Colors.red.shade400,
                      height: 50,
                      width: 300,
                      child: Text('لم يتم الوصول الى المعلومات'),
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

class CardIfEmptyWidget extends StatelessWidget {
  const CardIfEmptyWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(30.0),
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(color: AppColors.greyBorder),
                  borderRadius: BorderRadius.circular(25.r),
                  color: Colors.white,
                ),
                alignment: Alignment.center,
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/image_loading.png',
                        height: 80.h,
                        width: 80.w,
                      ),
                      Text(
                        'لم تضف اي عروض حتى الان!',
                        style: KTextStyle.textStyle16.copyWith(
                          color: AppColors.blackDark,
                        ),
                      ),
                      Text(
                        'شجع عملائك على الشراء بتقديم عروض مغرية',
                        style: KTextStyle.textStyle12.copyWith(
                          color: AppColors.greyLight,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      ActionButtonWidget(
                        title: 'إضافة عرض',
                        iconPath: 'assets/add.svg',
                        onTap: () {
                          context.push(
                            AppRouter.storeRouters.kNewOffer,
                          );
                        },
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
