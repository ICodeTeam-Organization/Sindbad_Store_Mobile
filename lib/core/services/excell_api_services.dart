import 'dart:convert';
import 'package:http/http.dart' as http;

class BulkService {
  final String baseUrl;

  BulkService(this.baseUrl);

  /// Sends bulk actions based on the actionInt code.
  Future<http.Response> sendBulkAction({
    required int actionInt,
    required Map<String, String> fields,
    Map<String, String>? files,
  }) async {
    late String url;

    if (actionInt == 1) {
      url = '$baseUrl/api/Products/Bulk_AddPrdctsWthAllDtls';
    } else if (actionInt > 1 && actionInt < 9) {
      url = '$baseUrl/api/Products/BulkProductsActions';
      fields['curAction'] = actionInt.toString();
    } else if (actionInt > 30 && actionInt < 50) {
      url = '$baseUrl/api/BulkRecordStoreCats';
      fields['curAction'] = actionInt.toString();
    } else {
      throw Exception("Invalid actionInt: $actionInt");
    }

    var request = http.MultipartRequest('POST', Uri.parse(url));

    // Add normal fields
    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    // Add files (optional)
    if (files != null) {
      for (var entry in files.entries) {
        request.files
            .add(await http.MultipartFile.fromPath(entry.key, entry.value));
      }
    }

    // Send Request
    var streamedResponse = await request.send();
    return await http.Response.fromStream(streamedResponse);
  }
}
