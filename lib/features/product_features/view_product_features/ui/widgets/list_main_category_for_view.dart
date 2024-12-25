import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/main_category_for_view_entity.dart';
import '../manager/get_main_category_for_view/get_main_category_for_view_cubit.dart';
import 'custom_get_main_category_for_view_success_widget.dart';
import 'shimmer_for_main_category_for_view.dart';

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
          final mainCategoryForViewEntity =
              state.mainCategoryForViewEntity; // list for category
          final List<MainCategoryForViewEntity> allCategory = [
            MainCategoryForViewEntity(
                mainCategoryId: 0000, mainCategoryName: "الكل")
          ]; // list for category with "الكل"
          allCategory.addAll(mainCategoryForViewEntity); // marege

          return CustomGetMainCategoryForViewSuccessWidget(
              allCategory: allCategory);
        } else if (state is GetMainCategoryForViewFailure) {
          return Center(child: Text(state.errMessage));
        } else if (state is GetMainCategoryForViewLoading) {
          return ShimmerForMainCategoryForView();
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
