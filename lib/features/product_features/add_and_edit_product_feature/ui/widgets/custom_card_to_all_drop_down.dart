import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/section_title_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/domain/entities/add_product_entities/main_category_entity.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_failure_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_initial_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_loading_widget.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/widgets/get_category_names_success_widget.dart';
import '../manger/cubit/add_product_to_store/add_product_to_store_cubit.dart';
import '../manger/cubit/main_and_sub_drop_down/cubit/get_main_and_sub_category_names_cubit.dart';

class CustomCardToAllDropDown extends StatefulWidget {
  final AddProductToStoreCubit cubitAddProduct;
  final GetCategoryNamesCubit cubitCategories;
   CustomCardToAllDropDown({
    super.key,
    required this.cubitAddProduct,
    required this.cubitCategories,
  });

  @override
  State<CustomCardToAllDropDown> createState() => _CustomCardToAllDropDownState();
}

class _CustomCardToAllDropDownState extends State<CustomCardToAllDropDown> {
  late final ScrollController scrollerController ;
  List<CategoryEntity> mainCategories = [];
  bool isLodingMore=true;

  int pageNumber=1;

  @override
  void initState() {
    super.initState();
    // FIX: Initialize scroll controller FIRST
    scrollerController = ScrollController();
    

    scrollerController.addListener(_scrollListener);
    print('[DEBUG] listener ADDED to controller: ${scrollerController.hashCode}');

    // context
    //     .read<GetCategoryNamesCubit>()
    //     .getMainAndSubCategory(filterType: 2, pageNumber: 1, pageSize: 10);
   
          
        
  }

    @override
  void dispose() {
    scrollerController.removeListener(_scrollListener);
    scrollerController.dispose();
    super.dispose();
  }

  void _scrollListener(){
    
    // if (!scrollController.hasClients) return;
    // final pos = scrollController.position;
    //  print('=== SCROLL DEBUG INFO ===');
    // if(isLodingMore){
    if(!isLodingMore)
{
  return;
}      if(scrollerController.position.pixels==scrollerController.position.maxScrollExtent){
        context.read<GetCategoryNamesCubit>().getMainAndSubCategory(filterType: 2, pageNumber: ++pageNumber, pageSize: 10);
      // }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      decoration: BoxDecoration(
          color: AppColors.white,
          border: Border.all(color: AppColors.greyBorder),
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // container Title
            SectionTitleWidget(title: 'نوع المنتج'),
            SizedBox(height: 20.h),

            BlocConsumer<GetCategoryNamesCubit, GetCategoryNamesState>(
              listener: (context, state) {
                  if (state is GetCategoryNamesSuccess) {
                    if (state.categoryAndSubCategoryNames.length < 10) {
                      isLodingMore = false;
                    }
                    setState(() {
                       mainCategories = [
                          ...mainCategories,
                          ...state.categoryAndSubCategoryNames,
                        ];
                    });
                  }
                },
              builder: (context, state) {
                if (state is GetCategoryNamesLoading) {
                  return const GetCategoryNamesLoadingWidget();
                }
                if (state is GetCategoryNamesSuccess || state is GetCategoryNamesPaganiationFailer || state is GetCategoryNamesPaganiationLoading) {
                  widget.cubitAddProduct.selectedSubCategoryId =
                      widget.cubitCategories.subCategories.isNotEmpty
                          ? widget.cubitCategories.subCategories.first.categoryId
                          : null;

                  return GetCategoryNamesSuccessWidget(
                      key: ValueKey(mainCategories.length), // 👈 forces rebuild when items change
                      mainAndSubCategories: mainCategories,
                      cubitCategories: widget.cubitCategories,
                      cubitAddProduct: widget.cubitAddProduct,
                      scrollerController: scrollerController,
                      );
                }

                if (state is GetCategoryNamesFailure) {
                  return const GetCategoryNamesFailureWidget();
                }
                return const GetCategoryNamesInitialWidget();
                 // in else or initial
              },
            ),
          ],
        ),
      ),
    );
  }
}
