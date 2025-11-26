import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/widgets/sub_category_card_custom.dart';

class PackageStatusFilterBar<T> extends StatefulWidget {
  final List<T> items; // Dynamic items (String, int, or model)
  final Function(T value) onChange; // Callback when an item is selected
  final String Function(T item)? labelBuilder; // Optional label extractor
  final int initialIndex;

  const PackageStatusFilterBar({
    super.key,
    required this.items,
    required this.onChange,
    this.labelBuilder,
    this.initialIndex = 0,
  });

  @override
  State<PackageStatusFilterBar<T>> createState() =>
      _PackageStatusFilterBarState<T>();
}

class _PackageStatusFilterBarState<T> extends State<PackageStatusFilterBar<T>> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.items.length,
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        itemBuilder: (context, i) {
          final item = widget.items[i];

          // If the item is an object, allow a custom label builder
          final label = widget.labelBuilder != null
              ? widget.labelBuilder!(item)
              : item.toString();

          return ChipCustom(
            title: label,
            isSelected: i == _selectedIndex,
            onTap: () {
              setState(() => _selectedIndex = i);
              widget.onChange(item);
            },
          );
        },
      ),
    );
  }
}
