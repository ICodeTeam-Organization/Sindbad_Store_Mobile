import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import 'package:sindbad_management_app/features/offer_features/view_offer_feature/ui/widgets/action_button_widget.dart';
import 'package:sindbad_management_app/features/offer_features/view_offer_feature/ui/widgets/card_offer_widget.dart';

class ViewOfferScreen extends StatefulWidget {
  const ViewOfferScreen({super.key});

  @override
  State<ViewOfferScreen> createState() => _ViewOfferScreenState();
}

class _ViewOfferScreenState extends State<ViewOfferScreen> {
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
              ),
              Padding(
                padding: const EdgeInsets.all(30.0),
                child: ActionButtonWidget(
                  title: 'إضافة عرض',
                  iconPath: "assets/add.svg",
                  onTap: (){

                  },
                )
              ),
              Expanded(
                child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  itemCount: 5, // Use the length of the list
                  physics: const AlwaysScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        InkWell(
                          onTap: () {
                            context.push(AppRouter.storeRouters.kOfferProductDetails,
                            extra: ['يوم الجمعة','Discount',]
                            // extra: [offerName,offerType,]
                          );  // Use GoRouter to navigate to the parameterized route
                          },
                          child: CardOfferWidget(
                            offerName: 'يوم الجمعة',
                            discountRate: '10%',
                            offerBouns: 'اشتري x واحصل على y',
                            startOffer: DateTime.utc(2024, 5, 1), 
                            endOffer: DateTime.utc(2024, 11, 25), 
                            isActive: true,
                            countProducts: '17', 
                            offerType: 'Discount', 
                          ),
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
    );
  }
}