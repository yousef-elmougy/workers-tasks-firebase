import 'lib_exports.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  Bloc.observer = AppBlocObserver();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (_) =>
                ProfileCubit(const ProfileRepositoryImpl())..getUserProfile(),
          ),
          BlocProvider(
            create: (_) =>
                TasksCubit(const TaskRepositoryImpl()),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            brightness: Brightness.dark,
            appBarTheme: const AppBarTheme(centerTitle: true),
          ),
          onGenerateRoute: AppRouter.onGenerateRoute,
          // home: const MainScreen(),
        ),
      );
}

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return const HomeScreen();
          } else {
            return const AuthScreen();
          }
        },
      );
}
