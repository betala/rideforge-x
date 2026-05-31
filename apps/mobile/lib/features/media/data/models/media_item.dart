class MediaItem {
  const MediaItem({
    required this.id,
    required this.ownerType,
    required this.ownerId,
    required this.storagePath,
    required this.contentType,
    required this.createdAt,
    this.url,
    this.caption,
  });

  final String id;
  final String ownerType;
  final String ownerId;
  final String storagePath;
  final String contentType;
  final DateTime createdAt;
  final String? url;
  final String? caption;

  factory MediaItem.fromJson(Map<String, dynamic> json) => MediaItem(
        id: json['id'] as String,
        ownerType: json['ownerType'] as String,
        ownerId: json['ownerId'] as String,
        storagePath: json['storagePath'] as String,
        contentType: json['contentType'] as String,
        createdAt: DateTime.parse(json['createdAt'] as String),
        url: json['url'] as String?,
        caption: json['caption'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'ownerType': ownerType,
        'ownerId': ownerId,
        'storagePath': storagePath,
        'contentType': contentType,
        'createdAt': createdAt.toIso8601String(),
        'url': url,
        'caption': caption,
      };
}

