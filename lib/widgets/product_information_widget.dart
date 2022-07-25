import 'package:flutter/material.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/cost_widget.dart';

class ProductInformationWidget extends StatelessWidget {
  final String productName;
  final double cost;
  final String sellerName;
  ProductInformationWidget({
    Key? key,
    required this.productName,
    required this.cost,
    required this.sellerName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    SizedBox spaceThings = SizedBox(
      height: 7,
    );
    return SizedBox(
      width: screenSize.width / 2,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              productName,
              maxLines: 2,
              style: TextStyle(
                fontSize: 17,
                letterSpacing: 0.6,
                fontWeight: FontWeight.w500,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          spaceThings,
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 7),
            child: Align(
                alignment: Alignment.centerLeft,
                child: CostWidget(color: Colors.black, cost: cost)),
          ),
          spaceThings,
          Align(
            alignment: Alignment.centerLeft,
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Sold by ",
                    style: TextStyle(color: Colors.grey[700], fontSize: 12),
                  ),
                  TextSpan(
                    text: sellerName,
                    style: TextStyle(color: activeCyanColor, fontSize: 14),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
