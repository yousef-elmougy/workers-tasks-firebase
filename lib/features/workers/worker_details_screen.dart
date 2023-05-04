import '../../../../lib_exports.dart';

class WorkerDetailsScreen extends StatelessWidget {
  const WorkerDetailsScreen({super.key, required this.user});

  final UserData user;

  @override
  Widget build(BuildContext context) {
    final userData = [
      'Name:             ${user.name}',
      'Email:              ${user.email}',
      'Phone:            ${user.phone}',
      'Position:          ${user.position}',
      'since joined:    ${user.createdAt!.toDateTime}',
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Worker Detail')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            CircleImageWidget(image: user.image),
            const Spacer(flex: 2),
            const Text(
              'Contact Info',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 25,
              ),
            ),
            const SizedBox(height: 20),
            ...addSpaceBetween(
              children: userData
                  .map((data) => Text(
                        data,
                        style: const TextStyle(fontSize: 18),
                      ))
                  .toList(),
              space: const SizedBox(height: 20),
            ),
            const Spacer(flex: 3),
            ContactUsIconsWidget(user: user),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
