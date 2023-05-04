import '../../../../lib_exports.dart';

class CommentsListWidget extends StatefulWidget {
  const CommentsListWidget({super.key, required this.task});
  final TaskData task;

  @override
  State<CommentsListWidget> createState() => _CommentsListWidgetState();
}

class _CommentsListWidgetState extends State<CommentsListWidget> {
  @override
  void initState() {
    super.initState();
    _getAllComments();
  }

  void _getAllComments() =>
      context.read<TasksCubit>().getAllComments(taskId: widget.task.id);

  @override
  Widget build(BuildContext context) => BlocBuilder<TasksCubit, TasksState>(
        builder: (context, state) {
          if (state is GetAllCommentsLoading) {
            return const SliverToBoxAdapter(child: LoaderWidget());
          } else {
            final comments = context.read<TasksCubit>().comments;
            return comments.isEmpty
                ? const SliverToBoxAdapter(
                    child: Center(child: Text('Add a Comment')),
                  )
                : SliverList(
                    delegate: SliverChildBuilderDelegate(
                      childCount: comments.length,
                      (context, index) {
                        final comment = comments[index];
                        return ListTile(
                          leading: FittedBox(
                            child: CircleImageWidget(
                                image: comment.commenterImage),
                          ),
                          title: Text(comment.commenterName),
                          subtitle: Text(comment.message),
                        );
                      },
                    ),
                  );
          }
        },
      );
}
