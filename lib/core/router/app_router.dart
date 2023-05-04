import '../../features/tasks/presentation/screens/task_details_screen.dart';
import '../../lib_exports.dart';
import '../../main.dart';

class AppRouter {
  static const auth = '/';
  static const editProfile = '/edit-profile';
  static const changePassword = '/change-password';
  static const workerDetails = '/worker-details';
  static const taskDetails = '/task-details';

  static Route? onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case auth:
        return MaterialPageRoute(builder: (_) => const MainScreen());

      case editProfile:
        final user = (settings.arguments as UserData);
        return MaterialPageRoute(builder: (_) => EditProfileScreen(user: user));

      case changePassword:
        return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());

      case workerDetails:
        final user = (settings.arguments as UserData);
        return MaterialPageRoute(
          builder: (_) => WorkerDetailsScreen(user: user),
        );



      case taskDetails:
        final task = (settings.arguments as TaskData);
        return MaterialPageRoute(
          builder: (_) => TaskDetailsScreen(task: task),
        );

      default:
        return _defaultRoute();
    }
  }

  static MaterialPageRoute<dynamic> _defaultRoute() => MaterialPageRoute(
        builder: (_) => Scaffold(
          appBar: AppBar(title: const Text('ERROR : Route Not Found')),
          body: const Center(
            child: Text(
              'ERROR : Route Not Found',
              style: TextStyle(fontSize: 20),
            ),
          ),
        ),
      );
}
