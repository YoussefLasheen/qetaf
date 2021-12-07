import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/products_section/models/product.dart';

class ProductCard extends StatelessWidget {
  final ProductDetails product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel cart = Provider.of<CartModel>(context);
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: 300,
        maxHeight: 400
      ),
      child: Column(
        children: [
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset(product.imageSource),
          ),
          Text(
            product.title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                product.price.toString()+' EGP',
                style: const TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15,),
              ),
              IconButton(
                icon: Icon(Icons.shopping_cart),
                onPressed: () {
                  cart.add(product);
                },
              )
            ],
          ),
          Text(
            product.shortDescription,
            style: const TextStyle(
                fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black38),
          ),
        ],
      ),
    );
  }
}
