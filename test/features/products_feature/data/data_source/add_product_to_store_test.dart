import 'dart:io';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindbad_management_app/core/api_service.dart';
import 'package:sindbad_management_app/features/products_feature/view_product_features/data/data_source/product_remote_data_source_impl.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Integration test for addProductToStore method
/// This test calls the real API with your token
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late ProductRemoteDataSourceImpl dataSource;
  late ApiService apiService;

  // ⚠️ IMPORTANT: Paste your real token here to test against the API
  const String testToken =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlcyI6IlN0b3JlIiwianRpIjoiZTIwZmJhZDctNTdhMC00Y2MyLTllZTgtNjBmNWYzOTdiODg5IiwiZW1haWwiOiJlbTEzQHNpbmRpYmFkLmNvbSIsIm5hbWUiOiLYr9mK2KzZitiq2KfZhCDYstmI2YYiLCJQaG9uZU51bWJlciI6IjU1MDAwMTExOTk5MTMiLCJJZCI6IjE2OTk2OTExLTU5N2YtNDg2Yi04NWI3LTZiMzA5ODY1NTEzOCIsImNvdW50cnkiOiIyIiwiZXhwIjoxNzcwNzk3NTg4LCJpc3MiOiJGYXN0U3RvcmUiLCJhdWQiOiJGYXN0U3RvcmUifQ.pRnALTYbEhK7jhUcGgUA3pAAScsVWHkgCSr7tNAGRf0';

  setUp(() {
    apiService = ApiService();
    dataSource = ProductRemoteDataSourceImpl(
      apiService,
      const FlutterSecureStorage(),
    );
  });

  group('addProductToStore Integration Tests', () {
    test('Test 1: Add product with minimum required fields', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found. Please provide a valid image path.');
        print('   Tried: ${testImageFile.path}');
        return;
      }

      print('📋 Test Parameters:');
      print('   Image exists: ${testImageFile.existsSync()}');
      print('   Image path: ${testImageFile.path}');
      print('   Image size: ${testImageFile.lengthSync()} bytes');

      final String productName = 'منتج تجريبي';
      final String productNumber =
          'PROD-${DateTime.now().millisecondsSinceEpoch}';

      try {
        final result = await dataSource.addProductToStore(
          name: productName,
          price: 99.99,
          description: 'وصف المنتج التجريبي',
          mainImageFile: testImageFile,
          number: productNumber,
          mainCategoryId: 1,
          subCategoryIds: [1],
          token: testToken,
        );

        print('✅ Success! Product added:');
        print(result);
      } catch (e) {
        print('❌ Error: $e');
        rethrow;
      }
    });

    test('Test 2: Add product with all fields', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found.');
        return;
      }

      try {
        final result = await dataSource.addProductToStore(
          name: 'منتج كامل ${DateTime.now().millisecondsSinceEpoch}',
          price: 199.99,
          description: 'وصف تفصيلي للمنتج مع كل الخصائص',
          mainImageFile: testImageFile,
          number: 'FULL-${DateTime.now().millisecondsSinceEpoch}',
          mainCategoryId: 1,
          subCategoryIds: [1, 2],
          storeId: 1,
          brandId: 1,
          newAttributes: [
            {'color': 'أحمر'},
            {'size': 'كبير'}
          ],
          tags: ['جديد', 'عرض', 'مميز'],
          oldPrice: 249.99,
          shortDescription: 'وصف مختصر للمنتج',
          token: testToken,
        );

        print('✅ Success! Full product added:');
        print(result);
      } catch (e) {
        print('❌ Error: $e');
        rethrow;
      }
    });

    test('Test 3: Add product with zero price', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found.');
        return;
      }

      try {
        final result = await dataSource.addProductToStore(
          name: 'منتج مجاني ${DateTime.now().millisecondsSinceEpoch}',
          price: 0,
          description: 'هذا منتج مجاني للتجربة',
          mainImageFile: testImageFile,
          number: 'FREE-${DateTime.now().millisecondsSinceEpoch}',
          mainCategoryId: 1,
          subCategoryIds: [1],
          tags: ['مجاني'],
          shortDescription: 'منتج مجاني',
          token: testToken,
        );

        print('✅ Success! Free product added:');
        print(result);
      } catch (e) {
        print('❌ Error: $e');
        rethrow;
      }
    });

    test('Test 4: Add product with high price', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found.');
        return;
      }

      try {
        final result = await dataSource.addProductToStore(
          name: 'منتج فاخر ${DateTime.now().millisecondsSinceEpoch}',
          price: 99999.99,
          description: 'منتج فاخر جداً',
          mainImageFile: testImageFile,
          number: 'LUX-${DateTime.now().millisecondsSinceEpoch}',
          mainCategoryId: 1,
          subCategoryIds: [1],
          tags: ['فاخر', 'حصري'],
          oldPrice: 150000.00,
          shortDescription: 'منتج فاخر',
          token: testToken,
        );

        print('✅ Success! Luxury product added:');
        print(result);
      } catch (e) {
        print('❌ Error: $e');
        rethrow;
      }
    });

    // ==================== Validation Error Tests ====================

    test('Test 5: Empty name should throw error', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found.');
        return;
      }

      try {
        await dataSource.addProductToStore(
          name: '', // empty name
          price: 100.00,
          description: 'Description',
          mainImageFile: testImageFile,
          number: 'EMPTY-NAME',
          mainCategoryId: 1,
          subCategoryIds: [1],
          token: testToken,
        );
        print('❌ Should have thrown an error!');
      } on ArgumentError catch (e) {
        print('✅ Correctly threw ArgumentError: ${e.message}');
      } catch (e) {
        print('❌ Wrong error type: $e');
      }
    });

    test('Test 6: Empty description should throw error', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found.');
        return;
      }

      try {
        await dataSource.addProductToStore(
          name: 'Product Name',
          price: 100.00,
          description: '', // empty description
          mainImageFile: testImageFile,
          number: 'EMPTY-DESC',
          mainCategoryId: 1,
          subCategoryIds: [1],
          token: testToken,
        );
        print('❌ Should have thrown an error!');
      } on ArgumentError catch (e) {
        print('✅ Correctly threw ArgumentError: ${e.message}');
      } catch (e) {
        print('❌ Wrong error type: $e');
      }
    });

    test('Test 7: Empty subCategoryIds should throw error', () async {
      final testImageFile = File(
          'C:/Users/mahfoud/Documents/GitHub/t/Sindbad_Store_Mobile/assets/images/login_image.png');

      if (!testImageFile.existsSync()) {
        print('⚠️ Test image not found.');
        return;
      }

      try {
        await dataSource.addProductToStore(
          name: 'Product Name',
          price: 100.00,
          description: 'Description',
          mainImageFile: testImageFile,
          number: 'EMPTY-CAT',
          mainCategoryId: 1,
          subCategoryIds: [], // empty subCategoryIds
          token: testToken,
        );
        print('❌ Should have thrown an error!');
      } on ArgumentError catch (e) {
        print('✅ Correctly threw ArgumentError: ${e.message}');
      } catch (e) {
        print('❌ Wrong error type: $e');
      }
    });

    test('Test 8: Non-existent image file should throw error', () async {
      final nonExistentFile = File('/path/to/nonexistent/image.jpg');

      try {
        await dataSource.addProductToStore(
          name: 'Product Name',
          price: 100.00,
          description: 'Description',
          mainImageFile: nonExistentFile,
          number: 'NO-IMAGE',
          mainCategoryId: 1,
          subCategoryIds: [1],
          token: testToken,
        );
        print('❌ Should have thrown an error!');
      } on ArgumentError catch (e) {
        print('✅ Correctly threw ArgumentError: ${e.message}');
      } catch (e) {
        print('❌ Wrong error type: $e');
      }
    });
  });
}
