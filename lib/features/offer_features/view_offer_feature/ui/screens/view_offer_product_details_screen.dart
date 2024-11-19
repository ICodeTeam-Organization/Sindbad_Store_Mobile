import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_features/view_offer_feature/ui/widgets/card_offer_product_details_widget.dart';

class ViewOfferProductDetailsScreen extends StatefulWidget {
  final String offerName;  // Add this line to accept the nameOffer
  final String offerType;  // Add this line to accept the nameOffer
  
  // Modify the constructor to accept nameOffer
  const ViewOfferProductDetailsScreen({super.key, required this.offerName, required this.offerType});

  @override
  State<ViewOfferProductDetailsScreen> createState() => _ViewOfferProductDetailsScreenState();
}

class _ViewOfferProductDetailsScreenState extends State<ViewOfferProductDetailsScreen> {
  String? offerTypeTitle;
  @override
  void initState() {
    super.initState();
    if (widget.offerType=='discount') {
      offerTypeTitle = 'المنتجات بعد الخصم';
    }else if(widget.offerType=='Bouns'){
      offerTypeTitle = 'المنتجات بعد عمل البونص';
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: AppColors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomAppBar(
                  tital: widget.offerName,
                ),
                SizedBox(height: 30.h,),
                //'المنتجات بعد الخصم'
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(offerTypeTitle!,style: KTextStyle.textStyle14.copyWith(color: AppColors.blackLight,),),
                ),
                SizedBox(height: 10.h,),
                Expanded(
                  child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: 5, // Use the length of the list
                    physics: const AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          CardOfferProductDetailsWidget(
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
