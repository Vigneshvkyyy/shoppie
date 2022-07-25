import 'package:flutter/material.dart';
import 'package:shoppie_app/screens/account_screen.dart';
import 'package:shoppie_app/screens/home_screen.dart';
import 'package:shoppie_app/screens/more_screen.dart';

import '../model/product_model.dart';
import '../screens/card_screen.dart';
import '../widgets/simple_product_widget.dart';

const double kAppBarHeight = 80;

const String amazonLogoUrl =
    "https://www.google.com/search?q=png+images+logo&rlz=1C1ONGR_enIN1001IN1001&sxsrf=ALiCzsa9F7JCvU6vdxTu3k9k2lWw77OX_g:1657995270137&tbm=isch&source=iu&ictx=1&vet=1&fir=oe8zC4J1RX1U7M%252C-IzV5Ymhn146lM%252C_%253B4Cg8KvDP6i3H4M%252CkIZdGaFL90KalM%252C_%253BiHJtz0ChSWPtfM%252C-IzV5Ymhn146lM%252C_%253BcaPTZXb0bRC4IM%252CxCOoxBu7PidIeM%252C_%253BTJXJpGdMKpjJ5M%252CCqQ_ms5FnjpkQM%252C_%253B2KZqt3fhDVDJoM%252C4BsFu4lvn4jyRM%252C_%253BHQRkGX1dWidfZM%252CaKUcK62ufBqkOM%252C_%253BLLT87-SFDKY5eM%252C-IzV5Ymhn146lM%252C_%253BnYXuaSefFXhACM%252CG7SPZ9Tw0JiRuM%252C_%253BPI4Se9TuiGxzdM%252C-IzV5Ymhn146lM%252C_%253BSZPekYPMw5PWXM%252C-IzV5Ymhn146lM%252C_%253Bne9EFC2vozZWYM%252CCqQ_ms5FnjpkQM%252C_%253Bwx6H6rzjy2syfM%252C-IzV5Ymhn146lM%252C_%253B-D6Dyto2sdsRGM%252C-IzV5Ymhn146lM%252C_%253BXH0_ybV1Rt-RHM%252CYRhawVw_3c67KM%252C_%253BRmZeoH9yqffPQM%252C-IzV5Ymhn146lM%252C_&usg=AI4_-kTSh5Yap0CIwhZf0qHfhud1BqbUfg&sa=X&ved=2ahUKEwj-nfbYgf74AhVNArcAHfO9DIIQ9QF6BAgMEAE#imgrc=caPTZXb0bRC4IM";

const List<String> categoriesList = [
  "Prime",
  "Mobiles",
  "Fashion",
  "Electronics",
  "Home",
  "Fresh",
  "Appliances",
  "Books, Toys",
  "Essential"
];

// const List<Widget> screens = [
//   HomeScreen(),
//   AccountScreen(),
//   CartScreen(),
//   MoreScreen(),
// ];

List<Widget> screens = [
  HomeScreen(),
  AccountScreen(),
  cardScreen(),
  MoreScreen(),
];

const List<String> categoryLogos = [
  "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/116KbsvwCRL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/115yueUc1aL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11qyfRJvEbL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11BIyKooluL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11CR97WoieL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/01cPTp7SLWL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11yLyO9f9ZL._SX90_SY90_.png",
  "https://m.media-amazon.com/images/I/11M0jYc-tRL._SX90_SY90_.png",
];

const List<String> largeAds = [
  "https://m.media-amazon.com/images/I/51QISbJp5-L._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61jmYNrfVoL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/612a5cTzBiL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61fiSvze0eL._SX3000_.jpg",
  "https://m.media-amazon.com/images/I/61PzxXMH-0L._SX3000_.jpg",
];

const List<String> smallAds = [
  "https://m.media-amazon.com/images/I/11M5KkkmavL._SS70_.png",
  "https://m.media-amazon.com/images/I/11iTpTDy6TL._SS70_.png",
  "https://m.media-amazon.com/images/I/11dGLeeNRcL._SS70_.png",
  "https://m.media-amazon.com/images/I/11kOjZtNhnL._SS70_.png",
];

const List<String> adItemNames = [
  "Amazon Pay",
  "Recharge",
  "Rewards",
  "Pay Bills"
];

//Dont even attemp to scroll to the end of this manually lmao
const String shoppieLogo =
    "https://images.vexels.com/media/users/3/140868/isolated/preview/b2fe36d78c58886b7f80570d272513bd-msn-round-metal-button.png";

const String shoppieLogo2 = "https://logodix.com/logo/1229724.png";

List<Widget> testChildren = [
  SimpleProductWidget(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "choclate candy",
        cost: 10.000,
        discount: 80,
        uid: "73737838389399",
        sellerName: "robert roan",
        sellerUid: '3872731891',
        rating: 4,
        noOfRating: 12),
  ),
  SimpleProductWidget(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "choclate candy",
        cost: 10.000,
        discount: 80,
        uid: "73737838389399",
        sellerName: "robert roan",
        sellerUid: '3872731891',
        rating: 4,
        noOfRating: 12),
  ),
  SimpleProductWidget(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "choclate candy",
        cost: 10.000,
        discount: 80,
        uid: "73737838389399",
        sellerName: "robert roan",
        sellerUid: '3872731891',
        rating: 4,
        noOfRating: 12),
  ),
  SimpleProductWidget(
    productModel: ProductModel(
        url: "https://m.media-amazon.com/images/I/11uufjN3lYL._SX90_SY90_.png",
        productName: "choclate candy",
        cost: 10.000,
        discount: 80,
        uid: "73737838389399",
        sellerName: "robert roan",
        sellerUid: '3872731891',
        rating: 4,
        noOfRating: 12),
  ),
];

List<String> keyOfRating = ["Very bad", "Poor", "Average", "Good", "Excellent"];
