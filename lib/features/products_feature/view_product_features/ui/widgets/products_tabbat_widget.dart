import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/l10n/app_localizations.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/screens/all_products_tap.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/screens/offered_produts_tap.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/ui/screens/stopped_products_tap.dart';
import '../../../../../core/widgets/custom_app_bar.dart';
import '../../../../../core/widgets/custom_tab_bar_widget.dart';
import '../../../../../config/styles/colors.dart';

class ProductsTabBatWidget extends StatelessWidget {
  const ProductsTabBatWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return _ViewProductBody();
  }
}

class _ViewProductBody extends StatefulWidget {
  const _ViewProductBody();

  @override
  State<_ViewProductBody> createState() => _ViewProductBodyState();
}

class _ViewProductBodyState extends State<_ViewProductBody> {
  @override
  void initState() {
    super.initState();
    // Initialize the main category cubit - now the BLoCs are available
    // context
    //     .read<GetMainCategoryForViewCubit>()
    //     .getMainCategoryForView(pageNumber: 1, pageSize: 10);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            tital: l10n.products,
            isBack: false,
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: CustomTabBarWidget(
              tabs: [
                Tab(
                  child: Text(l10n.allProducts,
                      textAlign: TextAlign.center,
                      style: TextTheme.of(context).titleMedium),
                ),
                Tab(
                    child: Text(l10n.withOffers,
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).titleMedium)),
                Tab(
                    child: Text(l10n.stopped,
                        textAlign: TextAlign.center,
                        style: TextTheme.of(context).titleMedium)),
              ],
              tabViews: [
                AllProductsTap(),
                OfferedProdutsTap(),
                StoppedProductsTap(),
              ],
              length: 3,
              indicatorColor: AppColors.primary,
              indicatorWeight: 0.0.w,
              labelColor: AppColors.black,
              unselectedLabelColor: AppColors.black,
            ),
          ),
        ],
      ),
    );
  }
}
