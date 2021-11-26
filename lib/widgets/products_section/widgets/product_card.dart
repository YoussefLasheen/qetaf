import 'package:flutter/material.dart';
import 'package:qetaf/widgets/products_section/models/product.dart';

class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 250,
          width: 250,
          child: Placeholder(),
        ),
        Text(
          product.title,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
        ),
        Text(
          product.price.toString()+' EGP',
          style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 15,
              color: Colors.amber),
        ),
        Text(
          product.shortDescription,
          style: const TextStyle(
              fontWeight: FontWeight.w300, fontSize: 15, color: Colors.black38),
        ),
      ],
    );
  }
}
