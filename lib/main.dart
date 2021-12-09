import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/components/order_overlay/order_dialog/order_dialog.dart';

import 'home_page.dart';
import 'components/order_overlay/cart/models/cart_model.dart';

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
        title: 'Qetaf Honey Farms',
        theme: ThemeData(
          textTheme: GoogleFonts.cairoTextTheme(
            Theme.of(context).textTheme,
          ),
        ),
        home: Directionality(
            textDirection: TextDirection.rtl, child: const HomePage()),
      ),
    );
  }
}
