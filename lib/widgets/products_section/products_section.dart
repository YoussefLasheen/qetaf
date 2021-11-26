import 'dart:ui';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/product_card.dart';

import 'models/product.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List dummyProducts = [
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 15,
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 15,
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 15,
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 15,
      }
    ];
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              SizedBox(height: 100,),
              const Text(
                "منـــتجاتنا",
                style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
              ),
              const Text(
                "عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل عسل",
                style: TextStyle(
                    fontWeight: FontWeight.w300, color: Colors.black38),
              ),
              Column(
                children: [
                  SizedBox(height: 100,),
                  Wrap(
                    spacing: 100,
                    textDirection: TextDirection.rtl,
                    children: [
                      for (Map product in dummyProducts.sublist(0,3))
                        ProductCard(
                          product: Product(
                              title: product['title'],
                              shortDescription: product['shortDescription'],
                              imageSource: product['imageSource'],
                              price: product['price'],
                              tags: [],
                              id: ''),
                        )
                    ],
                  ),
                  ExpandChild(
                    child: Wrap(
                      spacing: 100,
                      textDirection: TextDirection.rtl,
                      children: [
                        for (Map product in dummyProducts.sublist(3,dummyProducts.length))
                          ProductCard(
                            product: Product(
                                title: product['title'],
                                shortDescription: product['shortDescription'],
                                imageSource: product['imageSource'],
                                price: product['price'],
                                tags: [],
                                id: ''),
                          )
                      ],
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
        const Spacer()
      ],
    );
  }
}
