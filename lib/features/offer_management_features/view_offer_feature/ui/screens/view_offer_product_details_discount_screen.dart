import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/card_offer_product_details_discount_widget.dart';

class ViewOfferProductDetailsDiscountScreen extends StatefulWidget {
  final String offerName; // Add this line to accept the nameOffer

  // Modify the constructor to accept nameOffer
  const ViewOfferProductDetailsDiscountScreen(
      {super.key, required this.offerName});

  @override
  State<ViewOfferProductDetailsDiscountScreen> createState() =>
      _ViewOfferProductDetailsDiscountScreenState();
}

class _ViewOfferProductDetailsDiscountScreenState
    extends State<ViewOfferProductDetailsDiscountScreen> {
  late String offerTypeTitle;
  @override
  void initState() {
    super.initState();
    offerTypeTitle = 'المنتجات بعد الخصم';
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
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25.0),
                child: Text(
                  offerTypeTitle!,
                  style: KTextStyle.textStyle14.copyWith(
                    color: AppColors.blackLight,
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 10, // Use the length of the list
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardOfferProductDetailsDiscountWidget(
                            productName: 'MacBook Air',
                            productImage: "assets/image_example.png",
                            lastPrice: '\$ 4,500',
                            newPrice: '\$ 4,400',
                          ),
                          Divider(),
                        ],
                      );
                    },
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
