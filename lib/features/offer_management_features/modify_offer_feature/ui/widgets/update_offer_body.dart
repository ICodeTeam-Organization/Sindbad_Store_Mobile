import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/data/models/offer_data_model/offer_head_offer.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_data_cubit/offer_data_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/new_offer_widget.dart';
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
    // TODO: implement initState
    super.initState();
    context.read<OfferDataCubit>().getOfferData(widget.offerHeadId);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OfferDataCubit, OfferDataState>(
      builder: (context, state) {
        if (state is OfferDataSuccess) {
          ////
          List<OfferProductsEntity> convertToOfferProductsEntity(
              List<OfferHeadOffer> offerHeadList) {
            return offerHeadList.map((offerHead) {
              return OfferProductsEntity(
                productId:
                    offerHead.productId ?? 0, // Provide default values if null
                productTitle: offerHead.name ?? 'No Title',
                productImage: offerHead.mainImageUrl ?? '',
                discountRate: offerHead.percentage
                    ?.toDouble(), // Convert to `num` if needed
                oldPrice: offerHead.priceBeforeDiscount ?? 0,
                newPrice: offerHead.finalPrice ?? 0,
                numberToBuy: offerHead.amountToBuy ?? 0,
                numberToGet: offerHead.amountToGet ?? 0,
              );
            }).toList();
          }

          ///
          String work = ' @@@';
          for (var offerMap in state.offerData.listProduct) {
            print(jsonEncode(offerMap.toJson()) + work);
          }
          return UpdateOfferWidget(
            offerTitle: state.offerData.offerTitle,
            startOffer: state.offerData.startOffer,
            endOffer: state.offerData.endOffer,
            offerType: state.offerData.offerType,
            discountRate: state.offerData.discountRate!.toInt(),
            numberToBuy: state.offerData.numberToBuy!.toInt(),
            numberToGet: state.offerData.numberToGet!.toInt(),
            listProducts:
                convertToOfferProductsEntity(state.offerData.listProduct),
          );
        } else if (state is OfferDataFailuer) {
          return Center(child: Text(state.errMessage));
        } else if (state is OfferDataLoading) {
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
    );
  }
}
