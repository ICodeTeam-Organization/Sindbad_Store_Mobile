import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/setup_service_locator.dart';
import 'package:sindbad_management_app/features/order_management%20_features/data/repos_impl/all_order_repo_impl.dart';
import 'package:sindbad_management_app/features/order_management%20_features/domain/usecases/all_order_usecase.dart';
import 'package:sindbad_management_app/features/order_management%20_features/ui/manager/all_order/all_order_cubit.dart';
import '../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../core/shared_widgets/new_widgets/custom_tab_bar_widget.dart';
import '../../../../core/styles/text_style.dart';
import '../widget/order_management_widget/before_tab_views.dart';
import '../widget/order_management_widget/canceled_tab_views.dart';
import '../widget/order_management_widget/new_tab_views/new_tab_views.dart';
import '../widget/order_management_widget/urgent_tab_views/urgent_tab_views.dart';

class OrderManagementScreen extends StatelessWidget {
  const OrderManagementScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AllOrderCubit(AllOrderUsecase(
        getit<AllOrderRepoImpl>(),
      )),
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.w),
            child: Column(
              children: [
                CustomAppBar(
                  isBack: false,
                  tital: 'قائمة الطلبات',
                ),
                SizedBox(height: 5),
                Expanded(
                  child: CustomTabBarWidget(
                    length: 4,
                    tabs: [
                      Tab(
                        child: Text('الجديدة', style: KTextStyle.textStyle16),
                      ),
                      Tab(
                        child: Text('المستعجلة', style: KTextStyle.textStyle16),
                      ),
                      Tab(
                        child: Text('السابقة', style: KTextStyle.textStyle16),
                      ),
                      Tab(
                        child: Text('الملغية', style: KTextStyle.textStyle16),
                      ),
                    ],
                    tabViews: [
                      //New tabViews
                      NewTabViews(),
                      //Urgent TabViews
                      UrgentTabViews(),
                      //Before TabViews
                      BeforeTabViews(),
                      //Canceled TabViews
                      CanceledTabViews(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
