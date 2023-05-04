
import '../../../../lib_exports.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen>
    with SingleTickerProviderStateMixin {
  bool isLogin = true;

  late AnimationController _controller;
  late Animation _animation;
  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(parent: _controller, curve: Curves.linear)
      ..addListener(() => setState(() {}))
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => AuthCubit(const AuthRepositoryImpl()),
        child: Scaffold(
          body: Container(
            constraints: const BoxConstraints.expand(),
            decoration: BoxDecoration(
              image: DecorationImage(
                alignment: FractionalOffset(_animation.value, 0),
                image: const AssetImage('assets/office.jpg'),
                fit: BoxFit.cover,
              ),
            ),
            child: isLogin
                ? LoginFormWidget(toRegister: toggle)
                : SignUpFormWidget(toLogin: toggle),
          ),
        ),
      );

  void toggle() => setState(() => isLogin = !isLogin);
}
