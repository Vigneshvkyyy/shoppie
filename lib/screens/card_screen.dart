import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppie_app/model/product_model.dart';
import 'package:shoppie_app/model/user_model.dart';
import 'package:shoppie_app/provider/user_detail_provider.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';
import 'package:shoppie_app/utils/color_themes.dart';
import 'package:shoppie_app/utils/constants.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/cart_item_widget.dart';
import 'package:shoppie_app/widgets/custom_main_button.dart';
import 'package:shoppie_app/widgets/search_bar_widget.dart';
import 'package:shoppie_app/widgets/user_detail_bar.dart';

class cardScreen extends StatelessWidget {
  const cardScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        hasBackButton: false,
        isReadOnly: true,
      ),
      body: Center(
        child: Stack(
          children: [
            Column(
              children: [
                SizedBox(
                  height: kAppBarHeight / 2,
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: StreamBuilder(
                    stream: FirebaseFirestore.instance
                        .collection("users")
                        .doc(FirebaseAuth.instance.currentUser!.uid)
                        .collection("card")
                        .snapshots(),
                    builder: (context,
                        AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                            snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return CustomMainButton(
                          child: Text('Loading'),
                          color: yellowColor,
                          isLoading: true,
                          onPressed: () {},
                        );
                      } else {
                        return CustomMainButton(
                          child: Text(
                            'Proceed to (${snapshot.data!.docs.length}) items',
                            style: TextStyle(color: Colors.black),
                          ),
                          color: yellowColor,
                          isLoading: false,
                          onPressed: () async {
                            await CloudFirestoreClass().buyAllItemInCard(
                                userDetails: Provider.of<UserDetailsProvider>(
                                        context,
                                        listen: false)
                                    .userDetails);
                            Utils().showSnackBar(
                                context: context, content: "Done");
                          },
                        );
                      }
                    },
                  ),
                ),
                Expanded(
                    child: StreamBuilder(
                        stream: FirebaseFirestore.instance
                            .collection("users")
                            .doc(FirebaseAuth.instance.currentUser!.uid)
                            .collection("card")
                            .snapshots(),
                        builder: (context,
                            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                                snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return Container();
                          } else {
                            return ListView.builder(
                                itemCount: snapshot.data!.docs.length,
                                itemBuilder: (context, index) {
                                  ProductModel model =
                                      ProductModel.getModelFromJson(
                                          json: snapshot.data!.docs[index]
                                              .data());
                                  return CartItemWidget(product: model);
                                });
                          }
                        })),
              ],
            ),
            UserDetailBar(
              offset: 0,
            ),
          ],
        ),
      ),
    );
  }
}
