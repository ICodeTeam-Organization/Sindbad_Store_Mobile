class ProductsEndpointParameters {
  const ProductsEndpointParameters._(); // Private constructor

  /// Build query parameters as Map<String, dynamic> for Dio
  static Map<String, dynamic> buildQueryParameters({
    int? pageNumber,
    int? pageSize,
    String? search,
    String? store,
    String? supervisor,
    int? brand,
    bool? isOfficial,
    bool? isActive,
    bool? hasOffer,
    double? maxPrice,
    double? minPrice,
    List<int>? categories,
    List<int>? tags,
    bool? desc,
    bool? own,
  }) {
    final params = <String, dynamic>{};

    if (pageNumber != null) {
      params['pageNumber'] = pageNumber;
    }

    if (pageSize != null) {
      params['pageSize'] = pageSize;
    }

    if (search != null && search.isNotEmpty) {
      params['search'] = search;
    }

    if (store != null && store.isNotEmpty) {
      params['store'] = store;
    }

    if (supervisor != null && supervisor.isNotEmpty) {
      params['supervisor'] = supervisor;
    }

    if (brand != null) {
      params['brand'] = brand;
    }

    if (isOfficial != null) {
      params['isOfficial'] = isOfficial;
    }

    if (isActive != null) {
      params['isActive'] = isActive;
    }

    if (hasOffer != null) {
      params['hasOffer'] = hasOffer;
    }

    if (maxPrice != null) {
      params['maxPrice'] = maxPrice;
    }

    if (minPrice != null) {
      params['minPrice'] = minPrice;
    }

    if (categories != null && categories.isNotEmpty) {
      params['categories'] = categories;
    }

    if (tags != null && tags.isNotEmpty) {
      params['tags'] = tags;
    }

    if (desc != null) {
      params['desc'] = desc;
    }

    if (own != null) {
      params['own'] = own;
    }

    return params;
  }

  /// Optional: Helper method to build query string if needed
  static String buildQueryString(Map<String, dynamic> params) {
    if (params.isEmpty) return '';

    return params.entries.map((entry) {
      if (entry.value is List) {
        final list = entry.value as List;
        return list
            .map((item) =>
                '${entry.key}=${Uri.encodeComponent(item.toString())}')
            .join('&');
      }
      return '${entry.key}=${Uri.encodeComponent(entry.value.toString())}';
    }).join('&');
  }
}
