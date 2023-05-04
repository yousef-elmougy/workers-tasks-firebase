import '../../../../lib_exports.dart';

class TasksScreen extends StatelessWidget {
  const TasksScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocListener<TasksCubit, TasksState>(
        listener: (context, state) {
          if (state is DeleteTaskError) {
            return showToast(state.error);
          }
          if (state is DeleteTaskSuccess) {
            return showToast('Task Deleted Successfully');
          }
        },
        child: StreamBuilder(
          stream: _getAllTasks,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const LoaderWidget();
            } else if (snapshot.hasError) {
              return Center(
                child: Text('ERROR: ${snapshot.error}'),
              );
            } else if (snapshot.hasData) {
              final tasks = snapshot.data!.docs;
              return ListView.separated(
                itemCount: tasks.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final task = tasks[index].data();
                  return ListTile(
                    leading: Icon(
                      task.isDone ? Icons.check : Icons.watch_later_outlined,
                      color: task.isDone ? Colors.green : kPrimaryColor,
                      size: 40,
                    ),
                    title: Text(task.title),
                    subtitle: Text(task.description),
                    trailing: task.uploaderId ==
                            FirebaseAuth.instance.currentUser!.uid
                        ? IconButton(
                            onPressed: () => _deleteTask(context, task),
                            icon: const Icon(Icons.delete, color: Colors.red),
                          )
                        : const Icon(Icons.arrow_forward_ios_rounded),
                    onTap: () => Navigator.pushNamed(
                      context,
                      AppRouter.taskDetails,
                      arguments: task,
                    ),
                  );
                },
              );
            }
            return const SizedBox();
          },
        ),
      );

  Future<void> _deleteTask(BuildContext context, TaskData task) async =>
      await context.read<TasksCubit>().deleteTask(task.id);

  Stream<QuerySnapshot<TaskData>> get _getAllTasks => FirebaseFirestore.instance
      .collection(kTasksCollection)
      .withConverter<TaskData>(
        fromFirestore: (snapshot, _) => TaskData.fromMap(snapshot.data()!),
        toFirestore: (user, _) => user.toMap(),
      )
      .snapshots();
}
