import 'package:flutter/material.dart';
import 'package:shoppie_app/utils/utils.dart';

class CustomMainButton extends StatelessWidget {
  final Widget child;
  final Color color;
  final bool isLoading;
  final VoidCallback onPressed;
  const CustomMainButton({
    Key? key,
    required this.child,
    required this.color,
    required this.isLoading,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
          primary: color,
          fixedSize: Size(screenSize.width * 0.6, screenSize.height * 0.06)),
      onPressed: onPressed,
      child: !isLoading
          ? child
          : CircularProgressIndicator(
              color: Colors.white,
            ),
    );
  }
}
