import '../../../lib_exports.dart';

class Menu {
  final String title;
  final IconData icon;
  final Widget? screen;

  const Menu({
    required this.title,
    required this.icon,
    this.screen,
  });

  static const menuItems = [
    Menu(
      title: 'All Tasks',
      icon: Icons.task_rounded,
      screen: TasksScreen(),
    ),
    Menu(
      title: 'My Account',
      icon: Icons.settings_rounded,
      screen: ProfileScreen(),
    ),
    Menu(
      title: 'Registered Workers',
      icon: Icons.workspaces_rounded,
      screen: RegisteredWorkersScreen(),
    ),
    Menu(
      title: 'Add Task',
      icon: Icons.add_task,
      screen: AddTaskScreen(),
    ),
    Menu(
      title: 'Logout',
      icon: Icons.logout_rounded,
    ),
  ];
}
