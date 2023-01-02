import 'package:flutter/material.dart';

class BottomWidget extends StatelessWidget {
  final String titelButton;
final VoidCallback? onPressed;
  BottomWidget({Key? key, required this.titelButton, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        child: ElevatedButton(
          child: Text(
            '${titelButton}',
            style: TextStyle(fontSize: 18, color: Colors.black),
          ),
          style: ElevatedButton.styleFrom(
              padding: EdgeInsets.all(12),
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15))),
          onPressed: onPressed,
        ));
  }
}
