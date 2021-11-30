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
        'price': 50,
        'id':'1'
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 65,
        'id':'2'
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 70,
        'id':'3'
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 77,
        'id':'4'
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 77,
        'id':'5'
      },
      {
        'title': 'عسل',
        'shortDescription': 'عسل عسل عسل عسل عسل عسل',
        'imageSource': '',
        'price': 77,
        'id':'6'
      }
    ];
    return Row(
      children: [
        const Spacer(),
        Expanded(
          flex: 4,
          child: Column(
            children: [
              const SizedBox(height: 100,),
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
                  const SizedBox(height: 100,),
                  Wrap(
                    spacing: 100,
                    textDirection: TextDirection.rtl,
                    children: [
                      for (Map product in dummyProducts.sublist(0,3))
                        ProductCard(
                          product: ProductDetails(
                                id: product['id'],
                                title: product['title'],
                              shortDescription: product['shortDescription'],
                              imageSource: product['imageSource'],
                              price: product['price'],
                              tags: [],
                              ),
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
                            product: ProductDetails(
                                title: product['title'],
                                shortDescription: product['shortDescription'],
                                imageSource: product['imageSource'],
                                price: product['price'],
                                tags: [],
                                id: product['id']),
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
