import 'package:flutter/material.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/order_dialog.dart';

import 'product_listing.dart';

class ProductsList extends StatelessWidget {
  const ProductsList({
    Key? key,
    required this.cart,
  }) : super(key: key);

  final CartModel cart;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minHeight: 150),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          cart.products.isEmpty
              ? const Center(child: Text("Wow so empty"))
              : Container(),
          for (var product in cart.products) ProductListing(product: product,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(cart.calculateTotalPrice().toString() + ''),
                SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 20),
                          elevation: 50,
                          backgroundColor: Colors.orange,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            PageRouteBuilder(
                                opaque: false,
                                pageBuilder: (_, __, ___) =>
                                    const OrderDialog()),
                          );
                        },
                        child: const Text(
                          "Order",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}