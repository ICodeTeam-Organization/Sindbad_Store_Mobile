import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shimmer/shimmer.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../../core/styles/Colors.dart';
import '../../../../../core/styles/text_style.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import '../manager/get_store_products_with_filter/get_store_products_with_filter_cubit.dart';
import 'fake_data _for_test.dart/test_data_cat.dart';
import '../widgets/products_listview_widget.dart';
import '../widgets/sub_category_card_custom.dart';
import '../widgets/two_button_in_row_costum.dart';

class ListMainCategoryForTabView extends StatefulWidget {
  const ListMainCategoryForTabView({super.key});

  @override
  ListMainCategoryForTabViewState createState() =>
      ListMainCategoryForTabViewState();
}

class ListMainCategoryForTabViewState
    extends State<ListMainCategoryForTabView> {
  int _selectedSubIndex = 0;
  final bool _showSubCategories = true; // للتحكم في ظهور الفئات الفرعية

  @override
  Widget build(BuildContext context) {
    final double heightMobile = MediaQuery.sizeOf(context).height;

    return Scaffold(
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
    );
  }

  // بناء محتوى التبويب بناءً على التحديد
  Widget _buildTabView(int tabIndex) {
    switch (tabIndex) {
      case 0: // "جميع المنتجات"

        return Column(
          children: [
            SizedBox(height: 7),
            // في حال كانت التصنيفات الفرعية يجب عرضها
            ListMainCategoryForView(selectedSubIndex: 0),
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return TwoButtonInRow(
                  anyProductsSelected: context
                      .read<GetStoreProductsWithFilterCubit>()
                      .updatedProductsSelected
                      .isEmpty,
                  onTapLeft: () {},
                );
              },
            ),

            SizedBox(height: 15.h),
            Expanded(
              child: ProductsListView(
                storeProductsFilter: tabIndex,
              ),
            ),
          ],
        );
      case 1: // "منتجات عليها عروض"
        return Column(
          children: [
            // في حال كانت التصنيفات الفرعية يجب عرضها
            ListMainCategoryForView(selectedSubIndex: 1),
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return TwoButtonInRow(
                  anyProductsSelected: context
                      .read<GetStoreProductsWithFilterCubit>()
                      .updatedProductsSelected
                      .isEmpty,
                  onTapLeft: () {},
                );
              },
            ),

            SizedBox(height: 15.h),
            Expanded(
              child: ProductsListView(
                storeProductsFilter: tabIndex,
              ),
            ),
          ],
        );
      case 2: // "منتجات موقوفة"
        return Column(
          children: [
            BlocBuilder<GetStoreProductsWithFilterCubit,
                GetStoreProductsWithFilterState>(
              builder: (context, state) {
                return TwoButtonInRow(
                  titleLeft: "إعادة تنشيط",
                  anyProductsSelected: context
                      .read<GetStoreProductsWithFilterCubit>()
                      .updatedProductsSelected
                      .isEmpty,
                  onTapLeft: () {},
                );
              },
            ),
            Expanded(
              child: ProductsListView(
                storeProductsFilter: tabIndex,
              ),
            ),
          ],
        );
      default:
        return Container();
    }
  }
}

//  =====  بناء قائمة التصنيفات الفرعية (Sub Categories)  ========
class ListMainCategoryForView extends StatefulWidget {
  final int selectedSubIndex;
  const ListMainCategoryForView({super.key, required this.selectedSubIndex});

  @override
  State<ListMainCategoryForView> createState() =>
      _ListMainCategoryForViewState();
}

class _ListMainCategoryForViewState extends State<ListMainCategoryForView> {
  @override
  void initState() {
    super.initState();
    context.read<GetMainCategoryForViewCubit>().getMainCategoryForView(
        pageNumper: 1, pageSize: 10); // for get Main category
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetMainCategoryForViewCubit,
        GetMainCategoryForViewState>(
      builder: (context, state) {
        if (state is GetMainCategoryForViewSuccess) {
          final mainCategoryForViewEntity = state.mainCategoryForViewEntity;
          return SizedBox(
            height: 50.h,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: mainCategoryForViewEntity.length +
                    1, // Use the length of the list
                physics: const AlwaysScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  final category = mainCategoryForViewEntity[i];
                  return i == 0
                      ? InkWell(
                          onTap: () {
                            // setState(() {
                            //   _selectedSubIndex = i;
                            // });
                            debugPrint(
                                "Selected Category: ${category.mainCategoryName}");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 12.h),
                            margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.primary,
                                // _selectedSubIndex == i
                                // ? AppColors.primary
                                // : AppColors.greyBorder,
                              ),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Center(
                              child: Text(
                                "الكل",
                                style: KTextStyle.textStyle14,
                              ),
                            ),
                          ),
                        )
                      : InkWell(
                          onTap: () {
                            // setState(() {
                            //   _selectedSubIndex = i;
                            // });
                            debugPrint(
                                "Selected Category: ${state.mainCategoryForViewEntity[i - 1].mainCategoryName}");
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 14.w, vertical: 12.h),
                            margin: EdgeInsets.symmetric(horizontal: 2.5.w),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: AppColors.greyBorder,
                                //  _selectedSubIndex == i
                                //     ? AppColors.primary
                                //     : AppColors.greyBorder,
                              ),
                              borderRadius: BorderRadius.circular(50.r),
                            ),
                            child: Center(
                              child: Text(
                                state.mainCategoryForViewEntity[i - 1]
                                    .mainCategoryName,
                                style: KTextStyle.textStyle14,
                              ),
                            ),
                          ),
                        );
                }),
          );
        } else if (state is GetMainCategoryForViewFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is GetMainCategoryForViewLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Center(
            child: Container(
              color: Colors.red.shade400,
              height: 50,
              width: 300,
              child: const Text('لم يتم الوصول الى المعلومات'),
            ),
          );
        }
      },
    );
  }
}

// Row(
//             children: FakeDataApi().subCategories.asMap().entries.map((entry) {
//               // for get index to selected
//               int index = entry.key;
//               String category = entry.value;
//               return ChipCustom(
//                 title: category,
//                 isSelected:
//                     selectedSubIndex == index, // استخدام الفهرس من التكرار
//                 onTap: () {
//                   // setState(() {
//                   //   _selectedSubIndex = index;
//                   // });
//                   // تحديث التفاعل عند الضغط على الفئات
//                   debugPrint("Selected Category: $category");
//                 },
//               );
//             }).toList(),
//           )

class ShimmerForMainCategoryForView extends StatelessWidget {
  const ShimmerForMainCategoryForView({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.zero,
        itemCount: 6, // عدد العناصر التي سيتم عرضها
        itemBuilder: (context, index) {
          return Container(
            margin: const EdgeInsets.symmetric(
                horizontal: 8.0), // مسافة بين العناصر
            width: 50.0, // العرض لكل عنصر
            height: 30.0, // الارتفاع لكل عنصر
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius:
                  BorderRadius.circular(8.0), // زوايا دائرية لتحسين التصميم
            ),
          );
        },
      ),
    );
  }
}
