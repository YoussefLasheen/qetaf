import 'dart:ui';

import 'package:flutter/material.dart';
import 'widgets/product_card.dart';

import 'models/product.dart';

class ProductsSection extends StatefulWidget {
  const ProductsSection({Key? key}) : super(key: key);

  @override
  State<ProductsSection> createState() => _ProductsSectionState();
}

class _ProductsSectionState extends State<ProductsSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: Duration(milliseconds: 300),
      vsync: this,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _toggleExpand() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded ? _controller.forward() : _controller.reverse();
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: _controller.view,
        builder: (BuildContext context, Widget? child) {
          return Column(
            children: [
              const SizedBox(height: 90,),
              Column(
                children: [
                  const Text(
                    "منـــتجاتنا",
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "عسل نحل طبيعي ١٠٠٪ من مزارعنا في الغربية",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.black38),
                  ),
                ],
              ),
              const SizedBox(height: 100,),
              ClipRect(
                child: Align(
                  heightFactor: (_controller
                      .drive(CurveTween(curve: Curves.fastOutSlowIn))
                      .value+0.5).clamp(0.5, 1),
                  alignment: AlignmentDirectional.topCenter,
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: 1200),
                    child: Wrap(
                      spacing: 100,
                      children: [
                        ...List.generate(demoProducts.length, (index) {
                          return ProductCard(product: demoProducts[index]);
                        }),
                      ],
                    ),
                  ),
                ),
              ),
              IconButton(
                icon: _isExpanded? Icon(Icons.keyboard_arrow_up_rounded):Icon(Icons.keyboard_arrow_down_rounded),
                onPressed: () => _toggleExpand(),
              )
            ],
          );
        });
  }
}
