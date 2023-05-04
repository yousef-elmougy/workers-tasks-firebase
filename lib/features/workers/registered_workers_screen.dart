import '../../lib_exports.dart';

class RegisteredWorkersScreen extends StatelessWidget {
  const RegisteredWorkersScreen({super.key});

  @override
  Widget build(BuildContext context) => StreamBuilder(
        stream: _getAllWorkers,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoaderWidget();
          } else if (snapshot.hasError) {
            return Center(
              child: Text('ERROR: ${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            final workers = snapshot.data!.docs;
            return ListView.separated(
              itemCount: workers.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final worker = workers[index].data();
                return ListTile(
                  leading: FittedBox(
                    child: CircleAvatar(
                      radius: 30,
                      backgroundImage: NetworkImage(worker.image),
                    ),
                  ),
                  title: Text(worker.name),
                  subtitle: Text('Position: ${worker.position}'),
                  trailing: IconButton(
                    onPressed: () async =>
                        await urlLauncher('mailto:${worker.email}'),
                    icon: const Icon(Icons.email_rounded),
                  ),
                  onTap: () => Navigator.pushNamed(
                    context,
                    AppRouter.workerDetails,
                    arguments: worker,
                  ),
                );
              },
            );
          }
          return const SizedBox();
        },
      );

  Stream<QuerySnapshot<UserData>> get _getAllWorkers =>
      FirebaseFirestore.instance
          .collection(kUserCollection)
          .withConverter<UserData>(
            fromFirestore: (snapshot, _) => UserData.fromMap(snapshot.data()!),
            toFirestore: (user, _) => user.toMap(),
          )
          .snapshots();
}
