import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/data/repos/View_offer_repo_impl.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/domain/usecases/get_offer_use_case.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/view_offer_feature/ui/widgets/view_offer_body.dart';

class ViewOfferScreen extends StatelessWidget {
  const ViewOfferScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OfferCubit(GetOfferUseCase(
        getit<ViewOfferRepoImpl>(),
      )),
      child: Scaffold(
        body: ViewOfferBody(),
      ),
    );
  }
}
