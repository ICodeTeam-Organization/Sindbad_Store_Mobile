import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/domain/entities/product_entity.dart';

void showProductSelectionDialog({
  required BuildContext context,
  required List<ProductEntity> products,
  required VoidCallback onConfirm,
}) {
  showDialog(
    context: context,
    barrierDismissible: false,
    builder: (_) {
      return ProductSelectionDialog(
        products: products,
        onConfirm: onConfirm,
      );
    },
  );
}

class ProductSelectionDialog extends StatefulWidget {
  final List<ProductEntity> products;
  final VoidCallback onConfirm;

  const ProductSelectionDialog({
    super.key,
    required this.products,
    required this.onConfirm,
  });

  @override
  State<ProductSelectionDialog> createState() => _ProductSelectionDialogState();
}

class _ProductSelectionDialogState extends State<ProductSelectionDialog> {
  final TextEditingController searchController = TextEditingController();

  late List<ProductEntity> filteredProducts;
  final Map<int, bool> selected = {};

  @override
  void initState() {
    super.initState();
    filteredProducts = widget.products;

    // initialize selection map
    for (var p in widget.products) {
      // selected[p.productId ?? 0] = false;
    }
  }

  void filter(String text) {
    // setState(() {
    //   filteredProducts = widget.products.where((product) {
    //     return product.productId!.contains(text) ||
    //         product.productNumber!.contains(text);
    //   }).toList();
    // });
  }

  void removeProduct(int productId) {
    setState(() {
      filteredProducts.removeWhere((p) => p.id == productId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.85,
        child: Column(
          children: [
            // Header
            Container(
              decoration: const BoxDecoration(
                color: Color(0xffFF746B),
                borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              ),
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "ايقاف المنتجات",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: () => Navigator.of(context).pop(),
                    child: const Icon(
                      Icons.close,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // Search Bar
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 16),
            //   child: TextField(
            //     controller: searchController,
            //     textAlign: TextAlign.right,
            //     decoration: InputDecoration(
            //       hintText: "بحث عن رقم المنتج او اسمه",
            //       prefixIcon: const Icon(Icons.search),
            //       contentPadding:
            //           const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            //       border: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //       ),
            //     ),
            //     onChanged: filter,
            //   ),
            // ),

            const SizedBox(height: 16),

            // Product List
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                itemCount: filteredProducts.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (_, index) {
                  final product = filteredProducts[index];
                  final id = product.id ?? 0;

                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 12),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Product info
                        Row(
                          children: [
                            if (product.imageUrl != null)
                              Image.network(
                                product.imageUrl!,
                                width: 45,
                                height: 45,
                                errorBuilder: (_, __, ___) => const Icon(
                                  Icons.image_not_supported,
                                  size: 40,
                                ),
                              ),
                            const SizedBox(width: 12),
                            Text(
                              product.name ?? "",
                              style: const TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),

                        // Remove button
                        GestureDetector(
                          onTap: () => removeProduct(id),
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: Colors.red.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.close,
                              size: 18,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Buttons
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Confirm Button
                  SizedBox(
                    width: 199,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onConfirm();
                        Navigator.pop(context);
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffFF746B),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "تأكيد",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
                  ),

                  // Cancel Button
                  SizedBox(
                    width: 104,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () => Navigator.pop(context),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff979797),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                      ),
                      child: const Text(
                        "الغاء",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                    ),
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
