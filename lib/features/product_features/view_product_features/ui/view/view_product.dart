import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/functions/image_picker_function.dart';

import '../../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../core/styles/Colors.dart';
import 'widgets/products_listview_widget.dart';
import 'widgets/sub_category_card_custom.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  _ViewProductState createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  int _selectedSubIndex = 0;
  int _selectedTabIndex = 0; // لتخزين التبويب المحدد
  bool _showSubCategories = true; // للتحكم في ظهور الفئات الفرعية

  final List<Map<String, dynamic>> products = List.generate(
    30,
    (index) => {
      'name': 'Mbile $index',
      'id': '$index',
      'price': '1500',
      'imageUrl': 'https://via.placeholder.com/100',
    },
  );

  void _onTabSelected(int index) {
    setState(() {
      _selectedTabIndex = index;
      _showSubCategories =
          index != 2; // عند اختيار "منتجات موقوفة" لا نعرض التصنيفات الفرعية
    });
  }

  @override
  Widget build(BuildContext context) {
    final double heightMobile = MediaQuery.sizeOf(context).height;
    return Scaffold(
      appBar: AppBar(title: Text("منتجات")),
      body: Column(
        children: [
          SizedBox(height: 10.h),
          CustomTabBarWidget(
            tabs: [
              Tab(text: "جميع المنتجات"),
              Tab(text: "منتجات عليها عروض"),
              Tab(text: "منتجات موقوفة"),
            ],
            tabViews: [
              _buildTabView(0),
              _buildTabView(1),
              _buildTabView(2),
            ],
            length: 3,
            indicatorColor: AppColors.primary,
            indicatorWeight: 3.0.w,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.black,
            height: heightMobile,
          ),
        ],
      ),
    );
  }

  // بناء محتوى التبويب بناءً على التحديد
  Widget _buildTabView(int tabIndex) {
    switch (tabIndex) {
      case 0: // "منتجات عليها عروض"
      case 1: // "جميع المنتجات"
        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
            if (_showSubCategories) _buildSubCategories(),
            SizedBox(height: 15),
            Expanded(child: ProductsListView(products: products)),
          ],
        );
      case 2: // "منتجات موقوفة"
        return Expanded(child: ProductsListView(products: products));
      default:
        return Container();
    }
  }

  // بناء قائمة التصنيفات الفرعية (Sub Categories)
  Widget _buildSubCategories() {
    final List<String> subCategsAll = ["الكل"];
    final List<String> subCat = [
      "الكترونيات",
      "لابتوبات",
      "شنط نسائية",
      "باريس",
      "الكترونيات",
      "لابتوبات",
      "شنط",
      "باريس",
      "الكترونيات",
      "لابتوبات",
      "شنط نسائية",
      "باريس",
      "الكترونيات",
      "لابتوبات",
      "شنط",
      "باريس"
    ];
    // Getter
    List<String> subCategories = [...subCategsAll, ...subCat];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: subCategories.map((category) {
          int index = subCategories.indexOf(category);
          return ChipCustom(
            title: category,
            isSelected:
                _selectedSubIndex == index, // لن نعرض حالة التحديد هنا الآن
            onTap: () {
              setState(() {
                _selectedSubIndex = index;
              });
              // تحديث التفاعل عند الضغط على الفئات
              print("Selected Category: $category");
            },
          );
        }).toList(),
      ),
    );
  }
}
