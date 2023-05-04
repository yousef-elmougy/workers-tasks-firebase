import '../../../../lib_exports.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => HomeCubit(),
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, state) {
            final currentIndex = context.read<HomeCubit>().currentIndex;
            return Scaffold(
              appBar: AppBar(title: Text(Menu.menuItems[currentIndex].title)),
              drawer: const DrawerWidget(),
              body: Menu.menuItems[currentIndex].screen!,
            );
          },
        ),
      );
}
