import '../../../../lib_exports.dart';

part 'task_state.dart';

class TasksCubit extends Cubit<TasksState> {
  TasksCubit(this.taskRepository) : super(const TaskInitial());

  final TaskRepository taskRepository;
  String? category;
  TaskData task = const TaskData();
  UserData taskUploader = const UserData();
  List<Comment> comments = [];

  /// CREATE TASK
  Future<void> createTask({
    required String title,
    required String description,
    required DateTime deadline,
  }) async {
    emit(const CreateTaskLoading());
    final task = await taskRepository.createTask(
      title: title,
      description: description,
      category: category!,
      deadline: deadline,
    );
    task.fold((error) => emit(CreateTaskError(error)),
        (_) => emit(const CreateTaskSuccess()));
  }

  /// GET TASK
  Future<void> getTask({required String taskId}) async {
    emit(const GetTaskLoading());
    final task = await taskRepository.getTask(taskId: taskId);
    task.fold(
      (error) {
        debugPrint(
            '---------------------------------------------------------------> $error');

        emit(GetTaskError(error));
      },
      (task) {
        this.task = task;
        emit(const GetTaskSuccess());
      },
    );
  }

  /// UPDATE TASK
  Future<void> updateTask({
    String? title,
    String? description,
    String? category,
    DateTime? deadline,
    bool? isDone,
    List<Comment>? comments,
  }) async {
    emit(const UpdateTaskLoading());
    final taskData = await taskRepository.updateTask(
      task: task,
      taskId: task.id,
      title: title,
      description: description,
      category: category,
      deadline: deadline,
      comments: comments,
      isDone: isDone,
    );
    taskData.fold((error) => emit(UpdateTaskError(error)),
        (_) async => emit(const UpdateTaskSuccess()));
  }

  /// DELETE TASK
  Future<void> deleteTask(String id) async {
    emit(const DeleteTaskLoading());
    final task = await taskRepository.deleteTask(id);
    task.fold((error) => emit(DeleteTaskError(error)),
        (_) => emit(const DeleteTaskSuccess()));
  }

  /// GET TASK UPLOADER
  Future<void> getTaskUploader({required String taskUploaderId}) async {
    emit(const GetTaskUploaderLoading());
    final taskUploader =
        await taskRepository.getTaskUploader(taskUploaderId: taskUploaderId);
    taskUploader.fold((error) {
      debugPrint(
          '---------------------------------------------------------------> $error');
      emit(GetTaskUploaderError(error));
    }, (taskUploader) {
      this.taskUploader = taskUploader;
      emit(const GetTaskUploaderSuccess());
    });
  }

  /// CREATE COMMENT
  Future<void> createComment(
    BuildContext context, {
    required String? message,
  }) async {
    emit(const CreateCommentLoading());
    await context.read<ProfileCubit>().getUserProfile();
    final user = context.read<ProfileCubit>().user;
    final comment = await taskRepository.createComment(
      task: task,
      taskId: task.id,
      message: message,
      commenterName: user.name,
      commenterImage: user.image,
    );
    comment.fold((error) => emit(CreateCommentError(error)),
        (_) => emit(const CreateCommentSuccess()));
  }

  /// GET ALL COMMENTS
  void getAllComments({required String taskId}) {
    emit(const GetAllCommentsLoading());
    final comment = taskRepository.getAllComments(taskId: taskId);
    comment.fold((error) {
      debugPrint(
          '---------------------------------------------------------------> $error');

      emit(GetAllCommentsError(error));
    },
        (tasks) => tasks.listen((task) {
              comments = task.data()!.comments;
              debugPrint('--------------------------->>> $comments');
              emit(const GetAllCommentsSuccess());
            }));
  }
}
