
import '../../../../lib_exports.dart';

class TaskDetailsScreen extends StatelessWidget {
  const TaskDetailsScreen({super.key, required this.task});

  final TaskData task;

  @override
  Widget build(BuildContext context) => Scaffold(
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async => await showModalBottomSheet(
            context: context,
            builder: (context) => const AddCommentWidget(),
          ),
          backgroundColor: kPrimaryColor,
          icon: const Icon(Icons.comment),
          label: const Text('Add Comment'),
        ),
        appBar: AppBar(title: const Text('Task Details')),
        body: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TaskUploadedByWidget(task: task),
                    TaskDetailsBodyWidget(task: task),
                    const Text(
                      'Comments:',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CommentsListWidget(task: task),
          ],
        ),
      );
}

