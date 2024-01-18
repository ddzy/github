import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:github/components/custom_markdown_code_highlighter/custom_markdown_code_highlighter.dart';
import 'package:url_launcher/url_launcher.dart';

class CustomMarkdownViewbox extends StatelessWidget {
  const CustomMarkdownViewbox({super.key, required this.data});

  final String data;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
      child: MarkdownBody(
        data: data,
        selectable: true,
        imageBuilder: (uri, title, alt) {
          return ExtendedImage.network(uri.toString(), cache: true);
        },
        builders: {
          'code': CustomMarkdownCodeHighlighter(),
        },
        onTapLink: (text, href, title) {
          launchUrl(Uri.parse(href ?? ''));
        },
      ),
    );
  }
}
