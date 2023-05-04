class Comment {
  final String id, commenterId, message, commenterName, commenterImage;
  final DateTime createdAt;

  const Comment({
    required this.id,
    required this.commenterId,
    required this.message,
    required this.commenterName,
    required this.commenterImage,
    required this.createdAt,
  });

  Comment copyWith({
    final String? id,
    final String? commenterId,
    final String? message,
    final String? commenterName,
    final String? commenterImage,
    final DateTime? createdAt,
  }) =>
      Comment(
        id: id ?? this.id,
        commenterId: commenterId ?? this.commenterId,
        message: message ?? this.message,
        commenterName: commenterName ?? this.commenterName,
        commenterImage: commenterImage ?? this.commenterImage,
        createdAt: createdAt ?? this.createdAt,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'commenterId': commenterId,
        'message': message,
        'commenterName': commenterName,
        'commenterImage': commenterImage,
        'createdAt': createdAt,
      };

  factory Comment.fromMap(Map<String, dynamic> map) => Comment(
        id: map['id'] ?? '',
        commenterId: map['commenterId'] ?? '',
        message: map['message'] ?? '',
        commenterName: map['commenterName'] ?? '',
        commenterImage: map['commenterImage'] ?? '',
        createdAt: map['createdAt'].toDate() ?? DateTime.now(),
      );

  @override
  String toString() =>
      'Comment(id: $id, commenterId: $commenterId, message: $message, commenterName: $commenterName, commenterImage: $commenterImage, createdAt: $createdAt)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Comment &&
        other.id == id &&
        other.commenterId == commenterId &&
        other.message == message &&
        other.commenterName == commenterName &&
        other.commenterImage == commenterImage &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode =>
      id.hashCode ^
      commenterId.hashCode ^
      message.hashCode ^
      commenterName.hashCode ^
      commenterImage.hashCode ^
      createdAt.hashCode;
}
