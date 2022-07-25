import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoppie_app/widgets/loading_widget.dart';

import '../model/product_model.dart';
import '../utils/utils.dart';
import '../widgets/results_widget.dart';
import '../widgets/search_bar_widget.dart';

class ResultScreen extends StatelessWidget {
  final String query;
  const ResultScreen({
    Key? key,
    required this.query,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: SearchBarWidget(isReadOnly: false, hasBackButton: true),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(15),
            child: RichText(
              text: TextSpan(
                children: [
                  TextSpan(
                    text: "Showing results for ",
                    style: TextStyle(fontSize: 18, color: Colors.black),
                  ),
                  TextSpan(
                    text: query,
                    style: TextStyle(
                      fontSize: 17,
                      fontStyle: FontStyle.italic,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              child: FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("products")
                      .where("productName", isEqualTo: query)
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return LoadingWidget();
                    } else {
                      return GridView.builder(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 3, childAspectRatio: 2 / 3.5),
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            ProductModel product =
                                ProductModel.getModelFromJson(
                                    json: snapshot.data!.docs[index].data());
                            return ResultsWidget(product: product);
                          });
                    }
                  })),
        ],
      ),
    );
  }
}
