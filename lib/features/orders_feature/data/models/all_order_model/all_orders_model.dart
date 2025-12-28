import 'package:sindbad_management_app/features/orders_feature/domain/entities/all_order_entity.dart';

class OrderModel extends OrderEntity {
  int? orderId;
  int? packageId;
  String? orderNumber;
  String? invoiceNumber;
  String? totalProducts;
  dynamic orderStatus;
  String? paymentStatus;
  String? orderDate;
  bool? isDelevredOrCancled;

  OrderModel({
    this.orderId,
    this.packageId,
    this.orderNumber,
    this.invoiceNumber,
    this.totalProducts,
    this.orderStatus,
    this.paymentStatus,
    this.orderDate,
    this.isDelevredOrCancled,
  }) : super(
          idOrder: orderId!,
          idPackage: packageId!,
          orderNum: orderNumber ?? '0',
          orderBill: invoiceNumber ?? 'لا يوجد',
          orderDates: orderDate ?? '0000/0/0',
          productMount: totalProducts ?? '0',
          orderStatuse: orderStatus ?? 'لا توجد حالة',
          payStatus: paymentStatus ?? 'لا توجد',
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      orderId: json['orderId'] as int?,
      packageId: json['packageId'] as int?,
      orderNumber: json['orderNumber'] as String?,
      invoiceNumber: json['invoiceNumber'] as String?,
      totalProducts: json['totalProducts'] as String?,
      orderStatus: json['orderStatus'] as dynamic,
      paymentStatus: json['paymentStatus'] as String?,
      orderDate: json['orderDate'] as String?,
      isDelevredOrCancled: json['isDelevredOrCancled'] as bool?,
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
      };
}
