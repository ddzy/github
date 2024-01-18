import 'package:flutter/material.dart';
import 'package:flutter_highlighter/flutter_highlighter.dart';
import 'package:flutter_highlighter/themes/atom-one-dark.dart';
import 'package:flutter_highlighter/themes/atom-one-light.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

class CustomMarkdownCodeHighlighter extends MarkdownElementBuilder {
  CustomMarkdownCodeHighlighter();

  @override
  Widget? visitElementAfterWithContext(BuildContext context, md.Element element, TextStyle? preferredStyle, TextStyle? parentStyle) {
    // TODO: implement visitElementAfterWithContext
    super.visitElementAfterWithContext(context, element, preferredStyle, parentStyle);

    var language = '';

    if (element.attributes['class'] != null) {
      String lg = element.attributes['class'] as String;
      language = lg.substring(9);
    }

    debugPrint(language);

    return Container(
      color: Colors.white,
      width: MediaQueryData.fromView(View.of(context)).size.width,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        child: HighlightView(
          // The original code to be highlighted
          element.textContent,

          // Specify language
          // It is recommended to give it a value for performance
          language: language,

          // Specify highlight theme
          // All available themes are listed in `themes` folder
          // theme:
          //     MediaQueryData.fromWindow(WidgetsBinding.instance!.window).platformBrightness == Brightness.light ? atomOneLightTheme : atomOneDarkTheme,
          theme: MediaQueryData.fromView(View.of(context)).platformBrightness == Brightness.light ? atomOneLightTheme : atomOneDarkTheme,

          // Specify padding
          padding: const EdgeInsets.all(8),
        ),
      ),
    );
  }
}
