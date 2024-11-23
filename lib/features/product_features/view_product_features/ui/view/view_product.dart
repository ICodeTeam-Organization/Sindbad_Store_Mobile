import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/shared_widgets/new_widgets/store_primary_button.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../core/styles/Colors.dart';
import 'fake_data _for_test.dart/test_data_cat.dart';
import 'widgets/products_listview_widget.dart';
import 'widgets/sub_category_card_custom.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  ViewProductState createState() => ViewProductState();
}

class ViewProductState extends State<ViewProduct> {
  int _selectedSubIndex = 0;
  final bool _showSubCategories = true; // للتحكم في ظهور الفئات الفرعية

  List<bool> allProductCheckedStates = [];
  List<String> allProductCheckedByNames = [];
  List<bool> offerProductCheckedStates = [];
  List<String> offerProductCheckedByNames = [];
  List<bool> disableProductCheckedStates = [];
  List<String> disableProductCheckedByNames = [];

  // bool disabledButtonAdd = false;
  void _onChangeCheckBox(
      {required String listName,
      required List<bool> nameListCheckedStates,
      required List<String> nameListCheckedByNames,
      required bool val,
      required int index,
      required String idProductChange}) {
    setState(() {
      nameListCheckedStates[index] = val;
      val
          ? nameListCheckedByNames.add(idProductChange)
          : nameListCheckedByNames.remove(idProductChange);
      debugPrint("$listName : ${nameListCheckedByNames.toString()}");
    });
  }

  @override
  void initState() {
    super.initState();
    allProductCheckedStates = List<bool>.filled(
        FakeDataApi.allProductsData.length, false); // تهيئة القائمة هنا
    offerProductCheckedStates = List<bool>.filled(
        FakeDataApi.offerProductsData.length, false); // تهيئة القائمة هنا
    disableProductCheckedStates = List<bool>.filled(
        FakeDataApi.disableProductsData.length, false); // تهيئة القائمة هنا
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
            indicatorWeight: 0.0.w,
            labelColor: AppColors.black,
            unselectedLabelColor: AppColors.black,
            height: heightMobile * 0.85, // height TabBar and all dowm him
          ),
        ],
      ),
    );
  }

  // بناء محتوى التبويب بناءً على التحديد
  Widget _buildTabView(int tabIndex) {
    switch (tabIndex) {
      case 0: // "منتجات عليها عروض"
        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
            if (_showSubCategories) _buildSubCategories(),
            Padding(
              padding: EdgeInsets.only(
                  top: 30.h, left: 15.w, right: 15.w, bottom: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StorePrimaryButton(
                    disabled:
                        allProductCheckedByNames.isNotEmpty ? true : false,
                    title: "إضافة منتج",
                    icon: Icons.add_circle_outline_rounded,
                    buttonColor: AppColors.primary,
                    height: 55.h,
                    width: 150.w,
                  ),
                  StorePrimaryButton(
                    title: "إيقاف منتج",
                    icon: Icons.delete_outline_rounded,
                    buttonColor: AppColors.primary,
                    height: 55.h,
                    width: 150.w,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ProductsListView(
                products: FakeDataApi.allProductsData,
                checkedStates: allProductCheckedStates, // تمرير الحالات
                onChanged: (val, index) => _onChangeCheckBox(
                    listName: "All Products",
                    nameListCheckedStates: allProductCheckedStates,
                    nameListCheckedByNames: allProductCheckedByNames,
                    val: val!,
                    index: index,
                    idProductChange: FakeDataApi.allProductsData[index]['id']
                        .toString()), // تمرير index
              ),
            ),
          ],
        );
      case 1: // "جميع المنتجات"
        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
            if (_showSubCategories) _buildSubCategories(),
            Padding(
              padding: EdgeInsets.only(
                  top: 30.h, left: 15.w, right: 15.w, bottom: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StorePrimaryButton(
                    disabled:
                        offerProductCheckedByNames.isNotEmpty ? true : false,
                    title: "إضافة منتج",
                    icon: Icons.add_circle_outline_rounded,
                    buttonColor: AppColors.primary,
                    height: 55.h,
                    width: 150.w,
                  ),
                  StorePrimaryButton(
                    title: "إيقاف منتج",
                    icon: Icons.delete_outline_rounded,
                    buttonColor: AppColors.primary,
                    height: 55.h,
                    width: 150.w,
                  )
                ],
              ),
            ),
            SizedBox(height: 15),
            Expanded(
              child: ProductsListView(
                products: FakeDataApi.offerProductsData,
                checkedStates: offerProductCheckedStates, // تمرير الحالات
                onChanged: (val, index) => _onChangeCheckBox(
                    listName: "Offer Products",
                    nameListCheckedStates: offerProductCheckedStates,
                    nameListCheckedByNames: offerProductCheckedByNames,
                    val: val!,
                    index: index,
                    idProductChange: FakeDataApi.offerProductsData[index]['id']
                        .toString()), // تمرير index
              ),
            ),
          ],
        );
      case 2: // "منتجات موقوفة"
        return Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: 30.h, left: 15.w, right: 15.w, bottom: 15.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StorePrimaryButton(
                    disabled:
                        disableProductCheckedByNames.isNotEmpty ? true : false,
                    title: "إضافة منتج",
                    icon: Icons.add_circle_outline_rounded,
                    buttonColor: AppColors.primary,
                    height: 55.h,
                    width: 150.w,
                  ),
                  StorePrimaryButton(
                    title: "إعادة تنشيط",
                    icon: Icons.delete_outline_rounded,
                    buttonColor: AppColors.primary,
                    height: 55.h,
                    width: 150.w,
                  )
                ],
              ),
            ),
            Expanded(
              child: ProductsListView(
                products: FakeDataApi.disableProductsData,
                checkedStates: disableProductCheckedStates, // تمرير الحالات
                onChanged: (val, index) => _onChangeCheckBox(
                    listName: "Disable Products",
                    nameListCheckedStates: disableProductCheckedStates,
                    nameListCheckedByNames: disableProductCheckedByNames,
                    val: val!,
                    index: index,
                    idProductChange: FakeDataApi.disableProductsData[index]
                            ['id']
                        .toString()), // تمرير index
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }

  // بناء قائمة التصنيفات الفرعية (Sub Categories)
  Widget _buildSubCategories() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: FakeDataApi().subCategories.map((category) {
          int index = FakeDataApi().subCategories.indexOf(category);
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
