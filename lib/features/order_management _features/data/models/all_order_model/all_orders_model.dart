import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/all_order_entity.dart';

class AllOrdersModel extends AllOrderEntity {
  int? orderId;
  int? packageId;
  String? orderNumber;
  String? invoiceNumber;
  String? totalProducts;
  dynamic orderStatus;
  String? paymentStatus;
  String? orderDate;
  bool? isDelevredOrCancled;
  double? totalPrice;

  AllOrdersModel({
    this.orderId,
    this.packageId,
    this.orderNumber,
    this.invoiceNumber,
    this.totalProducts,
    this.orderStatus,
    this.paymentStatus,
    this.orderDate,
    this.isDelevredOrCancled,
    this.totalPrice,
  }) : super(
            idOrder: orderId!,
            idPackage: packageId!,
            orderNum: orderNumber ?? '0',
            orderBill: invoiceNumber ?? 'لا يوجد',
            orderDates: orderDate ?? '0000/0/0',
            productMount: totalProducts ?? '0',
            orderStatuse: orderStatus ?? 'لا توجد حالة',
            payStatus: paymentStatus ?? 'لا توجد',
            totalPrices: totalPrice ?? 0);

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) {
    return AllOrdersModel(
      orderId: json['orderId'] as int?,
      packageId: json['packageId'] as int?,
      orderNumber: json['orderNumber'] as String?,
      invoiceNumber: json['invoiceNumber'] as String?,
      totalProducts: json['totalProducts'] as String?,
      orderStatus: json['orderStatus'] as dynamic,
      paymentStatus: json['paymentStatus'] as String?,
      orderDate: json['orderDate'] as String?,
      isDelevredOrCancled: json['isDelevredOrCancled'] as bool?,
      totalPrice: json['totalPrice'] as double?,
    );
  }

  Map<String, dynamic> toJson() => {
        'orderId': orderId,
        'packageId': packageId,
        'orderNumber': orderNumber,
        'invoiceNumber': invoiceNumber,
        'totalProducts': totalProducts,
        'orderStatus': orderStatus,
        'paymentStatus': paymentStatus,
        'orderDate': orderDate,
        'isDelevredOrCancled': isDelevredOrCancled,
        'totalPrice': totalPrice,
      };
}
