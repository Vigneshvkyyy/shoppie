import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppie_app/model/order_request_model.dart';
import 'package:shoppie_app/model/product_model.dart';
import 'package:shoppie_app/model/user_model.dart';
import 'package:shoppie_app/screens/sell_screen.dart';
import 'package:shoppie_app/utils/constants.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/account_screen_appbar.dart';
import 'package:shoppie_app/widgets/custom_main_button.dart';
import 'package:shoppie_app/widgets/product_showcase_listview.dart';
import 'package:shoppie_app/widgets/simple_product_widget.dart';

import '../provider/user_detail_provider.dart';
import '../utils/color_themes.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    Size screenSize = Utils().getScreenSize();
    return Scaffold(
      appBar: AccountScreenAppbar(),
      body: SingleChildScrollView(
        child: SizedBox(
          height: screenSize.height,
          width: screenSize.width,
          child: Column(
            children: [
              introductionWidgetAccountScreen(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                    child: Text('Sign In'),
                    color: Colors.blue,
                    isLoading: false,
                    onPressed: () {
                      FirebaseAuth.instance.signOut();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: CustomMainButton(
                    child: Text('Sell'),
                    color: Colors.green,
                    isLoading: false,
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SellScreen()));
                    }),
              ),
              FutureBuilder(
                  future: FirebaseFirestore.instance
                      .collection("users")
                      .doc(FirebaseAuth.instance.currentUser!.uid)
                      .collection("orders")
                      .get(),
                  builder: (context,
                      AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                          snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Container();
                    } else {
                      List<Widget> children = [];
                      for (int i = 0; i < snapshot.data!.docs.length; i++) {
                        ProductModel model = ProductModel.getModelFromJson(
                            json: snapshot.data!.docs[i].data());
                        children.add(SimpleProductWidget(productModel: model));
                      }
                      return ProductShowcase(
                          title: "Your Orders", children: children);
                    }
                  }),
              Padding(
                padding: const EdgeInsets.all(15),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Order requests",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              Expanded(
                  child: StreamBuilder(
                stream: FirebaseFirestore.instance
                    .collection("users")
                    .doc(FirebaseAuth.instance.currentUser!.uid)
                    .collection("orderRequests")
                    .snapshots(),
                builder: (context,
                    AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>>
                        snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Container();
                  } else {
                    return ListView.builder(
                        itemCount: snapshot.data!.docs.length,
                        itemBuilder: ((context, index) {
                          OrderRequestModel model =
                              OrderRequestModel.getModelFromJson(
                                  json: snapshot.data!.docs[index].data());
                          return ListTile(
                            title: Text(
                              'Order: ${model.orderName}',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text("Address: ${model.buyersAddress}"),
                            trailing: IconButton(
                              onPressed: () async {
                                FirebaseFirestore.instance
                                    .collection("users")
                                    .doc(FirebaseAuth.instance.currentUser!.uid)
                                    .collection("orderRequests")
                                    .doc(snapshot.data!.docs[index].id)
                                    .delete();
                              },
                              icon: Icon(Icons.check),
                            ),
                          );
                        }));
                  }
                },
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class introductionWidgetAccountScreen extends StatelessWidget {
  const introductionWidgetAccountScreen({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    userDetailModel userDetailsModel =
        Provider.of<UserDetailsProvider>(context).userDetails;
    return Container(
      height: kAppBarHeight / 2,
      decoration: BoxDecoration(
        gradient: LinearGradient(
            colors: backgroundGradient,
            begin: Alignment.centerLeft,
            end: Alignment.centerRight),
      ),
      child: Container(
        height: kAppBarHeight / 2,
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [Colors.white, Colors.white.withOpacity(0.00000001)],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 17),
              child: RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Hello, ",
                      style: TextStyle(color: Colors.grey[800], fontSize: 27),
                    ),
                    TextSpan(
                      text: "${userDetailsModel.name}",
                      style: TextStyle(
                          color: Colors.grey[800],
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png"),
              ),
            )
          ],
        ),
      ),
    );
  }
}
