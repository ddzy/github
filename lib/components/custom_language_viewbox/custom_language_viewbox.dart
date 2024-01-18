import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';

class CustomLanguageViewbox extends StatefulWidget {
  const CustomLanguageViewbox({super.key, required this.code, required this.language});

  final String code;
  final String language;

  @override
  State<StatefulWidget> createState() {
    return _CustomLanguageViewboxState();
  }
}

class _CustomLanguageViewboxState extends State<CustomLanguageViewbox> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: HighlightView(
          widget.code,
          language: widget.language,
          theme: MediaQueryData.fromView(View.of(context)).platformBrightness == Brightness.light ? atomOneLightTheme : atomOneDarkTheme,
          padding: const EdgeInsets.all(12),
        ),
      ),
    );
  }
}
