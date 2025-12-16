import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/offers_features/data/models/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offers_features/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';

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
    // context.read<OfferCubit>().getOfferProducts(widget.offerHeadId);
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

          return SizedBox();
          // Debugging: Print the data of each product
          // for (var offerMap in state.offerProducts) {
          //   debugPrint(jsonEncode(offerMap.toJson()));
          // }

          // Pass data to the UpdateOfferWidget
          // return UpdateOfferWidget(
          //   offerHeadId: widget.offerHeadId,
          //   offerTitle: state.offerProducts.offerTitle,
          //   startOffer: state.offerProducts.startOffer,
          //   endOffer: state.offerProducts.endOffer,
          //   offerType: state.offerProducts.offerType,
          //   discountRate: state.offerProducts.discountRate?.toInt() ?? 0,
          //   numberToBuy: state.offerProducts.numberToBuy?.toInt() ?? 0,
          //   numberToGet: state.offerProducts.numberToGet?.toInt() ?? 0,
          //   listProducts: convertToOfferProductsEntity(
          //     state.offerProducts,
          //   ),
          // );
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
