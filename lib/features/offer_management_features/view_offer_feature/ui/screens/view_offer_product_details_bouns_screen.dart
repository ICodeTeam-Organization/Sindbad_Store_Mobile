import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/card_offer_product_details_bouns_widget.dart';

class ViewOfferProductDetailsBounsScreen extends StatefulWidget {
  final String offerName;

  const ViewOfferProductDetailsBounsScreen({
    super.key,
    required this.offerName,
  });

  @override
  State<ViewOfferProductDetailsBounsScreen> createState() =>
      _ViewOfferProductDetailsBounsScreenState();
}

class _ViewOfferProductDetailsBounsScreenState
    extends State<ViewOfferProductDetailsBounsScreen> {
  late String offerTypeTitle;

  @override
  void initState() {
    super.initState();
    offerTypeTitle = 'المنتجات بعد عمل البونص';
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
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                    color: AppColors.white,
                    child: ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            CardOfferProductDetailsBounsWidget(
                              productName: 'MacBook Air',
                              productImage: "assets/image_example.png",
                              buysCount: 2,
                              freesCount: 1,
                            ),
                          ],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
