import 'package:flutter/material.dart';

import 'package:shoppie_app/model/product_model.dart';
import 'package:shoppie_app/screens/product_screen.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/cost_widget.dart';
import 'package:shoppie_app/widgets/rating_star_widget.dart';

import 'search_bar_widget.dart';

class ResultsWidget extends StatelessWidget {
  final ProductModel product;

  const ResultsWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(productModel: product)));
      },
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                width: screenSize.width / 3,
                height: screenSize.height / 10,
                child: Image.network(product.url),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Text(
                  product.productName,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  children: [
                    SizedBox(
                      width: screenSize.width / 5,
                      child: FittedBox(
                        child: RatingStarWidget(rating: product.rating),
                      ),
                    ),
                    Text(
                      product.noOfRating.toString(),
                      style: TextStyle(color: activeCyanColor),
                    ),
                  ],
                ),
              ),
              SizedBox(
                  height: 20,
                  child: FittedBox(
                      child:
                          CostWidget(color: Colors.red, cost: product.cost))),
            ],
          ),
        ),
      ),
    );
  }
}
