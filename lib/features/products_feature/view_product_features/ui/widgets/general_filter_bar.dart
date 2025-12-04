import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/sub_category_card_custom.dart';

class GenericFilterBar<T> extends StatefulWidget {
  final List<T> items;
  final String Function(T item) getName;
  final int Function(T item) getId;
  final String Function(T item)? getImage;
  final Function(int?)? onChanged;
  final Function()? onLoadMore;
  final int selectedId;
  final bool isLoading;
  final int shimmerItemCount;

  const GenericFilterBar({
    super.key,
    required this.items,
    required this.getName,
    required this.getId,
    this.getImage,
    this.onChanged,
    this.onLoadMore,
    required this.selectedId,
    this.isLoading = false,
    this.shimmerItemCount = 10,
  });

  @override
  State<GenericFilterBar<T>> createState() => _GenericFilterBarState<T>();
}

class _GenericFilterBarState<T> extends State<GenericFilterBar<T>> {
  ScrollController? _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController?.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController?.removeListener(_onScroll);
    _scrollController?.dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController == null) return;

    final maxScroll = _scrollController!.position.maxScrollExtent;
    final currentScroll = _scrollController!.position.pixels;

    // Trigger load more when we're at 80% of the current content
    if (currentScroll > 0 &&
        currentScroll >= (maxScroll * 0.8) &&
        !widget.isLoading) {
      widget.onLoadMore?.call();
    }
  }

  // Shimmer widget for loading state
  Widget _buildShimmerChip(int index) {
    final randomWidth =
        60.w + (index * 15).w; // Variable widths for natural look

    return Container(
      margin: EdgeInsets.symmetric(horizontal: 8.w, vertical: 6.h),
      child: Shimmer.fromColors(
        baseColor: Colors.grey[300]!,
        highlightColor: Colors.grey[100]!,
        period: const Duration(milliseconds: 1500),
        child: Container(
          width: randomWidth,
          height: 32.h,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20.r),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: Row(
        children: [
          Expanded(
            child: CustomScrollView(
              controller: _scrollController,
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(
                parent: AlwaysScrollableScrollPhysics(),
              ),
              slivers: [
                // Main items list
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final item = widget.items[index];
                      final label = widget.getName(item);
                      final id = widget.getId(item);
                      final isSelected = id == widget.selectedId;

                      return ChipCustom(
                        title: label,
                        isSelected: isSelected,
                        onTap: () {
                          widget.onChanged?.call(id);
                        },
                      );
                    },
                    childCount: widget.items.length,
                  ),
                ),

                // Shimmer items when loading
                if (widget.isLoading)
                  SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return _buildShimmerChip(index);
                      },
                      childCount: widget.shimmerItemCount,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
