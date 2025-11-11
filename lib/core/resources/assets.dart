class Asset {
  final int id;
  final String name;
  final String browserDownloadUrl;
  final int size;

  Asset({
    required this.id,
    required this.size,
    required this.name,
    required this.browserDownloadUrl,
  });

  factory Asset.fromJson(Map<String, dynamic> json) {
    return Asset(
      id: json['id'], // already an int
      name: json['name'],
      browserDownloadUrl: json['browser_download_url'],
      size: json['size'], // already an int
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'size': size,
      'name': name,
      'browser_download_url': browserDownloadUrl,
    };
  }
}
