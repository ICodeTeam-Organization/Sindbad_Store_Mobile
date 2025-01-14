import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../../core/styles/text_style.dart';

class TopOrderDetails extends StatelessWidget {
  const TopOrderDetails({
    super.key,
    required this.imageUrl,
    required this.productName,
    required this.productType,
    required this.productNameCat1,
    required this.productNameCat2,
    required this.productTypeCat1,
    required this.productTypeCat2,
    required this.orderDetailsId,
  });
  final int orderDetailsId;
  final String imageUrl;
  final String productName;
  final String productType;
  final String productNameCat1;
  final String productNameCat2;
  final String productTypeCat1;
  final String productTypeCat2;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Container(
        height: 90.h,
        width: 80.w,
        padding: const EdgeInsets.all(3),
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(width: 1.5, color: Colors.grey.shade400)),
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Image.network(
            imageUrl,
            fit: BoxFit.cover,
            errorBuilder: (context, error, stackTrace) =>
                Image.asset('assets/default_image.png'),
          ),
        ),
      ),
      title: Row(
        children: [
          Text(
            'اسم المنتج :  ',
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            productName,
            style: KTextStyle.textStyle14.copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      subtitle: Column(
        children: [
          Row(
            children: [
              Text(
                'نوع المنتج : ',
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              SizedBox(
                width: MediaQuery.sizeOf(context).width * 0.26,
                height: 20,
                child: Text(
                  productType,
                  overflow: TextOverflow.ellipsis,
                  style: KTextStyle.textStyle14
                      .copyWith(fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          Row(
            children: [
              Text(
                '$productNameCat1  ',
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                productTypeCat1,
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Spacer(),
              if (productNameCat2 != '' || productTypeCat2 != '') Text('|'),
              Spacer(),
              Text(
                '$productNameCat2  ',
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
              Text(
                productTypeCat2,
                style: KTextStyle.textStyle14
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
