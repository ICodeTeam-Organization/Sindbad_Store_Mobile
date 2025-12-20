import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/excell_api_services.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';

// 1. Fake Secure Storage
class FakeSecureStorage extends FlutterSecureStorage {
  final Map<String, String> _storage = {};

  @override
  Future<String?> read(
      {required String key,
      IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) async {
    return _storage[key];
  }

  @override
  Future<void> write(
      {required String key,
      required String? value,
      IOSOptions? iOptions,
      AndroidOptions? aOptions,
      LinuxOptions? lOptions,
      WebOptions? webOptions,
      MacOsOptions? mOptions,
      WindowsOptions? wOptions}) async {
    if (value != null) {
      _storage[key] = value;
    }
  }
}

// 2. Integration Test Function
Future<void> runIntegrationTest({required String token}) async {
  print("----------------------------------------------------------------");
  print("STARTING INTEGRATION TEST: ExcellRepositoryImpl.getFilesNames");
  print("----------------------------------------------------------------");

  // A. Setup Dependencies
  final fakeStorage = FakeSecureStorage();
  await fakeStorage.write(key: 'token', value: token); // Inject Real Token

  final bulkService = BulkService(fakeStorage);
  final repository = ExcellRepositoryImpl(bulkService);

  // B. Execute
  try {
    print("Sending Request...");
    final result = await repository.getFilesNames();

    // C. Verify
    result.fold(
      (failure) {
        print(
            "----------------------------------------------------------------");
        print("FAILURE! Error occurred:");
        print(failure.message);
        print(
            "----------------------------------------------------------------");
      },
      (success) {
        final files = success.data ?? [];
        print(
            "----------------------------------------------------------------");
        print("SUCCESS! Received ${files.length} files:");
        for (var file in files) {
          print("- ${file.strField} (ID: ${file.intField})");
        }
        print(
            "----------------------------------------------------------------");
      },
    );
  } catch (e) {
    print("----------------------------------------------------------------");
    print("FAILURE! Unexpected error:");
    print(e);
    print("----------------------------------------------------------------");
  }
}

void main() {
  // 3. PASTE YOUR REAL TOKEN HERE
  const String myToken =
      "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJyb2xlcyI6IlN0b3JlIiwianRpIjoiYmM5YTY0ZGItZTRhNS00OGU2LTg1NGMtOTFlZTJkN2E1ZmEwIiwiZW1haWwiOiJlbTEzQHNpbmRpYmFkLmNvbSIsIm5hbWUiOiLYr9mK2KzZitiq2KfZhCDYstmI2YYiLCJQaG9uZU51bWJlciI6IjU1MDAwMTExOTk5MTMiLCJJZCI6IjE2OTk2OTExLTU5N2YtNDg2Yi04NWI3LTZiMzA5ODY1NTEzOCIsImNvdW50cnkiOiIyIiwiZXhwIjoxNzY5MTU1MzIzLCJpc3MiOiJGYXN0U3RvcmUiLCJhdWQiOiJGYXN0U3RvcmUifQ.RbCEz3sC4wRXXSUf7f9_hYQZ-fbhvpjUw9o-dhs2QWA";

  test('Integration Test', () async {
    if (myToken == "PASTE_YOUR_TOKEN_HERE") {
      print(
          "⚠️ PLEASE PASTE YOUR REAL TOKEN IN THE TEST FILE BEFORE RUNNING ⚠️");
      return;
    }
    await runIntegrationTest(token: myToken);
  });
}
