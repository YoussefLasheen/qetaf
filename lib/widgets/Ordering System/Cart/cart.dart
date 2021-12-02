import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/widgets/products_list.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/widgets/toggle_cart_button.dart';

import 'models/cart_model.dart';


class Cart extends StatefulWidget {
  const Cart({
    Key? key,
  }) : super(key: key);

  @override
  State<Cart> createState() => _CartState();
}

class _CartState extends State<Cart> with SingleTickerProviderStateMixin {
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
    CartModel cart = Provider.of<CartModel>(context);
    return AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
              tag: 'tag',
              //Add another material becaus eof this bug https://github.com/flutter/flutter/issues/34119
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 250,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black,
                          blurRadius: 1,
                        )
                      ]),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      ClipRect(
                          child: ToggleCartButton(
                        isExpanded: _isExpanded,
                        toggleExpand: _toggleExpand,
                      )),
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: _controller
                              .drive(CurveTween(curve: Curves.easeInOutCubic))
                              .value,
                          child: ProductsList(cart: cart),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
