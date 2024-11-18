import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sindbad_management_app/core/styles/Colors.dart';

import '../../../../../core/shared_widgets/new_widgets/custom_app_bar.dart';
import '../../../../../core/styles/text_style.dart';

class ViewProduct extends StatefulWidget {
  const ViewProduct({super.key});

  @override
  State<ViewProduct> createState() => _ViewProductState();
}

class _ViewProductState extends State<ViewProduct> {
  @override
  Widget build(BuildContext context) {
    // ======= List Name Category ==============
    final List<String> subCategs = ["الكل"];
    const List<String> subCategsApi = [
      "الكترونيات",
      "لابتوبات",
      "شنط نسائية",
      "باريس",
      "الكترونيات",
      "لابتوبات",
      "شنط",
      "باريس",
      "الكترونيات",
      "لابتوبات",
      "شنط نسائية",
      "باريس",
      "الكترونيات",
      "لابتوبات",
      "شنط",
      "باريس",
    ];
    subCategs.addAll(subCategsApi);

    int indexSelected = 0;

    final List<Map<String, dynamic>> products = List.generate(
        10,
        (index) => {
              'name': 'MacBook Air',
              'id': '12342345',
              'price': '1500',
              'imageUrl': 'https://via.placeholder.com/100',
            });
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CustomAppBar(
            title: '',
          ),
          SizedBox(height: 20.h),
          // =================  Start Sub Category  ======================
          SizedBox(
            height: 50.h,
            child: ListView.builder(
                physics: AlwaysScrollableScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: subCategs.length,
                itemBuilder: (context, index) {
                  return ChipCustom(
                    title: subCategs[index],
                    onTap: () {
                      setState(() {
                        indexSelected = index;
                        debugPrint('isSelected: $indexSelected');
                      });
                    },
                    isSelected: indexSelected == index,
                  );
                }),
          ),
          // =================  end Sub Category  ======================
          // SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              // padding: EdgeInsets.all(0),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final product = products[index];
                return Container(
                  // margin:
                  //     const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                  // padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: index % 2 == 0 ? AppColors.background : Colors.white,
                    borderRadius: BorderRadius.circular(4),
                    // border: Border.all(color: Colors.redAccent, width: 1.5),
                  ),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      // Check Box
                      Checkbox(
                        value: false,
                        onChanged: (bool? value) {
                          // Checkbox action
                        },
                      ),
                      // Product Image
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.asset(
                          "assets/2.png",
                          width: 70.w,
                          height: 65.h,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Product Details
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'اسم المنتج: ${product['name']}',
                              style: const TextStyle(
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'رقم المنتج: ${product['id']}',
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'السعر: \$${product['price']}',
                              style: const TextStyle(
                                fontSize: 8,
                                color: Colors.red,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Action Buttons
                      Column(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit, color: Colors.orange),
                            onPressed: () {
                              // Edit action
                            },
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete, color: Colors.red),
                            onPressed: () {
                              // Delete action
                            },
                          ),
                        ],
                      ),
                      // Checkbox
                      const SizedBox(width: 8),
                    ],
                  ),
                );
              },
            ),
          )
        ],
      ),
      // ),
    );
  }
}

// =================  Start Sub Category Card =====================
class ChipCustom extends StatelessWidget {
  final String title;
  final bool isSelected;
  final void Function()? onTap;
  const ChipCustom(
      {super.key, required this.title, required this.isSelected, this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        // height: 40, // ثبات الارتفاع
        padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 12.h),
        margin: EdgeInsets.symmetric(horizontal: 2.5.w),
        decoration: BoxDecoration(
          // color: AppColors.background,
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.greyBorder,
          ),
          borderRadius: BorderRadius.circular(20), // دائري أكثر
        ),
        child: IntrinsicWidth(
          // يضبط العرض بناءً على النص تلقائيًا
          child: Center(
            child: Text(
              title,
              style: KTextStyle.textStyle14w500,
            ),
          ),
        ),
      ),
    );
  }
}
