import 'package:flutter/material.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/utils.dart';

class ProductShowcase extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const ProductShowcase({
    Key? key,
    required this.title,
    required this.children,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screeenSize = Utils().getScreenSize();
    double height = screeenSize.height / 4;
    double titleHeight = 25;
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      height: height,
      width: screeenSize.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          SizedBox(
            height: titleHeight,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  "Show more",
                  style: TextStyle(color: activeCyanColor),
                )
              ],
            ),
          ),
          SizedBox(
            height: height - (titleHeight + 26),
            width: screeenSize.width,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: children,
            ),
          )
        ],
      ),
    );
  }
}
