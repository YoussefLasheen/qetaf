import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import 'home_page.dart';
import 'widgets/Ordering System/Cart/models/cart_model.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CartModel(products: []),
      child: MaterialApp(
        theme: ThemeData(
          textTheme: GoogleFonts.cairoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: const HomePage(),
      ),
    );
  }
}
