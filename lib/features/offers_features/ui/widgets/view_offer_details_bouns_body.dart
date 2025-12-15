import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_details_cubit/offer_details_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_details_cubit/offer_details_state.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_message_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_offer_details_bouns_widget.dart';

class ViewOfferDetailsBounsBody extends StatefulWidget {
  final String offerName;
  final int offerId; // Add this line to accept the nameOffer

  const ViewOfferDetailsBounsBody({
    super.key,
    required this.offerName,
    required this.offerId,
  });

  @override
  State<ViewOfferDetailsBounsBody> createState() =>
      _ViewOfferDetailsBounsBodyState();
}

class _ViewOfferDetailsBounsBodyState extends State<ViewOfferDetailsBounsBody> {
  late String offerTypeTitle;

  @override
  void initState() {
    super.initState();
    offerTypeTitle = 'المنتجات بعد عمل البونص';
    // context.read<OfferDetailsCubit>().getOfferDetails(10, 1, widget.offerId);
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
                tital: widget.offerName,
              ),
              SizedBox(height: 30.h),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  offerTypeTitle,
                  style: KTextStyle.textStyle14.copyWith(
                    color: AppColors.blackLight,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              BlocBuilder<OfferCubit, OfferState>(
                builder: (context, state) {
                  if (state is OfferLoadSuccess) {
                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: AppColors.greyBorder),
                            color: AppColors.white,
                          ),
                          child: ListView.builder(
                            itemCount: 0,
                            itemBuilder: (context, i) {
                              return Column(
                                children: [
                                  // CardOfferDetailsBounsWidget(
                                  //   productName:
                                  //       state.offerDetails[i].productTitle,
                                  //   productImage:
                                  //       state.offerDetails[i].productImage,
                                  //   numberToBuy:
                                  //       state.offerDetails[i].numberToBuy!,
                                  //   numberToGet:
                                  //       state.offerDetails[i].numberToGet!,
                                  // ),
                                ],
                              );
                            },
                          ),
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
                        subTitle: 'الخطأ : ${state.errMessage}',
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
