import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppie_app/model/review_model.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/constants.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/cost_widget.dart';
import 'package:shoppie_app/widgets/custom_main_button.dart';
import 'package:shoppie_app/widgets/custom_simple_rounded_button.dart';
import 'package:shoppie_app/widgets/rating_star_widget.dart';
import 'package:shoppie_app/widgets/review_dialog.dart';
import 'package:shoppie_app/widgets/review_widget.dart';
import 'package:shoppie_app/widgets/search_bar_widget.dart';
import 'package:shoppie_app/widgets/user_detail_bar.dart';

import '../model/product_model.dart';
import '../model/user_model.dart';
import '../provider/user_detail_provider.dart';

class ProductScreen extends StatefulWidget {
  final ProductModel productModel;
  const ProductScreen({
    Key? key,
    required this.productModel,
  }) : super(key: key);

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  Size screenSize = Utils().getScreenSize();

  Expanded spaceThing = Expanded(
    child: Container(),
  );
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: SearchBarWidget(
          isReadOnly: true,
          hasBackButton: true,
        ),
        body: Stack(
          children: [
            SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          SizedBox(
                            height: screenSize.height -
                                (kAppBarHeight + (kAppBarHeight / 2)),
                            child: Column(
                              children: [
                                SizedBox(
                                  height: kAppBarHeight / 2,
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 5),
                                            child: Text(
                                              widget.productModel.sellerName,
                                              style: TextStyle(
                                                  color: activeCyanColor,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Text(widget.productModel.productName),
                                        ],
                                      ),
                                      RatingStarWidget(
                                          rating: widget.productModel.rating),
                                    ],
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(15),
                                  child: Container(
                                    height: screenSize.height / 3,
                                    constraints: BoxConstraints(
                                        maxHeight: screenSize.height / 3),
                                    child:
                                        Image.network(widget.productModel.url),
                                  ),
                                ),
                                spaceThing,
                                CostWidget(
                                    color: Colors.black,
                                    cost: widget.productModel.cost),
                                spaceThing,
                                CustomMainButton(
                                    child: Text('Buy Now'),
                                    color: Colors.orange,
                                    isLoading: false,
                                    onPressed: () async {
                                      await CloudFirestoreClass()
                                          .addProductToOrders(
                                              model: widget.productModel,
                                              userDetails: Provider.of<
                                                          UserDetailsProvider>(
                                                      context,
                                                      listen: false)
                                                  .userDetails);
                                      Utils().showSnackBar(
                                          context: context,
                                          content: "Process Done");
                                    }),
                                CustomMainButton(
                                    child: Text('Add to cart'),
                                    color: Colors.yellow,
                                    isLoading: false,
                                    onPressed: () async {
                                      await CloudFirestoreClass()
                                          .addProductToCard(
                                              productModel:
                                                  widget.productModel);
                                      Utils().showSnackBar(
                                          context: context,
                                          content: "added to cart");
                                    }),
                                spaceThing,
                                CustomSimpleRoundedButton(
                                    onPressed: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) => ReviewDialog(
                                          productUid: widget.productModel.uid,
                                        ),
                                      );
                                    },
                                    text: "Add a review for this product"),
                              ],
                            ),
                          ),
                          SizedBox(
                              height: screenSize.height,
                              child: StreamBuilder(
                                  stream: FirebaseFirestore.instance
                                      .collection("products")
                                      .doc(widget.productModel.uid)
                                      .collection("reviews")
                                      .snapshots(),
                                  builder: (context,
                                      AsyncSnapshot<
                                              QuerySnapshot<
                                                  Map<String, dynamic>>>
                                          snapshot) {
                                    if (snapshot.connectionState ==
                                        ConnectionState.waiting) {
                                      return Container();
                                    } else {
                                      return ListView.builder(
                                          itemCount: snapshot.data!.docs.length,
                                          itemBuilder: ((context, index) {
                                            ReviewModel model =
                                                ReviewModel.getModelFromJson(
                                                    json: snapshot
                                                        .data!.docs[index]
                                                        .data());
                                            return ReviewWidget(review: model);
                                          }));
                                    }
                                  }))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            UserDetailBar(
              offset: 0,
            )
          ],
        ),
      ),
    );
  }
}
