import '../../../../lib_exports.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  String? oldPassword, newPassword;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Change Password')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ProfilePasswordTextField(
                  hintText: 'old Password',
                  onChanged: (value) => setState(() => oldPassword = value),
                ),
                const SizedBox(height: 30),
                ProfilePasswordTextField(
                  hintText: 'new Password',
                  onChanged: (value) => setState(() => newPassword = value),
                ),
                const SizedBox(height: 30),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: (context, state) {
                    if (state is UpdateUserPasswordError) {
                      return showToast(state.error);
                    }
                    if (state is UpdateUserPasswordSuccess) {
                      showToast(
                        'Password Updated Successfully',
                        color: Colors.green,
                      );

                      Navigator.pop(context);
                    }
                  },
                  builder: (context, state) {
                    if (state is UpdateUserPasswordLoading) {
                      return const LoaderWidget();
                    }
                    return ButtonWidget(
                      onPressed: _changePassword,
                      title: 'Save',
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      );

  Future<void> _changePassword() async {
    if (formKey.currentState!.validate()) {
      await context.read<ProfileCubit>().updateUserPassword(
            oldPassword: oldPassword!,
            newPassword: newPassword!,
          );
    } else {
      setState(() => autoValidateMode = AutovalidateMode.always);
    }
  }
}
