import '../../../../../core/api_service.dart';
import '../../domain/entities/product_entity.dart';
import '../models/product_model/product_model.dart';

abstract class ViewProductRemoteDataSource {
  Future<List<ProductEntity>> getProductsByFilter(
    int storeProductsFilter,
    int pageNumper,
    int pageSize,
  );
}

class ViewProductRemoteDataSourceImpl extends ViewProductRemoteDataSource {
  final ApiService apiService;

  ViewProductRemoteDataSourceImpl(this.apiService);
  @override
  Future<List<ProductEntity>> getProductsByFilter(
      int storeProductsFilter, int pageNumper, int pageSize) async {
    var data = await apiService.get(
        endPoint: "Products/Store/GetStoreProductsWitheFilter");
    List<ProductEntity> products = getProductList(data);
    // print(products);
    return products;
  }

  List<ProductEntity> getProductList(Map<String, dynamic> data) {
    List<ProductEntity> products = [];
    for (var productMap in data['items']) {
      products.add(ProductModel.fromJson(productMap));
    }
    return products;
  }
}
