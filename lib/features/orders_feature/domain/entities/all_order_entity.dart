class OrderEntity {
  final int idOrder;
  final int idPackage;
  final String orderNum;
  final String orderBill;
  final String productMount;
  final String orderStatuse;
  final String payStatus;
  final String orderDates;

  OrderEntity({
    required this.idOrder,
    required this.idPackage,
    required this.orderNum,
    required this.orderBill,
    required this.productMount,
    required this.orderStatuse,
    required this.payStatus,
    required this.orderDates,
  });
}
