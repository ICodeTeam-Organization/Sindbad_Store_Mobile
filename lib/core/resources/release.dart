import 'package:sindbad_management_app/core/resources/assets.dart';
import 'package:sindbad_management_app/core/resources/author.dart';

class Release {
  final String url;
  final String assetsUrl;
  final String uploadUrl;
  final String htmlUrl;
  final int id;
  final Author author;
  final String nodeId;
  final String tagName;
  final String targetCommitish;
  final String name;
  final bool draft;
  final bool immutable;
  final bool prerelease;
  final DateTime createdAt;
  final DateTime publishedAt;
  final List<Asset> assets;
  final String tarballUrl;
  final String zipballUrl;

  Release({
    required this.url,
    required this.assetsUrl,
    required this.uploadUrl,
    required this.htmlUrl,
    required this.id,
    required this.author,
    required this.nodeId,
    required this.tagName,
    required this.targetCommitish,
    required this.name,
    required this.draft,
    required this.immutable,
    required this.prerelease,
    required this.createdAt,
    required this.publishedAt,
    required this.assets,
    required this.tarballUrl,
    required this.zipballUrl,
  });

  factory Release.fromJson(Map<String, dynamic> json) {
    return Release(
      url: json['url'],
      assetsUrl: json['assets_url'],
      uploadUrl: json['upload_url'],
      htmlUrl: json['html_url'],
      id: json['id'],
      author: Author.fromJson(json['author']),
      nodeId: json['node_id'],
      tagName: json['tag_name'],
      targetCommitish: json['target_commitish'],
      name: json['name'],
      draft: json['draft'],
      immutable: json['immutable'],
      prerelease: json['prerelease'],
      createdAt: DateTime.parse(json['created_at']),
      publishedAt: DateTime.parse(json['published_at']),
      assets: (json['assets'] as List)
          .map((asset) => Asset.fromJson(asset))
          .toList(),
      tarballUrl: json['tarball_url'],
      zipballUrl: json['zipball_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'assets_url': assetsUrl,
      'upload_url': uploadUrl,
      'html_url': htmlUrl,
      'id': id,
      'author': author.toJson(),
      'node_id': nodeId,
      'tag_name': tagName,
      'target_commitish': targetCommitish,
      'name': name,
      'draft': draft,
      'immutable': immutable,
      'prerelease': prerelease,
      'created_at': createdAt.toIso8601String(),
      'published_at': publishedAt.toIso8601String(),
      'assets': assets.map((asset) => asset.toJson()).toList(),
      'tarball_url': tarballUrl,
      'zipball_url': zipballUrl,
    };
  }

  String get downloadApkLink {
    if (assets.isEmpty) {
      throw Exception("No assets found for this release");
    }

    // If you want specifically the `.apk` file:
    final apkAsset = assets.firstWhere(
      (a) => a.name.toLowerCase().endsWith(".apk"),
      orElse: () => assets.first, // fallback to the first asset
    );

    return "https://api.github.com/repos/ICodeTeam-Organization/Sindbad_Market_Mobile/releases/assets/${apkAsset.id}";
  }
}
