import '../../../../lib_exports.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key, required this.user});

  final UserData user;

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  late String name, phone;
  final formKey = GlobalKey<FormState>();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  void initState() {
    super.initState();
    name = widget.user.name;
    phone = widget.user.phone;
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(title: const Text('Edit Account')),
        body: Padding(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: formKey,
            autovalidateMode: autoValidateMode,
            child: ListView(
              physics: const BouncingScrollPhysics(),
              children: [
                Center(child: ChangeImageProfileWidget(user: widget.user)),
                const SizedBox(height: 20),
                ...addSpaceBetween(
                  children: [
                    TextFormFieldWidget(
                      initialValue: widget.user.name,
                      validator: (value) =>
                          validInput(value!, 1, 50, ValidationType.name),
                      prefixIcon: const Icon(Icons.person_2_rounded),
                      onChanged: (value) => setState(() => name = value),
                    ),
                    TextFormFieldWidget(
                      initialValue: widget.user.phone,
                      validator: (value) =>
                          validInput(value!, 11, 11, ValidationType.phone),
                      prefixIcon: const Icon(Icons.phone),
                      onChanged: (value) => setState(() => phone = value),
                      textInputAction: TextInputAction.done,
                    ),
                    const Divider(color: Colors.white),
                    ButtonWidget(
                      onPressed: () => Navigator.pushNamed(
                        context,
                        AppRouter.changePassword,
                      ),
                      title: 'Change Password',
                    ),
                    BlocConsumer<ProfileCubit, ProfileState>(
                      listener: _listenToEditingUser,
                      builder: (context, state) {
                        if (state is UpdateUserProfileLoading) {
                          return const LoaderWidget();
                        }
                        return ButtonWidget(
                          onPressed: _updateProfile,
                          title: 'Save',
                        );
                      },
                    ),
                  ],
                  space: const SizedBox(height: 16),
                ),
              ],
            ),
          ),
        ),
      );

  void _listenToEditingUser(context, state) {
    if (state is UpdateUserProfileError) {
      return showToast(state.error);
    }
    if (state is UpdateUserProfileSuccess) {
      showToast('Updated Successfully');
      Navigator.pop(context);
    }
  }

  Future<void> _updateProfile() async {
    if (formKey.currentState!.validate()) {
      await context.read<ProfileCubit>().updateUserProfile(
            name: name,
            phone: phone,
          );
    } else {
      setState(() => autoValidateMode = AutovalidateMode.always);
    }
  }
}
