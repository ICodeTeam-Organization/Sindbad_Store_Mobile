import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/card_offer_widget.dart';

class ViewOfferBody extends StatefulWidget {
  const ViewOfferBody({super.key});

  @override
  State<ViewOfferBody> createState() => _ViewOfferBodyState();
}

class _ViewOfferBodyState extends State<ViewOfferBody> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<OfferCubit>(context).getOffer(10, 1);
    context.read<OfferCubit>().getOffer(10, 1);
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
                      AppRouter.storeRouters.kNewOffer,
                    );
                  },
                )),
            BlocBuilder<OfferCubit, OfferState>(
              builder: (context, state) {
                if (state is OfferSuccess) {
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
                                offerTitle: state.offer[i].offerTitle,
                                typeName: state.offer[i].typeName,
                                isActive: state.offer[i].isActive,
                                startOffer: state.offer[i].startOffer,
                                endOffer: state.offer[i].endOffer,
                                countProducts: state.offer[i].countProducts,
                                numberToBuy: state.offer[i].numberToBuy,
                                numberToGet: state.offer[i].numberToGet,
                                discountRate: state.offer[i].discountRate,
                                // offerBouns: 'اشتري x واحصل على y',
                                // startOffer: DateTime.utc(2024, 5, 1),
                                // endOffer: DateTime.utc(2024, 11, 27),
                                // isActive: true,
                                // countProducts: '17',
                                // offerType: offerType!,
                              ),
                            ),
                            Divider(),
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
