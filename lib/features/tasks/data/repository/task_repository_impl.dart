import 'package:dartz/dartz.dart';

import '../../../../lib_exports.dart';

class TaskRepositoryImpl implements TaskRepository {
  const TaskRepositoryImpl();

  @override
  Future<Either<String, Unit>> createTask({
    required String title,
    required String description,
    required String category,
    required DateTime deadline,
  }) async {
    final id = const Uuid().v4();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final task = TaskData(
      id: id,
      uploaderId: uid,
      title: title,
      description: description,
      category: category,
      deadline: deadline,
      createdAt: DateTime.now(),
      isDone: deadline.isBefore(DateTime.now()),
      comments: [],
    );
    try {
      await _taskDocument(id).set(task);
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, TaskData>> getTask({required String taskId}) async {
    try {
      final task = await _taskDocument(taskId).get();
      return right(task.data()!);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> updateTask({
    required String taskId,
    required TaskData task,
    String? title,
    String? description,
    String? category,
    DateTime? deadline,
    bool? isDone,
    List<Comment>? comments,
  }) async {
    try {
      TaskData taskData = task.copyWith(
        title: title,
        category: category,
        comments: comments,
        deadline: deadline,
        description: description,
        isDone: isDone,
      );
      await _taskDocument(taskId).update(taskData.toMap());
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> deleteTask(String id) async {
    try {
      await _taskDocument(id).delete();
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, UserData>> getTaskUploader({
    required String taskUploaderId,
  }) async {
    try {
      final taskUploader = await FirebaseFirestore.instance
          .collection(kUserCollection)
          .doc(taskUploaderId)
          .withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromMap(snapshot.data()!),
            toFirestore: (uploader, _) => uploader.toMap(),
          )
          .get();
      return right(taskUploader.data()!);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, Unit>> createComment({
    required String taskId,
    required TaskData task,
    required String? message,
    required String commenterName,
    required String commenterImage,
  }) async {
    if (message == null) return right(unit);
    final id = const Uuid().v4();
    final uid = FirebaseAuth.instance.currentUser!.uid;
    final comment = Comment(
      id: id,
      commenterId: uid,
      message: message,
      commenterName: commenterName,
      commenterImage: commenterImage,
      createdAt: DateTime.now(),
    );
    try {
      await _taskDocument(taskId).update({
        'comments': FieldValue.arrayUnion([comment.toMap()])
      });
      return right(unit);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Either<String, Stream<DocumentSnapshot<TaskData>>> getAllComments({
    required String taskId,
  }) {
    try {
      final tasks = _taskDocument(taskId).snapshots();
      return right(tasks);
    } catch (e) {
      return left(e.toString());
    }
  }

  DocumentReference<TaskData> _taskDocument(String id) =>
      FirebaseFirestore.instance
          .collection(kTasksCollection)
          .doc(id)
          .withConverter<TaskData>(
            fromFirestore: (snapshot, _) => TaskData.fromMap(snapshot.data()!),
            toFirestore: (task, _) => task.toMap(),
          );
}
