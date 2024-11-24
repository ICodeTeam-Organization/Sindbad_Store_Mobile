import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';
import 'package:sindbad_management_app/core/styles/text_style.dart';

class CustomSelectItemDialog extends StatefulWidget {
  final List<Item> items;
  final List<Item> selectedItems; // Receive pre-selected items
  final Function(List<Item>) onConfirm;

  CustomSelectItemDialog({
    required this.items,
    required this.selectedItems, // Initialize with pre-selected items
    required this.onConfirm,
  });

  @override
  _CustomSelectItemDialogState createState() => _CustomSelectItemDialogState();
}

class _CustomSelectItemDialogState extends State<CustomSelectItemDialog> {
  late List<Item> selectedItems; // Local list to track selection
  late List<Item> filteredItems; // List for filtered items based on search

  @override
  void initState() {
    super.initState();
    selectedItems = List.from(widget.selectedItems); // Copy pre-selected items
    filteredItems = widget.items; // Initialize filtered list
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
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
                    onChanged: (query) {
                      setState(() {
                        filteredItems = widget.items
                            .where((item) => item.title
                                .toLowerCase()
                                .contains(query.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  SizedBox(
                    height: 10.h,
                  ),
                  // Item List
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredItems.length,
                      itemBuilder: (context, index) {
                        return Column(
                          children: [
                            ListTile(
                              title: Row(
                                children: [
                                  Checkbox(
                                    activeColor: AppColors.primary,
                                    side: BorderSide(color: AppColors.primary),
                                    value: selectedItems
                                        .contains(filteredItems[index]),
                                    onChanged: (bool? value) {
                                      setState(() {
                                        if (value == true) {
                                          selectedItems
                                              .add(filteredItems[index]);
                                        } else {
                                          selectedItems
                                              .remove(filteredItems[index]);
                                        }
                                      });
                                    },
                                  ),
                                  Image.asset(
                                    filteredItems[index].imageUrl,
                                    width: 60.w,
                                    height: 60.h,
                                    fit: BoxFit.cover,
                                  ),
                                  SizedBox(width: 15.w),
                                  Text(
                                    filteredItems[index].title,
                                    style: KTextStyle.textStyle16.copyWith(
                                      color: AppColors.blackDark,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Divider(),
                          ],
                        );
                      },
                    ),
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

class Item {
  final String title;
  final String imageUrl;

  Item({required this.title, required this.imageUrl});
}
