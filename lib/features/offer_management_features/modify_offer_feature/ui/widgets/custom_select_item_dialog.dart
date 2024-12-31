import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/domain/entities/offer_products_entity.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_products_cubit/offer_products_cubit.dart';
import 'package:sindbad_management_app/features/offer_management_features/modify_offer_feature/ui/manager/offer_products_cubit/offer_products_state.dart';

class CustomSelectItemDialog extends StatefulWidget {
  final List<OfferProductsEntity> selectedItems; // Receive pre-selected items
  final Function(List<OfferProductsEntity>) onConfirm;

  CustomSelectItemDialog({
    required this.selectedItems, // Initialize with pre-selected items
    required this.onConfirm,
  });

  @override
  _CustomSelectItemDialogState createState() => _CustomSelectItemDialogState();
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

  // late List<OfferProductsEntity> selectedItems = [];
  // late TextEditingController
  //     searchController; // Controller for search text field
  // List<OfferProductsEntity> filteredItems = []; // List to hold filtered items
  // bool isSetState = true;

  // @override
  // void initState() {
  //   super.initState();
  //   if (isSetState == true) {
  //     context.read<OfferProductsCubit>().getOfferProducts(10, 1);
  //     isSetState = false;
  //   } else {
  //     selectedItems =
  //         List.from(widget.selectedItems); // Copy pre-selected items
  //     isSetState = false;
  //   }
  //   searchController = TextEditingController(); // Initialize search controller
  //   searchController.addListener(() {
  //     filterItems();
  //   });
  //   print("Items passed to the selectedItems: ${widget.selectedItems}");
  //   print("Items passed to the selectedItems: ${isSetState}");
  // }

  // void filterItems() {
  //   setState(() {});
  // }

  // @override
  // void dispose() {
  //   searchController.dispose(); // Dispose of the controller when done
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25), // Rounded top corners
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // App Bar
          Container(
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
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
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              height: 600.h,
              child: Column(
                children: [
                  // Search Bar
                  TextField(
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
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(20.r),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.primary,
                          width: 1.0,
                        ),
                        borderRadius: BorderRadius.circular(10.r),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Item List
                  BlocBuilder<OfferProductsCubit, OfferProductsState>(
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

                        return Expanded(
                          child: ListView.builder(
                            itemCount: itemsToShow.length,
                            itemBuilder: (context, i) {
                              final product = itemsToShow[i];
                              return Column(
                                children: [
                                  CheckboxListTile(
                                    contentPadding: EdgeInsets.zero,
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    activeColor: AppColors.primary,
                                    side: BorderSide(color: AppColors.primary),
                                    value: selectedItems.contains(product),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedItems.add(product);
                                          print(
                                              state.offerProducts[i].productId);
                                        } else {
                                          selectedItems.remove(product);
                                          print(
                                              state.offerProducts[i].productId);
                                        }
                                      });
                                    },
                                    title: Row(
                                      children: [
                                        Image.network(
                                          product.productImage,
                                          width: 60.w,
                                          height: 60.h,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (BuildContext context,
                                              Widget child,
                                              ImageChunkEvent?
                                                  loadingProgress) {
                                            if (loadingProgress == null) {
                                              return child;
                                            }
                                            return Image.asset(
                                              'assets/default_image.png',
                                              width: 60.w,
                                              height: 60.h,
                                              fit: BoxFit.cover,
                                            );
                                          },
                                          errorBuilder:
                                              (context, error, stackTrace) {
                                            return Image.asset(
                                                width: 60.w,
                                                height: 60.h,
                                                fit: BoxFit.cover,
                                                'assets/default_image.png'); // Local fallback
                                          },
                                        ),
                                        SizedBox(width: 15.w),
                                        SizedBox(
                                          width: 170.w,
                                          child: Table(
                                            children: [
                                              TableRow(children: [
                                                Text(
                                                  product.productTitle,
                                                  style: KTextStyle.textStyle16
                                                      .copyWith(
                                                    color: AppColors.blackDark,
                                                  ),
                                                ),
                                              ])
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                  Divider(),
                                ],
                              );
                            },
                          ),
                        );
                      } else if (state is OfferProductsFailuer) {
                        return Center(child: Text(state.errMessage));
                      } else if (state is OfferProductsLoading) {
                        return Center(child: CircularProgressIndicator());
                      } else {
                        return Center(
                          child: Container(
                            color: Colors.red.shade400,
                            height: 50,
                            width: 300,
                            child: Text('لم يتم الوصول الى المعلومات'),
                          ),
                        );
                      }
                    },
                  ),
                  SizedBox(
                    height: 20.h,
                  ),
                  // Bottom Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context); // Cancel and close dialog
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 100.w,
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
                          widget.onConfirm(
                              selectedItems); // Return selected items
                          Navigator.pop(context);
                        },
                        child: Container(
                          alignment: Alignment.center,
                          height: 40.h,
                          width: 195.w,
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
