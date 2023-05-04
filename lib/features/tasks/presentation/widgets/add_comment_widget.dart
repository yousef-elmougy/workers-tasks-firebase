import '../../../../lib_exports.dart';

class AddCommentWidget extends StatefulWidget {
  const AddCommentWidget({super.key});

  @override
  State<AddCommentWidget> createState() => _AddCommentWidgetState();
}

class _AddCommentWidgetState extends State<AddCommentWidget> {
  String? message;

  @override
  Widget build(BuildContext context) => BlocListener<TasksCubit, TasksState>(
        listener: _listenToCreateComment,
        child: Padding(
          padding: const EdgeInsets.all(16).copyWith(
            bottom: MediaQuery.of(context).viewInsets.bottom + 30,
          ),
          child: TextFormFieldWidget(
            autofocus: true,
            onChanged: (value) => setState(() => message = value),
            suffixIcon: IconButton(
              onPressed: _createComment,
              icon: const Icon(Icons.send),
            ),
          ),
        ),
      );

  Future<void> _createComment() async =>
      await context.read<TasksCubit>().createComment(context, message: message);

  Future<void> _listenToCreateComment(context, state) async {
    if (state is CreateCommentLoading) {
      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const LoaderWidget(),
      );
      if (!mounted) return;
      Navigator.pop(context);
    }
    if (state is CreateCommentError) return showToast(state.error);
    if (state is CreateCommentSuccess) {
      if (!mounted) return;
      return Navigator.pop(context);
    }
  }
}
