import '../../../../lib_exports.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state is GetUserProfileLoading) {
            return const LoaderWidget();
          }
          final user = context.read<ProfileCubit>().user;
          final userData = [
            'Name:             ${user.name}',
            'Email:              ${user.email}',
            'Phone:            ${user.phone}',
            'Position:          ${user.position}',
            'since joined:    ${user.createdAt!.toDateTime}',
          ];

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                CircleImageWidget(image: user.image),
                const SizedBox(height: 20),
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
                  space: const SizedBox(height: 10),
                ),
                const SizedBox(height: 30),
                ContactUsIconsWidget(user: user),
                const SizedBox(height: 30),
                ButtonWidget(
                  onPressed: () => Navigator.pushNamed(
                    context,
                    AppRouter.editProfile,
                    arguments: user,
                  ),
                  title: 'Edit Account',
                ),
                const SizedBox(height: 30),
                BlocConsumer<ProfileCubit, ProfileState>(
                  listener: _listenToDeleteUser,
                  builder: (context, state) => state is DeleteUserProfileLoading
                      ? const LoaderWidget()
                      : ButtonWidget(
                          onPressed: () async => await _deleteAccount(context),
                          title: 'Remove Account',
                        ),
                ),
              ],
            ),
          );
        },
      );

  void _listenToDeleteUser(context, state) {
    if (state is DeleteUserProfileError) {
      return showToast(state.error);
    }
    if (state is DeleteUserProfileSuccess) {
      showToast(
        'Account Deleted Successfully',
        color: Colors.green,
      );
      Navigator.pop(context);
    }
  }

  Future<void> _deleteAccount(BuildContext context) => showAlertDialog(
        context,
        content: 'Are you confirm deleting the account?',
        onPressed: () async =>
            await context.read<ProfileCubit>().deleteUserProfile(),
      );
}
