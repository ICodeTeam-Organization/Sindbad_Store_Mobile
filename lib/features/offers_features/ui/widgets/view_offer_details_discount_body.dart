import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_message_widget.dart';

class ViewOfferDetailsDiscountBody extends StatefulWidget {
  final String offerName; // Add this line to accept the nameOffer
  final int offerId; // Add this line to accept the nameOffer

  // Modify the constructor to accept nameOffer
  const ViewOfferDetailsDiscountBody({
    super.key,
    required this.offerName,
    required this.offerId,
  });

  @override
  State<ViewOfferDetailsDiscountBody> createState() =>
      _ViewOfferDetailsDiscountBodyState();
}

class _ViewOfferDetailsDiscountBodyState
    extends State<ViewOfferDetailsDiscountBody> {
  late String offerTypeTitle;
  @override
  void initState() {
    super.initState();
    offerTypeTitle = 'المنتجات بعد الخصم';
    // context.read<OfferDetailsCubit>().getOfferDetails(10, 1, widget.offerId);
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
                          scrollDirection: Axis.vertical,
                          itemCount: 0,
                          physics: const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return SizedBox();
                            //  CardOfferDetailsDiscountWidget(
                            //   productName: state.offerProducts[i].productTitle,
                            //   productImage: state.offerProducts[i].productImage,
                            //   lastPrice: state.offerDetails[i].oldPrice!,
                            //   newPrice: state.offerDetails[i].newPrice!,
                            // );
                          },
                        ),
                      ),
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
    );
  }
}
