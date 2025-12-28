import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/update_offer_widget.dart';

class UpdateOfferBody extends StatefulWidget {
  final int offerHeadId;

  const UpdateOfferBody({super.key, required this.offerHeadId});

  @override
  State<UpdateOfferBody> createState() => _UpdateOfferBodyState();
}

class _UpdateOfferBodyState extends State<UpdateOfferBody> {
  @override
  void initState() {
    super.initState();
    //  context.read<OfferCubit>().getOfferDetails(widget.offerHeadId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferCubit, OfferState>(
      builder: (context, state) {
        if (state is OfferLoadSuccess) {
          // Convert OfferHeadOffer list to OfferProductsEntity list
          List<OfferProductsEntity> convertToOfferProductsEntity(
              List<OfferHeadOffer> offerHeadList) {
            return offerHeadList.map((offerHead) {
              return OfferProductsEntity(
                productOfferId: offerHead.id ?? 0,
                productId: offerHead.id ?? 0,
                productTitle: offerHead.name ?? 'Unnamed Product',
                productImage: offerHead.mainImageUrl ?? '',
                discountRate: offerHead.percentage?.toDouble() ?? 0.0,
                oldPrice: offerHead.priceBeforeDiscount ?? 0,
                newPrice: offerHead.finalPrice ?? 0,
                numberToBuy: offerHead.amountToBuy ?? 0,
                numberToGet: offerHead.amountToGet ?? 0,
              );
            }).toList();
          }

          // Debugging: Print the data of each product
          // for (var offerMap in state.offerData.listProduct) {
          //   debugPrint(jsonEncode(offerMap.toJson()));
          // }

          // Pass data to the UpdateOfferWidget
          return UpdateOfferWidget(
            offerHeadId: widget.offerHeadId,
            offerTitle: "state.offerData.offerTitle",
            startOffer: DateTime.now(),
            endOffer: DateTime.now(),
            offerType: 0,
            discountRate: 0,
            numberToBuy: 0,
            numberToGet: 0,
            listProducts: convertToOfferProductsEntity(
              [],
            ),
          );
        } else if (state is OffersLoadFailuer) {
          // Handle failure state
          return Center(child: Text(state.errMessage));
        } else if (state is OfferLoadInProgress) {
          // Show loading indicator while data is being fetched
          return const Center(child: CircularProgressIndicator());
        } else {
          // Default fallback for unknown states
          return Center(
            child: Container(
              height: 50,
              width: 300,
              alignment: Alignment.center,
              child: const Text('Failed to load offer data.'),
            ),
          );
        }
      },
    );
  }
}
