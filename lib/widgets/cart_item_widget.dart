import 'package:flutter/material.dart';

import 'package:shoppie_app/model/product_model.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';
import 'package:shoppie_app/screens/product_screen.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/custom_simple_rounded_button.dart';
import 'package:shoppie_app/widgets/custom_square_button.dart';
import 'package:shoppie_app/widgets/product_information_widget.dart';

class CartItemWidget extends StatelessWidget {
  final ProductModel product;
  const CartItemWidget({
    Key? key,
    required this.product,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screensize = Utils().getScreenSize();
    return Container(
      padding: EdgeInsets.all(20),
      height: screensize.height / 2,
      width: screensize.width,
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey),
        ),
      ),
      child: Column(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            ProductScreen(productModel: product)),
                  );
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: screensize.width / 3,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network(product.url),
                      ),
                    ),
                    ProductInformationWidget(
                      productName: product.productName,
                      cost: product.cost,
                      sellerName: product.sellerName,
                    ),
                  ],
                ),
              ),
            ),
            flex: 3,
          ),
          Expanded(
            child: Row(
              children: [
                CustomSquareButton(
                    child: Icon(Icons.remove),
                    onPressed: () {},
                    color: backgroundColor,
                    dimension: 40),
                CustomSquareButton(
                    child: Text(
                      '0',
                      style: TextStyle(color: activeCyanColor),
                    ),
                    onPressed: () {},
                    color: Colors.white,
                    dimension: 40),
                CustomSquareButton(
                    child: Icon(Icons.add),
                    onPressed: () async {
                      CloudFirestoreClass().addProductToCard(
                          productModel: ProductModel(
                              url: product.url,
                              productName: product.productName,
                              cost: product.cost,
                              discount: product.discount,
                              uid: Utils().getUid(),
                              sellerName: product.sellerName,
                              sellerUid: product.sellerUid,
                              rating: product.rating,
                              noOfRating: product.noOfRating));
                    },
                    color: backgroundColor,
                    dimension: 40),
              ],
            ),
            flex: 1,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Column(mainAxisSize: MainAxisSize.min, children: [
                Row(
                  children: [
                    CustomSimpleRoundedButton(
                        onPressed: () async {
                          CloudFirestoreClass()
                              .deleteProductFromCart(uid: product.uid);
                        },
                        text: "Delete"),
                    SizedBox(
                      width: 10,
                    ),
                    CustomSimpleRoundedButton(
                        onPressed: () {}, text: "Save for later"),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(top: 7),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "See more like this",
                      style: TextStyle(
                        color: activeCyanColor,
                      ),
                    ),
                  ),
                )
              ]),
            ),
            flex: 1,
          ),
        ],
      ),
    );
  }
}
