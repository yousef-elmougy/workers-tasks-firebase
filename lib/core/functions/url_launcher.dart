import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'show_toast.dart';

Future<void> urlLauncher(String url) async {
  final uri = Uri.parse(url);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri,mode: LaunchMode.externalApplication);
  } else {
    showToast('Could not launch $uri', color: Colors.red);
  }
}
