import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/models/offer_data_model/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_data_cubit/offer_data_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/update_offer_widget.dart';

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
    context.read<OfferDataCubit>().getOfferData(widget.offerHeadId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferDataCubit, OfferDataState>(
      builder: (context, state) {
        if (state is OfferDataSuccess) {
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
          for (var offerMap in state.offerData.listProduct) {
            debugPrint(jsonEncode(offerMap.toJson()));
          }

          // Pass data to the UpdateOfferWidget
          return UpdateOfferWidget(
            offerHeadId: widget.offerHeadId,
            offerTitle: state.offerData.offerTitle,
            startOffer: state.offerData.startOffer,
            endOffer: state.offerData.endOffer,
            offerType: state.offerData.offerType,
            discountRate: state.offerData.discountRate?.toInt() ?? 0,
            numberToBuy: state.offerData.numberToBuy?.toInt() ?? 0,
            numberToGet: state.offerData.numberToGet?.toInt() ?? 0,
            listProducts: convertToOfferProductsEntity(
              state.offerData.listProduct,
            ),
          );
        } else if (state is OfferDataFailuer) {
          // Handle failure state
          return Center(child: Text(state.errMessage));
        } else if (state is OfferDataLoading) {
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
