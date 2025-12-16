class AddOfferParams {
  final String name;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final bool isActive;
  final int numberOfOrders;
  final int offerHeadType;
  final List<Map<String, dynamic>> offerHeadOffers;

  AddOfferParams({
    required this.name,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.isActive,
    required this.numberOfOrders,
    required this.offerHeadType,
    required this.offerHeadOffers,
  });
}
