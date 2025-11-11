import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:sindbad_management_app/core/resources/release.dart';

class GitHubApiService {
  final String baseUrl =
      "https://api.github.com/repos/ICodeTeam-Organization/Sindbad_Market_Mobile/releases/latest";
  final String githubToken =
      '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';
  GitHubApiService();

  Future<List<Release>> listReleases() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'Bearer $githubToken',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);

      // Convert JSON list to List<GitHubRelease>
      final List<Release> releases = data
          .map((item) => Release.fromJson(item as Map<String, dynamic>))
          .toList();

      print(releases);
      print(releases[0].tagName); // Optional;: Debug print
      return releases;
    } else {
      throw Exception('Failed to load releases: ${response.statusCode}');
    }
  }

  Future<bool> isAvailableUpdate(String currentVersion) async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'Authorization': 'token $githubToken',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        // Handle both single release and multiple releases cases
        List<Release> releases;

        if (responseData is List) {
          // Multiple releases returned
          releases = (responseData as List)
              .map((item) => Release.fromJson(item as Map<String, dynamic>))
              .toList();
        } else if (responseData is Map) {
          // Single release returned
          releases = [Release.fromJson(responseData as Map<String, dynamic>)];
        } else {
          throw Exception('Unexpected response format');
        }

        if (releases.isEmpty) return false;

        // Sort releases by created date (latest first)
        releases.sort((a, b) => b.createdAt.compareTo(a.createdAt));

        final String latestVersion = releases.first.tagName
            .replaceFirst('v', ''); // Remove 'v' prefix if exists
        final String cleanCurrentVersion = currentVersion.replaceFirst('v', '');

        debugPrint('Current Version: $cleanCurrentVersion');
        debugPrint('Latest Version: $latestVersion');

        bool temp = _isVersionLower(cleanCurrentVersion, latestVersion);
        debugPrint(temp.toString());
        return temp;
      } else {
        throw Exception('Failed to load releases: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error checking for updates: $e');
      return false; // Or rethrow if you want to handle the error upstream
    }
  }

// Helper function to compare semantic versions
  bool _isVersionLower(String current, String latest) {
    // Remove non-numeric characters and compare as padded strings
    final currentClean = current.replaceAll(RegExp(r'[^0-9.]'), '');
    final latestClean = latest.replaceAll(RegExp(r'[^0-9.]'), '');

    // Split and compare each part
    final currentParts = currentClean.split('.');
    final latestParts = latestClean.split('.');

    final maxLength = currentParts.length > latestParts.length
        ? currentParts.length
        : latestParts.length;

    for (var i = 0; i < maxLength; i++) {
      final currentNum =
          i < currentParts.length ? int.parse(currentParts[i]) : 0;
      final latestNum = i < latestParts.length ? int.parse(latestParts[i]) : 0;

      if (currentNum != latestNum) {
        return currentNum < latestNum;
      }
    }
    return false;
  }

  Future<Release> getLatestRelease() async {
    try {
      final response = await http.get(
        Uri.parse(baseUrl),
        headers: {
          'Accept': 'application/vnd.github.v3+json',
          'Authorization': 'token $githubToken',
        },
      );

      if (response.statusCode == 200) {
        final dynamic responseData = json.decode(response.body);

        // Handle both cases: single release or list of releases
        if (responseData is List<dynamic>) {
          // Multiple releases returned
          if (responseData.isEmpty) {
            throw Exception('No releases found.');
          }

          final List<Release> releases = responseData
              .map<Release>(
                  (item) => Release.fromJson(item as Map<String, dynamic>))
              .toList();

          releases.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
          debugPrint(releases.first.assets[0].browserDownloadUrl.toString());
          return releases.first;
        } else if (responseData is Map<String, dynamic>) {
          // Single release returned
          final Release release = Release.fromJson(responseData);
          if (release.assets.isEmpty) {
            debugPrint('No assets found in release');
          } else {
            debugPrint(release.assets[0].browserDownloadUrl.toString());
          }
          return release;
        } else {
          throw Exception(
              'Unexpected response format: ${responseData.runtimeType}');
        }
      } else {
        throw Exception(
            'Failed to load latest release: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error getting latest release: $e');
      rethrow;
    }
  }

  Future<http.Request> getLatestReleaseWithApk() async {
    final response = await http.get(
      Uri.parse(baseUrl),
      headers: {
        'Accept': 'application/vnd.github.v3+json',
        'Authorization': 'token $githubToken',
      },
    );

    if (response.statusCode == 200) {
      final dynamic decoded = json.decode(response.body);

      Map<String, dynamic> latestRelease;

      // Handle both cases: single object or list
      if (decoded is List) {
        if (decoded.isEmpty) {
          throw Exception('No releases found.');
        }
        latestRelease = Map<String, dynamic>.from(decoded.first);
      } else if (decoded is Map) {
        latestRelease = Map<String, dynamic>.from(decoded);
      } else {
        throw Exception('Invalid response format');
      }

      // Extract assets list
      final List<dynamic> assets = latestRelease['assets'] ?? [];

      // Find first .apk asset
      for (final asset in assets) {
        if ((asset['name'] as String).toLowerCase().endsWith('.apk')) {
          debugPrint(asset['browser_download_url'] as String);

          final request = http.Request(
            'GET',
            Uri.parse(asset['browser_download_url'] as String),
          )..headers.addAll({
              'Accept': 'application/vnd.github.v3+json',
              'Authorization': 'token $githubToken',
            });
          return request;
        }
      }

      throw Exception('No APK asset found in the latest release');
    } else {
      throw Exception('Failed to load latest release: ${response.statusCode}');
    }
  }
}
