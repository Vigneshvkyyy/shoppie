import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppie_app/layout/screen_layout.dart';
import 'package:shoppie_app/provider/user_detail_provider.dart';
import 'package:shoppie_app/screens/home_screen.dart';
import 'package:shoppie_app/screens/product_screen.dart';
import 'package:shoppie_app/screens/resulte_screen.dart';
import 'package:shoppie_app/screens/sell_screen.dart';
import 'package:shoppie_app/utils/color_themes.dart';

import 'model/product_model.dart';
import 'screens/signin_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyDcOlkMDljJ81AzOmRY0V3VO_aVe8xQdv0",
          authDomain: "shoppie-80570.firebaseapp.com",
          projectId: "shoppie-80570",
          storageBucket: "shoppie-80570.appspot.com",
          messagingSenderId: "638590520741",
          appId: "1:638590520741:web:cc35f52c06bf1ecb496c4c"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(ShoppieApp());
}

class ShoppieApp extends StatelessWidget {
  const ShoppieApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UserDetailsProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData.light().copyWith(
          scaffoldBackgroundColor: backgroundColor,
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, AsyncSnapshot<User?> user) {
            if (user.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(color: Colors.orange),
              );
            } else if (user.hasData) {
              return ScreenLayout();
            } else {
              return SigninScreen();
            }
          },
        ),
      ),
    );
  }
}
