import 'package:flutter/material.dart';
import 'package:ziin/common/colors.dart';

class ZButton extends StatelessWidget {
  ZButton({
    @required this.onPressed,
    this.icon,
    this.isDark = false,
    this.value,
  });
  final VoidCallback onPressed;
  final IconData icon;
  final bool isDark;
  final String value;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          if (!isDark)
            BoxShadow(
              color: Colors.black,
              offset: Offset(0, 4),
            ),
        ],
      ),
      child: RaisedButton(
        onPressed: onPressed,
        color: isDark ? Colors.black : Colors.white,
        textColor: isDark ? Colors.white : Colors.black,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            if (icon != null) Icon(icon),
            Text(
              value,
              style: TextStyle(
                fontSize: 21.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        splashColor: ZColors.yellowLight,
        highlightColor: ZColors.yellow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
          side: BorderSide(
            width: 2.0,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
