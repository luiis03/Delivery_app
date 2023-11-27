import 'package:delivery_app/widgets/sub_text.dart';
import 'package:flutter/cupertino.dart';

class IconAndTextWidget extends StatelessWidget {
  final IconData icon;
  final String text;
  final Color textColor;
  final Color iconColor;
  const IconAndTextWidget({Key? key, required this.icon, required this.text, required this.textColor, required this.iconColor }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: iconColor),
        SizedBox(width: 5),
        SubText(text: text, color: textColor)
      ],
    );
  }
}