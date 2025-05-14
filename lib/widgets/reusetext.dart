import 'package:flutter/material.dart';

class ReuseText extends StatelessWidget {
  final String? data;
  final double fontSize;
  final FontWeight fontWeight;
  final Color color;
  final TextSpan? richTextSpan;
  final VoidCallback? onClick;

  const ReuseText({
    Key? key,
    this.data,
    this.fontSize = 14,
    this.fontWeight = FontWeight.normal,
    this.color = Colors.black,
    this.richTextSpan,
    this.onClick,
  })  : assert(data != null || richTextSpan != null,
  'Either data or richTextSpan must be provided'),
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onClick,
      child: richTextSpan != null
          ? RichText(text: richTextSpan!)
          : Text(
        data!,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
          fontFamily: 'NunitoSans',
          color: color,
        ),
      ),
    );
  }
}
