import '../../../../lib_exports.dart';

class TaskStatusWidget extends StatelessWidget {
  const TaskStatusWidget({super.key, required this.task});

  final TaskData task;

  @override
  Widget build(BuildContext context) {
    const textStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.bold,
    );
    return task.uploaderId == FirebaseAuth.instance.currentUser!.uid
        ? CheckboxListTile(
            value: task.isDone,
            onChanged: (value) async =>
                await _updateTaskStatus(context, task, value),
            activeColor: Colors.green,
            contentPadding: const EdgeInsets.only(right: 25),
            title: const Text('Done', style: textStyle),
          )
        : Row(
            children: [
              const Text('Task Status: ', style: textStyle),
              Text(
                task.isDone ? ' Completed' : ' On Progress...',
                style: TextStyle(
                  color: task.isDone ? Colors.green : kPrimaryColor,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          );
  }

  Future<void> _updateTaskStatus(
    BuildContext context,
    TaskData task,
    bool? value,
  ) async {
    final cubit = context.read<TasksCubit>();

    await cubit.updateTask(isDone: value);

    await cubit.getTask(taskId: task.id);
  }
}
