import '../../../../core/functions/choose_items_dialog.dart';
import '../../../../lib_exports.dart';

class AddTaskScreen extends StatefulWidget {
  const AddTaskScreen({super.key});

  @override
  State<AddTaskScreen> createState() => _AddTaskScreenState();
}

class _AddTaskScreenState extends State<AddTaskScreen> {
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;

  String? title, description;
  DateTime? deadline;

  @override
  Widget build(BuildContext context) {
    String? category = context.read<TasksCubit>().category;
    return Form(
      key: formKey,
      autovalidateMode: autovalidateMode,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const SizedBox(height: 40),
          ...addSpaceBetween(
            children: [
              TextFormFieldWidget(
                hintText: category ?? 'Choose Task Category',
                hintStyle:
                    TextStyle(color: category == null ? null : Colors.white),
                readOnly: true,
                prefixIcon: const Icon(Icons.category),
                onTap: _categoriesDialog,
                validator: (_) =>
                    category == null ? 'category is required' : null,
              ),
              TextFormFieldWidget(
                hintText: 'Task Title',
                onSaved: (value) => setState(() => title = value),
                maxLength: 100,
                prefixIcon: const Icon(Icons.title),
              ),
              TextFormFieldWidget(
                hintText: 'Task Description',
                onSaved: (value) => setState(() => description = value),
                maxLength: 1000,
                maxLine: 5,
                prefixIcon: const Icon(Icons.description),
              ),
              TextFormFieldWidget(
                hintText: deadline == null
                    ? 'Select Task Deadline'
                    : deadline!.toDateTime,
                hintStyle:
                    TextStyle(color: deadline == null ? null : Colors.white),
                readOnly: true,
                prefixIcon: const Icon(Icons.date_range),
                validator: (_) =>
                    deadline == null ? 'Deadline Date is required' : null,
                onTap: _selectDeadlineDateTime,
              ),
            ],
            space: const SizedBox(height: 25),
          ),
          const SizedBox(height: 60),
          BlocConsumer<TasksCubit, TasksState>(
            listener: _listenToAddingTask,
            builder: (context, state) => state is CreateTaskLoading
                ? const LoaderWidget()
                : ButtonWidget(
                    onPressed: _addTask,
                    title: 'Add Task',
                  ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDeadlineDateTime() async {
    final selectDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    );

    if (!mounted) return;
    final selectTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selectDate == null) return;
    if (selectTime == null) return;

    final date = DateTime(
      selectDate.year,
      selectDate.month,
      selectDate.day,
      selectTime.hour,
      selectTime.minute,
    );

    setState(() => deadline = date);
  }

  Future<void> _addTask() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<TasksCubit>().createTask(
            title: title!,
            description: description!,
            deadline: deadline!,
          );
      if (!mounted) return;
      context.read<HomeCubit>().changeMenuTabs(0);
      context.read<TasksCubit>().category = null;
    } else {
      setState(() => autovalidateMode = AutovalidateMode.always);
    }
  }

  void _listenToAddingTask(context, state) {
    if (state is CreateTaskError) return showToast(state.error);
    if (state is CreateTaskSuccess) {
      return showToast('Task Added Successfully', color: Colors.green);
    }
  }

  Future<void> _categoriesDialog() async => await chooseItemsDialog(
        context,
        onPressed: (index) => setState(
          () => context.read<TasksCubit>().category = categories[index],
        ),
        items: categories,
      );
}
