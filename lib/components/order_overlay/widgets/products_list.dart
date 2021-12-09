import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/cart/models/cart_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/order_dialog.dart';

import 'product_listing.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        cart.products.isEmpty
            ? const Center(child: Text("Wow so empty"))
            : Container(),
        for (var product in cart.products) ProductListing(product: product,),
      ],
    );
  }
}