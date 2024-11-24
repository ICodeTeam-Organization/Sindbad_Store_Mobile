class AllOrderEntity {
  final int idOrder;
  final String orderNumber;
  final String orderBill;
  final String? orderTime;
  final DateTime? orderDate;
  final int productMount;
  final int orderStatus;
  final int paymentStatus;

  AllOrderEntity(
      {required this.idOrder,
      required this.orderNumber,
      required this.orderBill,
      required this.orderTime,
      required this.orderDate,
      required this.productMount,
      required this.orderStatus,
      required this.paymentStatus});
}
