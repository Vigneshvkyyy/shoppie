import 'package:flutter/material.dart';

import 'package:shoppie_app/model/user_model.dart';
import 'package:shoppie_app/resources/cloud_firestore_methods.dart';
import 'package:shoppie_app/utils/constants.dart';
import 'package:shoppie_app/utils/utils.dart';
import 'package:shoppie_app/widgets/banner_ad_widget.dart';
import 'package:shoppie_app/widgets/categories_list_bar.dart';
import 'package:shoppie_app/widgets/loading_widget.dart';
import 'package:shoppie_app/widgets/product_showcase_listview.dart';
import 'package:shoppie_app/widgets/search_bar_widget.dart';
import 'package:shoppie_app/widgets/simple_product_widget.dart';
import 'package:shoppie_app/widgets/user_detail_bar.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ScrollController controller = ScrollController();
  double offset = 0;

  List<Widget>? discount70;
  List<Widget>? discount60;
  List<Widget>? discount50;
  List<Widget>? discount0;

  @override
  void initState() {
    super.initState();
    getData();
    controller.addListener(() {
      setState(() {
        offset = controller.position.pixels;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    controller.dispose();
  }

  void getData() async {
    List<Widget> temp70 =
        await CloudFirestoreClass().getProductsFromDiscount(70);
    List<Widget> temp60 =
        await CloudFirestoreClass().getProductsFromDiscount(60);
    List<Widget> temp50 =
        await CloudFirestoreClass().getProductsFromDiscount(50);
    List<Widget> temp0 = await CloudFirestoreClass().getProductsFromDiscount(0);

    setState(() {
      discount70 = temp70;
      discount60 = temp60;
      discount50 = temp50;
      discount0 = temp0;
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: SearchBarWidget(
        isReadOnly: true,
        hasBackButton: false,
      ),

      body: discount70 != null &&
              discount60 != null &&
              discount50 != null &&
              discount0 != null
          ? Stack(
              children: [
                SingleChildScrollView(
                  controller: controller,
                  child: Column(
                    children: [
                      SizedBox(
                        height: kAppBarHeight / 2,
                      ),
                      CategoriesListBar(),
                      BannerWidget(),
                      ProductShowcase(
                          title: "Upto 70% Off", children: discount70!),
                      ProductShowcase(
                          title: "Upto 60% Off", children: discount60!),
                      ProductShowcase(
                          title: "Upto 50% Off", children: discount50!),
                      ProductShowcase(
                        title: "Explore",
                        children: discount0!,
                      ),
                    ],
                  ),
                ),
                UserDetailBar(
                  offset: offset,
                ),
              ],
            )
          : LoadingWidget(),

      // drawer functionality
    );
  }
}
