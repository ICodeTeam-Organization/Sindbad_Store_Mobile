import 'package:flutter/material.dart';
import 'package:sindbad_management_app/features/product_features/add_and_edit_product_feature/ui/screens/edit_product_screen.dart';

class MainEditProductScreen extends StatelessWidget {
  const MainEditProductScreen({super.key});

  // Updated fake data for editing a product
  static const Map<String, dynamic> fakeData = {
    "id": 14,
    "name": "Product14",
    "description": "Description14",
    "priceBeforOffer": 140,
    "priceAfterOffer": null,
    "percentageOfDiscount": null,
    "amountYouShouldToBuyForGetOffer": null,
    "amountYouWillGetFromOffer": null,
    "offerSentence": null,
    "offerStartDate": null,
    "offerEndDate": null,
    "mainImageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0",
    "number": "12542514432411364434454",
    "brandName": "Under Armour",
    "categoryName": "مواد البناء",
    "oneStarCount": 0,
    "twoStarCount": 0,
    "threeStarCount": 0,
    "fourStarCount": 0,
    "fiveStarCount": 0,
    "productImages": [
      {
        "imageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0"
      },
      {
        "imageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0"
      },
      {
        "imageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0"
      },
      {
        "imageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0"
      },
      {
        "imageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0"
      },
      {
        "imageUrl": "https://th.bing.com/th/id/R.540674531f56082695b585a5bcad1a1b?rik=Bc7NL80%2b9gvohQ&pid=ImgRaw&r=0"
      }
    ],
    "attributesWithValues": [{
      "attributeName": "حجم",
      "attributeValue": "كبير"
    },{
      "attributeName": "لون",
      "attributeValue": "أسود"
    }]
  };

  static const List<String> _mainCategoryList = [
    'إلكترونيات',
    'أزياء',
    'المنزل والمطبخ',
    'الجمال والعناية الشخصية',
    'الرياضة والأنشطة الخارجية',
    'الألعاب',
    'السيارات',
    'الكتب',
    'الموسيقى',
    'الصحة والعافية',
    'البقالة',
    'المجوهرات',
    'اللوازم المكتبية',
    'مستلزمات الحيوانات الأليفة',
    'منتجات الأطفال',
  ];

  static const List<String> _subCategoryList = [
    'لابتوبات',
    'شاشات',
    ' ماوسات',
    'كيبوردات',
  ];

  static const List<String> _brandList = [
    'مايكروسوفت',
    'ديل',
    'HP',
    'لينوفو',
    'أسس',
    'ماك',
    'الكتب',
    'سامسونج',
  ];

  @override
  Widget build(BuildContext context) {
    // Ensure initial items are valid and handle empty list case
    final String initialCategory = _mainCategoryList.contains(fakeData['categoryName'])
        ? fakeData['categoryName']
        : null;

    final String initialSubCategory = _subCategoryList.contains(fakeData['subcategory'])
        ? fakeData['subcategory']
        : null;

    final String initialBrand = _brandList.contains(fakeData['brandName'])
        ? fakeData['brandName']
        : null;

    return Scaffold(
      body: EditProductScreen(
        productId: fakeData['id'],
        productName: fakeData['name'],
        price: fakeData['priceBeforOffer'].toString(),
        productNumber: fakeData['number'],
        description: fakeData['description'],
        mainCategoryList: _mainCategoryList,
        selectedCategory: initialCategory,
        subCategoryList: _subCategoryList,
        selectedSubCategory: initialSubCategory,
        brandList: _brandList,
        selectedBrand: initialBrand,
        mainImage: fakeData['mainImageUrl'],
        subImages: List<String>.from(fakeData['productImages'].map((image) => image['imageUrl'])),
        properties: Map<String, String>.fromEntries(fakeData['attributesWithValues'].map((attr) => MapEntry(attr['attributeName'], attr['attributeValue']))),
      ),
    );
  }
}