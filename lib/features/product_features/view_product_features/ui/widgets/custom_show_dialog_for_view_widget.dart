import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomShowDialogForViewWidget extends StatelessWidget {
  final bool? isLoading;
  final String title;
  final String subtitle;
  final String? confirmText;
  final String? cancelText;
  final VoidCallback? onConfirm;
  final String? iconPath;
  const CustomShowDialogForViewWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onConfirm,
    this.iconPath,
    this.confirmText,
    this.cancelText,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.white, borderRadius: BorderRadius.circular(25.r)),
        height: 320.h,
        width: 390.w,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Close button (X)
                  Align(
                    alignment: Alignment.topLeft,
                    child: GestureDetector(
                      onTap: () => Navigator.of(context).pop(),
                      child: Icon(Icons.close, color: AppColors.greyIcon),
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Icon delete_dialog
                  CircleAvatar(
                    radius: 25,
                    backgroundColor: iconPath == null
                        ? AppColors.redOpacity
                        : AppColors.greenOpacity,
                    child: SvgPicture.asset(
                      iconPath ?? "assets/delete.svg",
                      width: 25.w,
                      height: 25.h,
                    ),
                  ),
                  const SizedBox(height: 16),
                  // Title
                  Text(
                    title,
                    style: KTextStyle.textStyle20.copyWith(
                      color: AppColors.blackDark,
                    ),
                  ),
                  const SizedBox(height: 8),
                  // Subtitle
                  Text(
                    subtitle,
                    style: KTextStyle.textStyle16.copyWith(
                      color: AppColors.greyLight,
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Action Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Confirm Button
                      InkWell(
                          onTap: isLoading == true ? null : onConfirm,
                          child: Container(
                              alignment: Alignment.center,
                              height: 40.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  color: AppColors.redOpacity,
                                  borderRadius: BorderRadius.circular(10)),
                              child: isLoading == true
                                  ? SizedBox(
                                      height: 25
                                          .h, // ضمان التناسق بين العرض والطول.
                                      width: 25.h,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      ),
                                    )
                                  : Text(confirmText ?? 'نعم , متابعة الحذف',
                                      style: KTextStyle.textStyle13.copyWith(
                                        color: AppColors.redDark,
                                      )))),
                      // Cancel Button
                      InkWell(
                          onTap: () => Navigator.of(context).pop(),
                          child: Container(
                              alignment: Alignment.center,
                              height: 40.h,
                              width: 130.w,
                              decoration: BoxDecoration(
                                  color: AppColors.blueOpacity,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Text(cancelText ?? 'لا , إلغاء العملية',
                                  style: KTextStyle.textStyle13.copyWith(
                                    color: AppColors.blueDark,
                                  )))),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
// void showDeleteDialog(
//     {required BuildContext contextPerant,
//     required int productId,
//     required int storeProductsFilter}) {
//   showDialog(
//     context: contextPerant,
//     builder: (BuildContext dialogContext) {
//       return BlocProvider(
//           create: (contextPerant) => DeleteProductByIdFromStoreCubit(
//                 DeleteProductByIdUseCase(
//                   getit.get<ViewProductStoreRepoImpl>(),
//                 ),
//               ),
//           child: BlocConsumer<DeleteProductByIdFromStoreCubit,
//               DeleteProductByIdFromStoreState>(listener: (context, state) {
//             if (state is DeleteProductByIdFromStoreSuccess) {
//               Navigator.of(context).pop(); // Close dialog
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text('تم حذف  المنتج بنجاح!')),
//               );
//               contextPerant
//                   .read<GetStoreProductsWithFilterCubit>()
//                   .getStoreProductsWitheFilter(
//                     storeProductsFilter: storeProductsFilter,
//                     pageNumper: 1,
//                     pageSize: 100,
//                   );
//             } else if (state is DeleteProductByIdFromStoreFailure) {
//               ScaffoldMessenger.of(context).showSnackBar(
//                 SnackBar(content: Text(state.errMessage)),
//               );
//             }
//           }, builder: (context, state) {
//             final cubitDeleteProductById =
//                 context.read<DeleteProductByIdFromStoreCubit>();
//             return CustomShowDialogForViewWidget(
//               title: 'حذف المنتج',
//               subtitle: 'هل تريد بالتأكيد حذف هذا المنتج؟',
//               isLoading: state is DeleteProductByIdFromStoreLoading,
//               onConfirm: () => cubitDeleteProductById.deleteProductById(
//                   productId: productId),
//               confirmText: 'نعم',
//               cancelText: 'لا',
//             );
//           }));
//     },
//   );
// }