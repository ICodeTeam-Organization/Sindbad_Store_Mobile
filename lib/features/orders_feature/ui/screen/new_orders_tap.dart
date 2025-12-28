import 'package:flutter/material.dart' hide ErrorWidget;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/core/widgets/waitingCirculerWidget.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';
import 'package:sindbad_management_app/features/orders_feature/domain/entities/entities_states.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order%20cubit/orders_cubit.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/manager/order%20cubit/orders_cubit_states.dart';
import 'package:sindbad_management_app/core/widgets/no_data_widget.dart';
import 'package:sindbad_management_app/core/widgets/error_widget.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/order_card_widget.dart';
import 'package:sindbad_management_app/features/orders_feature/ui/widget/package_status_filterBar.dart';

class NewTabViews extends StatefulWidget {
  const NewTabViews({super.key});

  @override
  State<NewTabViews> createState() => _NewTabViewsState();
}

class _NewTabViewsState extends State<NewTabViews> {
  // Track which items have been animated
  final Set<int> _animatedIndices = {};
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    // Trigger initial fetch with "all" status
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<OrdersCubit>().fetchOrders(PackageStatus.all.id);
    });
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_isNearBottom) {
      context.read<OrdersCubit>().loadMoreOrders();
    }
  }

  bool get _isNearBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.offset;
    // Trigger when within 200 pixels of the bottom
    return currentScroll >= (maxScroll - 200);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Column(
      children: [
        PackageStatusFilterBar<PackageStatus>(
          items: [
            PackageStatus.all,
            PackageStatus.packageConfirmedByYemeniAccountant,
            PackageStatus.packageInvoiceCreated,
            PackageStatus.packageShippedFromStore,
          ],
          labelBuilder: (status) => status.getDisplayName(l10n),
          onChange: (status) {
            _animatedIndices.clear();
            context.read<OrdersCubit>().fetchOrders(status.id);
          },
        ),
        Expanded(
          child: BlocConsumer<OrdersCubit, OrdersState>(
            builder: (context, state) {
              if (state is OrdersLoadInProgress) {
                return Center(
                    child: SizedBox(
                        height: 35,
                        width: 35,
                        child: CircularProgressIndicator()));
              }

              // Handle both OrdersLoadSuccess and OrdersLoadMoreInProgress
              List<OrderEntity>? orders;
              bool isLoadingMore = false;
              bool hasMore = true;

              if (state is OrdersLoadSuccess) {
                orders = state.orders;
                hasMore = state.hasMore;
              } else if (state is OrdersLoadMoreInProgress) {
                orders = state.orders;
                isLoadingMore = true;
              }

              if (orders != null) {
                if (orders.isEmpty) {
                  return NoDataWidget();
                } else {
                  return ListView.builder(
                    controller: _scrollController,
                    itemCount:
                        orders.length + (isLoadingMore || hasMore ? 1 : 0),
                    itemBuilder: (context, index) {
                      // Show loading indicator at the bottom
                      if (index >= orders!.length) {
                        if (isLoadingMore) {
                          return WaitingCirculerWidget();
                        }
                        // Spacer for "load more" trigger zone
                        return SizedBox(height: 120.h);
                      }

                      // Mark this index as needing animation
                      final shouldAnimate = !_animatedIndices.contains(index);
                      if (shouldAnimate) {
                        _animatedIndices.add(index);
                      }

                      return OrderCardWidget(
                        order: orders[index],
                        index: index,
                        animate: shouldAnimate,
                      );
                    },
                  );
                }
              } else if (state is OrdersLoadFailure) {
                return ErrorWidget(message: state.message);
              }
              return Center(child: WaitingCirculerWidget());
            },
            listener: (context, state) {
              // Don't clear animations on load more - only on fresh fetch
              if (state is OrdersLoadInProgress) {
                _animatedIndices.clear();
              }
            },
          ),
        ),
      ],
    );
  }
}
