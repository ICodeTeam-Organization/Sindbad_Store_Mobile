import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/core/utils/route.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../core/styles/Colors.dart';
import '../../data/repos/view_product_store_repo_impl.dart';
import '../../domain/usecases/get_products_by_filter_use_case.dart';
import '../manager/cubit/cubit/get_store_products_with_filter_cubit.dart';
import 'fake_data _for_test.dart/test_data_cat.dart';
import '../widgets/products_listview_widget.dart';
import '../widgets/sub_category_card_custom.dart';
import '../widgets/two_button_in_row_costum.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  ViewProductState createState() => ViewProductState();
}

class ViewProductState extends State<ViewProduct> {
  int _selectedSubIndex = 0;
  final bool _showSubCategories = true; // للتحكم في ظهور الفئات الفرعية

  @override
  Widget build(BuildContext context) {
    final double heightMobile = MediaQuery.sizeOf(context).height;

    return BlocProvider(
      create: (context) =>
          GetStoreProductsWithFilterCubit(GetProductsByFilterUseCase(
        getit.get<ViewProductStoreRepoImpl>(),
      )),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: [
              CustomAppBar(
                tital: "المنتجات",
                isBack: false,
              ),
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
        ),
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
            TwoButtonInRow(
                // productCheckedByNames: allProductCheckedByNames,
                onTapLeft: () {}),
            SizedBox(height: 15.h),
            Expanded(
              child: ProductsListView(
                storeProductsFilter: tabIndex,
                onTapDelete: () {
                  // تنفيذ الحذف
                },
                onTapEdit: () {
                  // تنفيذ التعديل
                  context.push(AppRouter.storeRouters.kStoreEditProduct,
                      extra: 1 // here pass the product id
                      );
                },
              ),
            ),
          ],
        );
      case 1: // "جميع المنتجات"
        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
            if (_showSubCategories) _buildSubCategories(),
            TwoButtonInRow(
                // productCheckedByNames: offerProductCheckedByNames,
                onTapLeft: () {}),
            SizedBox(height: 15.h),
            Expanded(
              child: ProductsListView(
                storeProductsFilter: tabIndex,
                onTapDelete: () {
                  // تنفيذ الحذف
                },
                onTapEdit: () {
                  // تنفيذ التعديل
                  context.push(AppRouter.storeRouters.kStoreEditProduct,
                      extra: 1 // here pass the product id
                      );
                },
              ),
            ),
          ],
        );
      case 2: // "منتجات موقوفة"
        return Column(
          children: [
            TwoButtonInRow(
                // productCheckedByNames: disableProductCheckedByNames,
                titleLeft: "إعادة تنشيط",
                onTapLeft: () {}),
            Expanded(
              child: ProductsListView(
                storeProductsFilter: tabIndex,
                onTapDelete: () {
                  // تنفيذ الحذف
                },
                onTapEdit: () {
                  // تنفيذ التعديل
                  context.push(AppRouter.storeRouters.kStoreEditProduct,
                      extra: 1 // here pass the product id
                      );
                },
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
        children: FakeDataApi().subCategories.asMap().entries.map((entry) {
          // for get index to selected
          int index = entry.key;
          String category = entry.value;
          return ChipCustom(
            title: category,
            isSelected: _selectedSubIndex == index, // استخدام الفهرس من التكرار
            onTap: () {
              setState(() {
                _selectedSubIndex = index;
              });
              // تحديث التفاعل عند الضغط على الفئات
              debugPrint("Selected Category: $category");
            },
          );
        }).toList(),
      ),
    );
  }
}
