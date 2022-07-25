import 'package:flutter/material.dart';
import 'package:shoppie_app/screens/resulte_screen.dart';
import 'package:shoppie_app/utils/constants.dart';

class CategoryWidget extends StatelessWidget {
  final int index;
  const CategoryWidget({
    Key? key,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ResultScreen(query: categoriesList[index]),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.3),
                blurRadius: 8,
                spreadRadius: 1,
              )
            ]),
        child: Center(
            child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.network(categoryLogos[index]),
            Padding(
              padding: EdgeInsets.all(8),
              child: Text(
                categoriesList[index],
                style: TextStyle(fontWeight: FontWeight.w500),
              ),
            )
          ],
        )),
      ),
    );
  }
}
