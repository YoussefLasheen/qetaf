import 'package:flutter/material.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/Ordering%20System/widgets/products_list.dart';

class CartOverviewSection extends StatelessWidget {
  final CartModel cart;
  const CartOverviewSection({Key? key, required this.cart}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Row(
          children: [
            Text(
              "عربة التسوق ",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Text(
              '(' + cart.products.length.toString() + ' منتج' + ')',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w200,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey),
            )
          ],
        ),
        ProductsList(cart: cart),
      ],
    );
  }
}