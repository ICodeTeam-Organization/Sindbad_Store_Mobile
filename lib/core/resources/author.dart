class Author {
  final String login;
  final int id;
  final String nodeId;
  final String avatarUrl;
  final String url;

  Author({
    required this.login,
    required this.id,
    required this.nodeId,
    required this.avatarUrl,
    required this.url,
  });

  factory Author.fromJson(Map<String, dynamic> json) {
    return Author(
      login: json['login'],
      id: json['id'],
      nodeId: json['node_id'],
      avatarUrl: json['avatar_url'],
      url: json['url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'login': login,
      'id': id,
      'node_id': nodeId,
      'avatar_url': avatarUrl,
      'url': url,
    };
  }
}
