import 'package:dartz/dartz.dart';

import '../../../../lib_exports.dart';

abstract class TaskRepository {
  const TaskRepository();

  Future<Either<String, Unit>> createTask({
    required String title,
    required String description,
    required String category,
    required DateTime deadline,
  });

  Future<Either<String, TaskData>> getTask({required String taskId});

  Future<Either<String, Unit>> updateTask({
    required String taskId,
    required TaskData task,
    String? title,
    String? description,
    String? category,
    DateTime? deadline,
    bool? isDone,
    List<Comment>? comments,
  });

  Future<Either<String, Unit>> deleteTask(String id);

  Future<Either<String, UserData>> getTaskUploader({
    required String taskUploaderId,
  });

  Future<Either<String, Unit>> createComment({
    required String taskId,
    required TaskData task,
    required String? message,
    required String commenterName,
    required String commenterImage,
  });
  
  Either<String, Stream<DocumentSnapshot<TaskData>>> getAllComments({
    required String taskId,
  });
}
