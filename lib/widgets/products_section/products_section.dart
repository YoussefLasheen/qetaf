import 'dart:ui';

import 'package:expand_widget/expand_widget.dart';
import 'package:flutter/material.dart';
import 'widgets/product_card.dart';

import 'models/product.dart';

class ProductsSection extends StatelessWidget {
  const ProductsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

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
                "عسل نحل طبيعي ١٠٠٪ من مزارعنا في الغربية",
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
                      ...List.generate(3, (index) {
                        return ProductCard(
                            product: demoProducts[index]);
                      }),
                    ],
                  ),
                  ExpandChild(
                    child: Wrap(
                      spacing: 100,
                      textDirection: TextDirection.rtl,
                      children: [
                        ...List.generate(demoProducts.length -3, (index) {
                        return ProductCard(
                            product: demoProducts.sublist(3, demoProducts.length)[index]);
                      }),
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
