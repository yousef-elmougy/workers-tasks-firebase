import '../../../../lib_exports.dart';

class _ContactUs {
  final IconData icon;
  final Color color;
  final String url;

  const _ContactUs({
    required this.icon,
    required this.color,
    required this.url,
  });
}

class ContactUsIconsWidget extends StatelessWidget {
  const ContactUsIconsWidget({super.key, required this.user});

  final UserData user;

  @override
  Widget build(BuildContext context) {
    final contactUsData = [
      _ContactUs(
        icon: FontAwesomeIcons.whatsapp,
        color: const Color(0xff25d366),
        url: 'whatsapp://send?phone=+20${user.phone}',
      ),
      _ContactUs(
        icon: FontAwesomeIcons.envelope,
        color: Colors.red,
        url: 'mailto:${user.email}',
      ),
      _ContactUs(
        icon: Icons.phone,
        color: kPrimaryColor,
        url: 'tel:+20${user.phone}',
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: contactUsData
          .map(
            (data) => Container(
              decoration: ShapeDecoration(
                shape: CircleBorder(
                  side: BorderSide(width: 1, color: data.color),
                ),
              ),
              child: IconButton(
                onPressed: () async => await urlLauncher(data.url),
                icon: Icon(data.icon, size: 30, color: data.color),
              ),
            ),
          )
          .toList(),
    );
  }
}
