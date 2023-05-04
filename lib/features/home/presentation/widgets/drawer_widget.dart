import '../../../../lib_exports.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) => Drawer(
        child: ListView(
          children: [
            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                final user = context.read<ProfileCubit>().user;
                return UserAccountsDrawerHeader(
                  currentAccountPicture: state is GetUserProfileLoading
                      ? const LoaderWidget()
                      : ClipOval(
                          child: Image.network(user.image, fit: BoxFit.fill),
                        ),
                  accountName: Text(user.name),
                  accountEmail: Text(user.email),
                  decoration: const BoxDecoration(),
                );
              },
            ),
            ...List.generate(
              Menu.menuItems.length,
              (index) => ListTile(
                title: Text(Menu.menuItems[index].title),
                leading: Icon(Menu.menuItems[index].icon),
                onTap: () async => await _onChangeTabs(index, context),
              ),
            ),
          ],
        ),
      );

  Future<void> _onChangeTabs(int index, BuildContext context) async {
    if (index == 4) {
      await FirebaseAuth.instance.signOut();
    }

    if (!context.mounted) return;
    context.read<HomeCubit>().changeMenuTabs(index);
    Navigator.pop(context);
  }
}
