import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sindbad_management_app/features/profile_feature/data/data_source/excell_api_services.dart';
import 'package:sindbad_management_app/features/profile_feature/data/repo/exell_repository.dart';
import 'package:sindbad_management_app/features/profile_feature/domin/usecase/download_dll_files_use_case.dart';

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
  print("STARTING INTEGRATION TEST: DownloadAllFilesUseCase");
  print("----------------------------------------------------------------");

  // A. Setup Dependencies
  final fakeStorage = FakeSecureStorage();
  await fakeStorage.write(key: 'token', value: token); // Inject Real Token

  final dio = Dio();
  // Optional: Add logging
  // dio.interceptors.add(LogInterceptor(responseBody: true));

  final bulkService =
      BulkService("https://sindibad-back.com:84/", fakeStorage, dio);
  final repository = ExcellRepositoryImpl(bulkService);
  final useCase = DownloadAllFilesUseCase(repository);

  // B. Execute
  try {
    print("Executing Use Case (Fetch -> Download -> Save)...");
    final result = await useCase();

    // C. Verify
    result.fold(
      (failure) {
        print(
            "----------------------------------------------------------------");
        print("FAILURE! Error occurred:");
        print(failure.error);
        print(
            "----------------------------------------------------------------");
      },
      (success) {
        print(
            "----------------------------------------------------------------");
        print("SUCCESS! All files downloaded.");
        print("Saved Directory: ${success.data}");
        print(
            "----------------------------------------------------------------");
      },
    );
  } catch (e) {
    print("----------------------------------------------------------------");
    print("EXCEPTION! Unexpected error:");
    print(e);
    print("----------------------------------------------------------------");
  }
}

void main() {
  // 3. PASTE YOUR REAL TOKEN HERE
  const String myToken = "PASTE_YOUR_TOKEN_HERE";

  test('Integration Test', () async {
    if (myToken == "PASTE_YOUR_TOKEN_HERE") {
      print(
          "⚠️ PLEASE PASTE YOUR REAL TOKEN IN THE TEST FILE BEFORE RUNNING ⚠️");
      return;
    }
    await runIntegrationTest(token: myToken);
  });
}
