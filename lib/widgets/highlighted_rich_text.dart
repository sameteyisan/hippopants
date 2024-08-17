import 'package:flutter/material.dart';
import 'package:hippopants/utils/theme.dart';

class HighlightedRichText extends StatelessWidget {
  const HighlightedRichText({super.key, required this.splitted});
  final List<String> splitted;

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: splitted[0],
        style: Styles.normal.copyWith(color: Colors.black),
        children: splitted.skip(1).indexed.map((e) {
          TextStyle? style = e.$1 % 2 == 0 ? Styles.bold : null;

          return TextSpan(text: e.$2, style: style);
        }).toList(),
      ),
    );
  }
}
