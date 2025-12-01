import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/sub_category_card_custom.dart';

class GenericFilterBar<T> extends StatefulWidget {
  final Future<List<T>> Function(int page, int size) dataFetcher;
  final String Function(T item) getName;
  final int Function(T item) getId;
  final String Function(T item)? getImage;
  final Function(int?)? onChanged;
  final int selectedId;
  final int pageSize;

  const GenericFilterBar({
    super.key,
    required this.dataFetcher,
    required this.getName,
    required this.getId,
    this.getImage,
    this.onChanged,
    required this.selectedId,
    this.pageSize = 10,
  });

  @override
  State<GenericFilterBar<T>> createState() => _GenericFilterBarState<T>();
}

class _GenericFilterBarState<T> extends State<GenericFilterBar<T>> {
  List<T> items = [];
  int currentPage = 1;
  bool isLoading = false;
  bool isLastPage = false;

  @override
  void initState() {
    super.initState();
    loadPage();
  }

  Future<void> loadPage() async {
    if (isLoading || isLastPage) return;

    setState(() => isLoading = true);

    final result = await widget.dataFetcher(currentPage, widget.pageSize);

    if (result.isEmpty) {
      isLastPage = true;
    } else {
      items.addAll(result);
      currentPage++;
    }

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (scroll) {
        if (scroll.metrics.pixels == scroll.metrics.maxScrollExtent) {
          loadPage();
        }
        return false;
      },
      child: SizedBox(
        height: 50.h,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: items.length,
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          itemBuilder: (context, i) {
            final item = items[i];
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
        ),
      ),
    );
  }
}
