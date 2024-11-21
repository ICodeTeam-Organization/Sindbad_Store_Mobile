import 'package:dartz/dartz.dart';
import 'package:sindbad_management_app/core/errors/failure.dart';
import '../entities/product_entity.dart';

abstract class ViewProductRepo {
  Future<Either<Failure, List<ProductEntity>>> getProductsByFilter(
    int storeProductsFilter,
    int pageNumper,
    int pageSize,
  );
}
