import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/config/styles/Colors.dart';
import 'package:sindbad_management_app/config/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_products_cubit/offer_products_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_products_cubit/offer_products_state.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/widgets/product_check_box_tile_widget.dart';

class CustomSelectItemDialog extends StatefulWidget {
  final List<OfferProductsEntity> selectedItems; // Receive pre-selected items
  final Function(List<OfferProductsEntity>) onConfirm;
  final List<OfferProductsEntity>? listProductForUpdate;

  const CustomSelectItemDialog({
    super.key,
    required this.selectedItems, // Initialize with pre-selected items
    required this.onConfirm,
    this.listProductForUpdate,
  });

  @override
  State<CustomSelectItemDialog> createState() => _CustomSelectItemDialogState();
}

class _CustomSelectItemDialogState extends State<CustomSelectItemDialog> {
  late List<OfferProductsEntity> selectedItems; // List of selected items
  late TextEditingController searchController; // Controller for search field
  bool isSetState = true;

  @override
  void initState() {
    super.initState();
    // Initialize selected items from passed widget data
    selectedItems = List.from(widget.selectedItems);
    // Fetch products only if state is being initialized for the first time
    if (isSetState) {
      context.read<OfferProductsCubit>().getOfferProducts(100, 1);
      isSetState = false;
    }
    // Initialize search controller
    searchController = TextEditingController();
    searchController.addListener(() {
      filterItems(); // Update UI on search query change
    });
  }

  void filterItems() {
    // This method can filter the displayed list in your builder if needed.
    // As the filtering logic is already applied in the builder, this may remain empty.
    setState(() {});
  }

  @override
  void dispose() {
    // Dispose the search controller to free resources
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.r), // Rounded top corners
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: AppColors.white, // Color of the bottom border
              width: 10.w, // Width of the bottom border
            ),
          ),
        ),
        child: Stack(
          children: [
            // App Bar
            Align(
              alignment: Alignment.topCenter,
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.primary,
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(25.r)),
                    ),
                    height: 75.h,
                    child: Padding(
                      padding: const EdgeInsets.all(15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'اضافة منتجات العرض',
                            style: KTextStyle.textStyle18.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                          InkWell(
                            onTap: () => Navigator.of(context).pop(),
                            child: Icon(
                              Icons.close,
                              color: AppColors.white,
                              size: 30.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Search Bar
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: TextField(
                      controller: searchController,
                      decoration: InputDecoration(
                        hintText: 'بحث عن رقم المنتج او اسمه',
                        hintStyle: KTextStyle.textStyle14.copyWith(
                          color: AppColors.greyDark,
                        ),
                        prefixIcon: Icon(Icons.search),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.greyBorder,
                            width: 1.0.w,
                          ),
                          borderRadius: BorderRadius.circular(20.r),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: AppColors.primary,
                            width: 1.0.w,
                          ),
                          borderRadius: BorderRadius.circular(10.r),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  Expanded(
                    child: BlocBuilder<OfferProductsCubit, OfferProductsState>(
                      builder: (context, state) {
                        if (state is OfferProductsSuccess) {
                          // Apply search filter on the complete list of products
                          final allProducts = state.offerProducts;
                          final mergedList = [
                            ...selectedItems, // Include selected items first
                            ...allProducts.where((item) => !selectedItems.any(
                                (selectedItem) =>
                                    selectedItem.productId ==
                                    item.productId)), // Include non-selected items
                          ];

                          final query = searchController.text.toLowerCase();
                          final itemsToShow = mergedList.where((item) {
                            return item.productTitle
                                    .toLowerCase()
                                    .contains(query) ||
                                item.productId
                                    .toString()
                                    .contains(query); // Search by title or ID
                          }).toList();

                          return ListView.builder(
                            itemCount: itemsToShow.length,
                            itemBuilder: (context, i) {
                              final product = itemsToShow[i];
                              return ProductCheckBoxTileWidget(
                                valueCheckBox: selectedItems.contains(product),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedItems.add(product);
                                    } else {
                                      selectedItems.remove(product);
                                    }
                                  });
                                },
                                pathImage: product.productImage,
                                title: product.productTitle,
                              );
                            },
                          );
                        } else if (state is OfferProductsFailuer) {
                          return Center(
                              child: Text(
                            state.errMessage,
                            textAlign: TextAlign.center,
                          ));
                        } else if (state is OfferProductsLoading) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return Center(
                            child: Container(
                              color: Colors.red.shade400,
                              height: 50.h,
                              child: Text('لم يتم الوصول الى المعلومات'),
                            ),
                          );
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
            // Bottom Buttons
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                alignment: Alignment.bottomCenter,
                color: AppColors.white,
                height: 70.h,
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 70.w,
                          decoration: BoxDecoration(
                            color: AppColors.greyLight,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            'الغاء',
                            style: KTextStyle.textStyle16.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          widget.onConfirm(selectedItems);
                          if (widget.listProductForUpdate != null) {
                            //selected items
                            widget.listProductForUpdate!.clear();
                            widget.listProductForUpdate!.addAll(selectedItems);
                          }
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 170.w,
                          decoration: BoxDecoration(
                            color: AppColors.primary,
                            borderRadius: BorderRadius.circular(5.r),
                          ),
                          child: Text(
                            'تاكيد',
                            style: KTextStyle.textStyle16.copyWith(
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
