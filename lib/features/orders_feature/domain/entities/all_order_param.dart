class OrderParam {
  final List<int> statuses;
  final bool? isUrgent;
  final int pageNumber;
  final int pageSize;
  // final String storeId;
  // final String srearchKeyword;

  OrderParam({
    required this.statuses,
    this.isUrgent,
    required this.pageNumber,
    required this.pageSize,
    // required this.storeId,
    // required this.srearchKeyword,
  });
}
