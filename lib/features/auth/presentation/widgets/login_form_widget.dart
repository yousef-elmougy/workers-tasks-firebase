import '../../../../lib_exports.dart';

class LoginFormWidget extends StatefulWidget {
  const LoginFormWidget({super.key, this.toRegister});

  final VoidCallback? toRegister;

  @override
  State<LoginFormWidget> createState() => _LoginFormWidgetState();
}

class _LoginFormWidgetState extends State<LoginFormWidget> {
  final formKey = GlobalKey<FormState>();

  String? email, password;
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
              const SizedBox(height: 200),
              const Text(
                'LOGIN',
                style: TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 32),
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
              const SizedBox(height: 32),
              PasswordTextField(
                onSaved: (value) => setState(() => password = value),
              ),
              const SizedBox(height: 16),
              RichTextWidget(
                text: ' Don\'t have an account ?',
                clickedText: '   Register now',
                onClicked: widget.toRegister,
              ),
              const SizedBox(height: 50),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is LoginError) return showToast(state.error);
                  if (state is LoginSuccess) {
                    return showToast('Login Successfully');
                  }
                },
                builder: (context, state) => (state is LoginLoading)
                    ? const LoaderWidget()
                    : ButtonWidget(onPressed: _login, title: 'LOGIN'),
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      );

  Future<void> _login() async {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      await context.read<AuthCubit>().login(
            email: email!.trim(),
            password: password!.trim(),
          );
    } else {
      setState(() => autoValidateMode = AutovalidateMode.always);
    }
  }
}
