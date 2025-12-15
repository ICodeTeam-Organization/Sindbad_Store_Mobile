import 'package:flutter/material.dart';
import 'package:sindbad_management_app/core/swidgets/new_widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/features/profile_feature/ui/widget/update_offer_body.dart';

class UpdateOfferScreen extends StatefulWidget {
  final int offerHeadId;
  const UpdateOfferScreen({super.key, required this.offerHeadId});

  @override
  State<UpdateOfferScreen> createState() => _UpdateOfferScreenState();
}

class _UpdateOfferScreenState extends State<UpdateOfferScreen> {
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
                tital: 'تعديل عرض',
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: SingleChildScrollView(
                      child: UpdateOfferBody(offerHeadId: widget.offerHeadId)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
