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
      child: Container(
        color: Colors.white,
        height: 100,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: <Widget>[
              AspectRatio(
                aspectRatio: 1,
                child: Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                          product.productDetails.imageSource),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      product.productDetails.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16
                      ),
                    ),
                    Text(
                      product.productDetails.shortDescription,
                      style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                        color: Colors.grey
                      ),
                    ),
                  ],
                ),
              Spacer(),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.close),
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                      cart.remove(product);
                    },
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
            ],
          ),
        ),
      ),
    );
  }
}