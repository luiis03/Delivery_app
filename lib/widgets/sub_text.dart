import 'package:flutter/cupertino.dart';

class SubText extends StatelessWidget {
  final Color? color;
  final String text;
  double size;
  double height;
  SubText({Key? key, this.color, required this.text, this.size = 12, this.height = 1.2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
        text,
        style: TextStyle(
            fontFamily: 'Roboto',
            color: color,
            fontSize: size,
            height: height
        )
    );
  }
}