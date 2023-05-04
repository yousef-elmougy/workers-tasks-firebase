import '../../../../lib_exports.dart';

class TaskUploadedByWidget extends StatefulWidget {
  const TaskUploadedByWidget({super.key, required this.task});

  final TaskData task;

  @override
  State<TaskUploadedByWidget> createState() => _TaskUploadedByWidgetState();
}

class _TaskUploadedByWidgetState extends State<TaskUploadedByWidget> {
  Future<void> _getTaskUploader() async => await context
      .read<TasksCubit>()
      .getTaskUploader(taskUploaderId: widget.task.uploaderId);

  @override
  void initState() {
    super.initState();
    _getTaskUploader();
  }

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Text(
            'Uploaded By',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<TasksCubit, TasksState>(
            builder: (context, state) {
              if (state is GetTaskUploaderLoading) {
                return const LoaderWidget();
              } else {
                final taskUploader = context.read<TasksCubit>().taskUploader;
                return ListTile(
                  leading: FittedBox(
                    child: CircleImageWidget(image: taskUploader.image),
                  ),
                  title: Text(taskUploader.name),
                  subtitle: Text(taskUploader.position),
                );
              }
            },
          ),
        ],
      );
}
