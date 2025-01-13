import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/view_offer_body.dart';

class ViewOfferScreen extends StatelessWidget {
  const ViewOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<OfferCubit>().getOffer(10, 1);
    return Scaffold(
      body: ViewOfferBody(),
    );
  }
}
