import 'package:sindbad_management_app/features/product_features/view_product_features/domain/entities/product_entity.dart';

class FakeDataApi {
  final List<String> subCategsAll = ["الكل"];
  final List<String> subCat = [
    "الكترونيات",
    "لابتوبات",
    "شنط نسائية",
    "باريس",
    "الكترونيات",
    "لابتوبات",
    "شنط",
    "باريس",
    "الكترونيات",
    "لابتوبات",
    "شنط نسائية",
    "باريس",
    "الكترونيات",
    "لابتوبات",
    "شنط",
    "باريس"
  ];
  // Getter
  List<String> get subCategories => [...subCategsAll, ...subCat];
  // ==================================================================================
  static final List<ProductEntity> allProductsData = [
    ProductEntity(
        productid: 1,
        productName: 'Mobile A1',
        productNumber: '32',
        productPrice: 1200,
        productImageUrl: 'https://via.placeholder.com/100'),
    ProductEntity(
        productid: 2,
        productName: 'Mobile ahdg',
        productNumber: '122',
        productPrice: 2352,
        productImageUrl: 'https://via.placeholder.com/100'),
    ProductEntity(
        productid: 3,
        productName: 'Mobile iiai',
        productNumber: '24',
        productPrice: 525,
        productImageUrl: 'https://via.placeholder.com/100'),
  ];

  static final List<ProductEntity> offerProductsData = [
    ProductEntity(
        productid: 1,
        productName: 'Toyota Camry',
        productNumber: '765765476',
        productPrice: 25000,
        productImageUrl: 'https://via.placeholder.com/100'),
    ProductEntity(
        productid: 2,
        productName: 'Honda Accord',
        productNumber: '4324',
        productPrice: 23423,
        productImageUrl: 'https://via.placeholder.com/100'),
    ProductEntity(
        productid: 3,
        productName: 'Nissan Altima',
        productNumber: '34624',
        productPrice: 347,
        productImageUrl: 'https://via.placeholder.com/100'),
    // {
    //   'name': 'Toyota Camry',
    //   'id': '1',
    //   'price': '25000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Honda Accord',
    //   'id': '2',
    //   'price': '27000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Nissan Altima',
    //   'id': '3',
    //   'price': '24000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Ford Mustang',
    //   'id': '4',
    //   'price': '35000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Chevrolet Malibu',
    //   'id': '5',
    //   'price': '23000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'BMW 3 Series',
    //   'id': '6',
    //   'price': '42000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Audi A4',
    //   'id': '7',
    //   'price': '44000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Mercedes-Benz C-Class',
    //   'id': '8',
    //   'price': '48000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Volkswagen Passat',
    //   'id': '9',
    //   'price': '26000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Tesla Model 3',
    //   'id': '10',
    //   'price': '39000',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
  ];

  static final List<ProductEntity> disableProductsData = [
    ProductEntity(
        productid: 1,
        productName: 'Lionel Messi',
        productNumber: '3242',
        productPrice: 324,
        productImageUrl: 'https://via.placeholder.com/100'),
    ProductEntity(
        productid: 2,
        productName: 'Cristiano Ronaldo',
        productNumber: '3242',
        productPrice: 324,
        productImageUrl: 'https://via.placeholder.com/100'),
    ProductEntity(
        productid: 3,
        productName: 'Neymar Jr.',
        productNumber: '3242',
        productPrice: 324,
        productImageUrl: 'https://via.placeholder.com/100'),

    // {
    //   'name': 'Lionel Messi',
    //   'id': '1',
    //   'price': 'Paris Saint-Germain',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Cristiano Ronaldo',
    //   'id': '2',
    //   'price': 'Al Nassr',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Neymar Jr.',
    //   'id': '3',
    //   'price': 'Paris Saint-Germain',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Kevin De Bruyne',
    //   'id': '4',
    //   'price': 'Manchester City',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Kylian Mbappe',
    //   'id': '5',
    //   'price': 'Paris Saint-Germain',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Lionel Messi',
    //   'id': '6',
    //   'price': 'Paris Saint-Germain',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Cristiano Ronaldo',
    //   'id': '7',
    //   'price': 'Al Nassr',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Neymar Jr.',
    //   'id': '8',
    //   'price': 'Paris Saint-Germain',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Kevin De Bruyne',
    //   'id': '9',
    //   'price': 'Manchester City',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
    // {
    //   'name': 'Kylian Mbappe',
    //   'id': '10',
    //   'price': 'Paris Saint-Germain',
    //   'imageUrl': 'https://via.placeholder.com/100',
    // },
  ];

  // final List<String> _subCategs = ["الكل"];
  // final List<String> _subCategsApi = [
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط نسائية",
  //   "باريس",
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط",
  //   "باريس",
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط نسائية",
  //   "باريس",
  //   "الكترونيات",
  //   "لابتوبات",
  //   "شنط",
  //   "باريس",
  // ];

  // // Getter
  // List<String> get subCategs => [..._subCategs, ..._subCategsApi];
}
