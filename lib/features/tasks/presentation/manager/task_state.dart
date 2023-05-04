part of 'task_cubit.dart';

@immutable
abstract class TasksState {
  const TasksState();
}

class TaskInitial extends TasksState {
  const TaskInitial();
}

/// CREATE TASK
class CreateTaskLoading extends TasksState {
  const CreateTaskLoading();
}

class CreateTaskSuccess extends TasksState {
  const CreateTaskSuccess();
}

class CreateTaskError extends TasksState {
  final String error;
  const CreateTaskError(this.error);
}

/// UPDATE TASK
class UpdateTaskLoading extends TasksState {
  const UpdateTaskLoading();
}

class UpdateTaskSuccess extends TasksState {
  const UpdateTaskSuccess();
}

class UpdateTaskError extends TasksState {
  final String error;
  const UpdateTaskError(this.error);
}

/// DELETE TASK
class DeleteTaskLoading extends TasksState {
  const DeleteTaskLoading();
}

class DeleteTaskSuccess extends TasksState {
  const DeleteTaskSuccess();
}

class DeleteTaskError extends TasksState {
  final String error;
  const DeleteTaskError(this.error);
}

/// GET TASK
class GetTaskLoading extends TasksState {
  const GetTaskLoading();
}

class GetTaskSuccess extends TasksState {
  const GetTaskSuccess();
}

class GetTaskError extends TasksState {
  final String error;
  const GetTaskError(this.error);
}

/// GET TASK UPLOADER
class GetTaskUploaderLoading extends TasksState {
  const GetTaskUploaderLoading();
}

class GetTaskUploaderSuccess extends TasksState {
  const GetTaskUploaderSuccess();
}

class GetTaskUploaderError extends TasksState {
  final String error;
  const GetTaskUploaderError(this.error);
}

/// CREATE COMMENT
class CreateCommentLoading extends TasksState {
  const CreateCommentLoading();
}

class CreateCommentSuccess extends TasksState {
  const CreateCommentSuccess();
}

class CreateCommentError extends TasksState {
  final String error;
  const CreateCommentError(this.error);
}

/// GET ALL COMMENTS
class GetAllCommentsLoading extends TasksState {
  const GetAllCommentsLoading();
}

class GetAllCommentsSuccess extends TasksState {
  const GetAllCommentsSuccess();
}

class GetAllCommentsError extends TasksState {
  final String error;
  const GetAllCommentsError(this.error);
}
