import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomLink extends StatelessWidget {
  const CustomLink({super.key, required this.url});

  final String url;

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: InkWell(
        child: Text(
          url,
          style: const TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
        ),
        onTap: () => launchUrl(Uri.parse(url)),
      ),
    );
  }
}
