import '../../../../lib_exports.dart';

class TaskData {
  final String id, uploaderId, title, description, category;
  final DateTime? deadline, createdAt;
  final bool isDone;
  final List<Comment> comments;

  const TaskData({
    this.id = '',
    this.uploaderId = '',
    this.title = '',
    this.description = '',
    this.category = '',
    this.deadline,
    this.createdAt,
    this.isDone = false,
    this.comments = const [],
  });

  TaskData copyWith({
    final String? id,
    final String? uploaderId,
    final String? title,
    final String? description,
    final String? category,
    final DateTime? deadline,
    final DateTime? createdAt,
    final bool? isDone,
    final List<Comment>? comments,
  }) =>
      TaskData(
        id: id ?? this.id,
        uploaderId: uploaderId ?? this.uploaderId,
        title: title ?? this.title,
        description: description ?? this.description,
        category: category ?? this.category,
        deadline: deadline ?? this.deadline,
        createdAt: createdAt ?? this.createdAt,
        isDone: isDone ?? this.isDone,
        comments: comments ?? this.comments,
      );

  Map<String, dynamic> toMap() => {
        'id': id,
        'uploaderId': uploaderId,
        'title': title,
        'description': description,
        'category': category,
        'deadline': deadline,
        'createdAt': createdAt,
        'isDone': isDone,
        'comments': comments.map((comment) => comment.toMap()).toList(),
      };

  factory TaskData.fromMap(Map<String, dynamic> map) => TaskData(
        id: map['id'] ?? '',
        uploaderId: map['uploaderId'] ?? '',
        title: map['title'] ?? '',
        description: map['description'] ?? '',
        category: map['category'] ?? '',
        deadline: map['deadline'].toDate() ?? DateTime.now(),
        createdAt: map['createdAt'].toDate() ?? DateTime.now(),
        isDone: map['isDone'] ?? false,
        comments:
            List<Comment>.from(map['comments']?.map((x) => Comment.fromMap(x))),
      );

  @override
  String toString() =>
      'Task(id: $id, uploaderId: $uploaderId, title: $title, description: $description, category: $category, deadline: $deadline, createdAt: $createdAt, isDone: $isDone, comments: $comments)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is TaskData &&
        other.id == id &&
        other.uploaderId == uploaderId &&
        other.title == title &&
        other.description == description &&
        other.category == category &&
        other.deadline == deadline &&
        other.createdAt == createdAt &&
        other.isDone == isDone &&
        listEquals(other.comments, comments);
  }

  @override
  int get hashCode =>
      id.hashCode ^
      uploaderId.hashCode ^
      title.hashCode ^
      description.hashCode ^
      category.hashCode ^
      deadline.hashCode ^
      createdAt.hashCode ^
      isDone.hashCode ^
      comments.hashCode;
}
