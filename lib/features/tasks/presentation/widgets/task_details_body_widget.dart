
import '../../../../lib_exports.dart';

class TaskDetailsBodyWidget extends StatefulWidget {
  const TaskDetailsBodyWidget({
    super.key,
    required this.task,
  });
  final TaskData task;

  @override
  State<TaskDetailsBodyWidget> createState() => _TaskDetailsBodyWidgetState();
}

class _TaskDetailsBodyWidgetState extends State<TaskDetailsBodyWidget> {
  Future<void> _getTask() async =>
      await context.read<TasksCubit>().getTask(taskId: widget.task.id);

  @override
  void initState() {
    super.initState();
    _getTask();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TasksCubit, TasksState>(
      builder: (context, state) {
        if (state is GetTaskLoading) {
          return const LoaderWidget();
        } else {
          final task = context.read<TasksCubit>().task;
          const textStyle = TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          );
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 10),
              Text(
                'Created at:       ${task.createdAt?.toDateTime}',
                style: textStyle,
              ),
              const SizedBox(height: 5),
              Text(
                'Deadline:          ${task.deadline?.toDateTime}',
                style: textStyle,
              ),
              const SizedBox(height: 10),
              const Divider(),
              TaskStatusWidget(task: task),
              const Divider(),
              const SizedBox(height: 10),
              const Text('Description:', style: textStyle),
              const SizedBox(height: 10),
              Text(task.description),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 30),
            ],
          );
        }
      },
    );
  }
}