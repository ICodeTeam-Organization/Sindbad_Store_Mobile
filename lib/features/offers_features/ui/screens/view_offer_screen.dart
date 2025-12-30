import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/config/routers/routers_names.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/core/dialogs/delete_confirm_dialog.dart';
import 'package:sindbad_management_app/core/widgets/custom_app_bar.dart';
import 'package:sindbad_management_app/core/widgets/store_primary_button.dart';
import 'package:sindbad_management_app/features/offers_features/ui/manager/offer_cubit/offer_cubit.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_message_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/card_offer_widget.dart';
import 'package:sindbad_management_app/features/offers_features/ui/widgets/custom_dialog_widget.dart';

class ViewOfferScreen extends StatefulWidget {
  const ViewOfferScreen({super.key});

  @override
  State<ViewOfferScreen> createState() => _ViewOfferScreenState();
}

class _ViewOfferScreenState extends State<ViewOfferScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_onScroll);
    // Initial fetch with pagination (10 items per page)
    context.read<OfferCubit>().refreshOffers();
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isNearBottom) {
      context.read<OfferCubit>().loadMoreOffers();
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger load when 200 pixels from bottom
    return currentScroll >= (maxScroll - 200);
  }

  VoidCallback _onChangeStatusTap(int offerHeadId, AppLocalizations l10n) {
    return () {
      showDialog(
        context: context,
        builder: (context) => CustomDialogWidget(
          isWarning: false,
          confirmText: l10n.yesChangeStatus,
          title: l10n.confirmChangeOfferStatus,
          subtitle: '',
          iconPath: "assets/change_status.svg",
          onConfirm: () async {
            await context.read<OfferCubit>().changeStatusOffer(offerHeadId);
          },
        ),
      );
    };
  }

  VoidCallback _onUpdateTap(int offerHeadId) {
    return () {
      context.push(AppRoutes.updateOffer, extra: [offerHeadId]);
    };
  }

  VoidCallback _onDeleteTap(int offerHeadId, AppLocalizations l10n) {
    return () {
      showDeleteConfirmDialog(
        context: context,
        title: l10n.confirmDeleteOffer,
        message: l10n.offerWillBeDeleted,
        onConfirm: () async {
          await context.read<OfferCubit>().deleteOffer(offerHeadId);
        },
      );
    };
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: Container(
          color:
              isDark ? Theme.of(context).scaffoldBackgroundColor : Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomAppBar(
                tital: l10n.offers,
                isBack: false,
              ),
              _buildAddOfferButton(context, l10n),
              _buildListSection(context, l10n),
            ],
          ),
        ),
      ),
    );
  }

  BlocConsumer<OfferCubit, OfferState> _buildListSection(
      BuildContext context, AppLocalizations l10n) {
    return BlocConsumer<OfferCubit, OfferState>(
      listener: (context, state) {
        if (state is OffersLoadFailuer) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.errMessage)),
          );
        } else if (state is OfferAddSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l10n.offerAddedSuccess)),
          );
          // Refresh offers list after adding
          context.read<OfferCubit>().refreshOffers();
        }
      },
      buildWhen: (previous, current) =>
          current is! OfferLoadInProgress ||
          context.read<OfferCubit>().offers.isEmpty,
      builder: (context, state) {
        final offerCubit = context.read<OfferCubit>();
        final offers = offerCubit.offers;

        if (state is OfferInitial ||
            (state is OfferLoadInProgress && offers.isEmpty)) {
          return Center(child: CircularProgressIndicator());
        } else if (state is OfferLoadSuccess ||
            (state is OfferLoadInProgress && offers.isNotEmpty)) {
          return offers.isEmpty
              ? Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context.read<OfferCubit>().refreshOffers();
                    },
                    child: ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                      children: [
                        CardMesssageWidget(
                          logo: Image.asset(
                            'assets/image_loading.png',
                            height: 80.h,
                            width: 80.w,
                          ),
                          title: l10n.noOffersYet,
                          subTitle: l10n.encourageCustomers,
                          extra: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SizedBox(height: 20.h),
                              StorePrimaryButton(
                                title: l10n.addOffer,
                                onTap: () {
                                  context.push(
                                    AppRoutes.newOffer,
                                  );
                                },
                                svgIconPath: 'assets/add.svg',
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              : Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      await context.read<OfferCubit>().refreshOffers();
                    },
                    child: ListView.builder(
                      controller: _scrollController,
                      scrollDirection: Axis.vertical,
                      itemCount:
                          offers.length + (offerCubit.isLoadingMore ? 1 : 0),
                      physics: const AlwaysScrollableScrollPhysics(),
                      itemBuilder: (context, i) {
                        // Show loading indicator at the end
                        if (i >= offers.length) {
                          return Padding(
                            padding: EdgeInsets.symmetric(vertical: 16.h),
                            child: Center(
                              child: CircularProgressIndicator(),
                            ),
                          );
                        }

                        final offer = offers[i];
                        final offerHeadId = offer.offerId;
                        return Column(
                          children: [
                            InkWell(
                              onTap: () {
                                context.push(AppRoutes.offerDetails, extra: [
                                  offer.offerId,
                                  offer.offerTitle,
                                  offer.typeName
                                ]);
                              },
                              child: CardOfferWidget(
                                offerId: offer.offerId,
                                offerTitle: offer.offerTitle,
                                typeName: offer.typeName,
                                isActive: offer.isActive,
                                startOffer: offer.startOffer,
                                endOffer: offer.endOffer,
                                countProducts: offer.countProducts,
                                numberToBuy: offer.numberToBuy,
                                numberToGet: offer.numberToGet,
                                discountRate: offer.discountRate,

                                //here update button
                                onUpdateTap: _onUpdateTap(offerHeadId),

                                //here Change Status button
                                onChangeStatusTap:
                                    _onChangeStatusTap(offerHeadId, l10n),

                                //here Delete button
                                onDeleteTap: _onDeleteTap(offerHeadId, l10n),
                              ),
                            ),
                            if (i == offers.length - 1 &&
                                !offerCubit.isLoadingMore)
                              SizedBox(
                                height: 120.h,
                              ),
                          ],
                        );
                      },
                    ),
                  ),
                );
        } else if (state is OffersLoadFailuer) {
          return Center(
            child: CardMesssageWidget(
              logo: Image.asset(
                'assets/image_loading.png',
                height: 80.h,
                width: 80.w,
              ),
              title: l10n.errorTryAgainLater,
              subTitle: state.errMessage,
            ),
          );
        } else {
          return Center(
            child: CardMesssageWidget(
              logo: Image.asset(
                'assets/image_loading.png',
                height: 80.h,
                width: 80.w,
              ),
              title: l10n.infoNotFetched,
              subTitle: '',
            ),
          );
        }
      },
    );
  }

  Padding _buildAddOfferButton(BuildContext context, AppLocalizations l10n) {
    return Padding(
        padding: const EdgeInsets.all(30.0),
        child: StorePrimaryButton(
          svgIconPath: 'assets/add.svg',
          title: l10n.addOffer,
          onTap: () {
            context.push(
              AppRoutes.newOffer,
            );
          },
        ));
  }
}
