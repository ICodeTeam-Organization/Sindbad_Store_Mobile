import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/main_category_for_view_entity.dart';
import 'sub_category_card_custom.dart';

class CustomGetMainCategoryForViewSuccessWidget extends StatefulWidget {
  const CustomGetMainCategoryForViewSuccessWidget({
    super.key,
    required this.allCategory,
  });

  final List<MainCategoryForViewEntity> allCategory;

  @override
  State<CustomGetMainCategoryForViewSuccessWidget> createState() =>
      _CustomGetMainCategoryForViewSuccessWidgetState();
}

class _CustomGetMainCategoryForViewSuccessWidgetState
    extends State<CustomGetMainCategoryForViewSuccessWidget> {
  int _selectedSubIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: widget.allCategory.length, // Use the length of the list
          physics: const AlwaysScrollableScrollPhysics(),
          itemBuilder: (context, i) {
            final category = widget.allCategory[i];
            return ChipCustom(
              title: category.mainCategoryName,
              isSelected: i == _selectedSubIndex,
              onTap: () {
                //
                // here put fun request api by id Category
                //
                debugPrint("Selected Category: ${category.mainCategoryName}");
                _selectedSubIndex = i;
                setState(() {});
              },
            );
          }),
    );
  }
}
