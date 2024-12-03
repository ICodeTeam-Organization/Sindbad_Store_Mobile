import 'package:sindbad_management_app/features/order_management%20_features/domain/entities/all_order_entity.dart';

class AllOrdersModel extends AllOrderEntity {
  int? id;
  String? orderNumber;
  String? invoiceNumber;
  String? totalProducts;
  dynamic orderStatus;
  String? paymentStatus;
  String? orderDate;

  AllOrdersModel({
    this.id,
    this.orderNumber,
    this.invoiceNumber,
    this.totalProducts,
    this.orderStatus,
    this.paymentStatus,
    this.orderDate,
  }) : super(
            idOrder: id ?? 0,
            orderNum: orderNumber ?? '0',
            orderBill: invoiceNumber ?? 'لا يوجد',
            // orderTime: '4:14',
            orderDates: orderDate ?? '0000/0/0',
            productMount: totalProducts ?? '0',
            orderStatuse: orderStatus ?? 'لا توجد حالة',
            payStatus: paymentStatus ?? 'لا توجد');

  factory AllOrdersModel.fromJson(Map<String, dynamic> json) {
    return AllOrdersModel(
      id: json['id'] as int?,
      orderNumber: json['orderNumber'] as String?,
      invoiceNumber: json['invoiceNumber'] as String?,
      totalProducts: json['totalProducts'] as String?,
      orderStatus: json['orderStatus'] as dynamic,
      paymentStatus: json['paymentStatus'] as String?,
      orderDate: json['orderDate'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'orderNumber': orderNumber,
        'invoiceNumber': invoiceNumber,
        'totalProducts': totalProducts,
        'orderStatus': orderStatus,
        'paymentStatus': paymentStatus,
        'orderDate': orderDate,
      };
}
