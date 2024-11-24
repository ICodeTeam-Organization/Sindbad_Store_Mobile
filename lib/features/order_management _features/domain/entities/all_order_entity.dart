class AllOrderEntity {
  final int idOrder;
  final String orderNum;
  final String orderBill;
  final String orderTime;
  final String orderDates;
  final String productMount;
  final String orderStatuse;
  final String payStatus;

  AllOrderEntity(
      {required this.idOrder,
      required this.orderNum,
      required this.orderBill,
      required this.orderTime,
      required this.orderDates,
      required this.productMount,
      required this.orderStatuse,
      required this.payStatus});
}
