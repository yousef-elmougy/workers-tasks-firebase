import '../../../../lib_exports.dart';

class SignUpFormWidget extends StatefulWidget {
  const SignUpFormWidget({super.key, this.toLogin});

  final VoidCallback? toLogin;

  @override
  State<SignUpFormWidget> createState() => _SignUpFormWidgetState();
}

class _SignUpFormWidgetState extends State<SignUpFormWidget> {
  String? name, email, phone, password;
  final formKey = GlobalKey<FormState>();

  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(left: 16, right: 16),
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              const SizedBox(height: 50),
              const Text(
                'SIGN UP',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
              const PickAuthImageWidget(),
              const SizedBox(height: 25),
              ...addSpaceBetween(
                children: [
                  GlassMorphismWidget(
                    child: TextFormFieldWidget(
                      validator: (value) =>
                          validInput(value!, 1, 50, ValidationType.name),
                      hintText: 'Name',
                      onSaved: (value) => setState(() => name = value),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.person_2_rounded),
                    ),
                  ),
                  GlassMorphismWidget(
                    child: TextFormFieldWidget(
                      validator: (value) =>
                          validInput(value!, 11, 50, ValidationType.email),
                      hintText: 'Email',
                      onSaved: (value) => setState(() => email = value),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.email),
                    ),
                  ),
                  PasswordTextField(
                    onSaved: (value) => setState(() => password = value),
                  ),
                  GlassMorphismWidget(
                    child: TextFormFieldWidget(
                      validator: (value) =>
                          validInput(value!, 11, 11, ValidationType.phone),
                      hintText: 'Phone',
                      onSaved: (value) => setState(() => phone = value),
                      border: InputBorder.none,
                      prefixIcon: const Icon(Icons.phone),
                    ),
                  ),
                  const PositionTextField(),
                  RichTextWidget(
                    text: ' Already have an account ?',
                    clickedText: '   Login now',
                    onClicked: widget.toLogin,
                  ),
                ],
                space: const SizedBox(height: 16),
              ),
              const SizedBox(height: 50),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is RegisterError) return showToast(state.error);
                  if (state is RegisterSuccess) {
                    return showToast('Register Successfully');
                  }
                },
                builder: (context, state) => (state is RegisterLoading)
                    ? const LoaderWidget()
                    : ButtonWidget(onPressed: _register, title: 'SIGN UP'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );

  Future<void> _register() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<AuthCubit>().register(
            email: email!.trim(),
            name: name!.trim(),
            password: password!.trim(),
            phone: phone!.trim(),
          );
    } else {
      setState(() => autoValidateMode = AutovalidateMode.always);
    }
  }
}
