import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/cart.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/products_section/models/product.dart';

class ProductListing extends StatelessWidget {
  final ProductListingModel product;
  const ProductListing({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel cart = Provider.of<CartModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 100,
        child: Row(
          children: <Widget>[
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          'https://source.unsplash.com/user/c_v_r/1000x1000'),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListTile(
                title: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Expanded(
                      child: Row(
                        children: [
                          Expanded(
                            flex: 3,
                            child: FittedBox(
                              child: Text(
                                product.productDetails.title,
                              ),
                            ),
                          ),
                          Expanded(
                            child: FittedBox(
                              child: IconButton(
                                icon: Icon(Icons.close),
                                onPressed: () { cart.remove(product);},
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          product.productDetails.shortDescription,
                        ),
                      ),
                    ),
                    Expanded(
                      child: FittedBox(
                        child: Text(
                          product.productDetails.price.toString() +' EGP',
                          style: TextStyle(
                              color: Color(0xff9b96d6),
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(right: 5),
                        child: FittedBox(
                          child: Text(
                            product.quantity.toString(),
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}