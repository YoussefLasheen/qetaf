import 'package:flutter/material.dart';
import 'package:provider/src/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/order_dialog.dart';
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
    return cart.products.isEmpty?
    Container(): 
    AnimatedBuilder(
      animation: _controller.view,
      builder: (BuildContext context, Widget? child) {
        return Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Hero(
                    flightShuttleBuilder: (
                      BuildContext flightContext,
                      Animation<double> animation,
                      HeroFlightDirection flightDirection,
                      BuildContext fromHeroContext,
                      BuildContext toHeroContext,
                    ) {
                      return SizeTransition(
                        sizeFactor: animation,
                        child: Center(
                          child: Container(
                            height: 800,
                            width: 1500,
                            decoration: BoxDecoration(
                                color: Color(0xfff7f7fa),
                                borderRadius: BorderRadius.circular(20),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.black,
                                    blurRadius: 1,
                                  )
                                ]),
                          ),
                        ),
                      );
                    },
                    tag: 'tag',
                    //Add another material becaus eof this bug https://github.com/flutter/flutter/issues/34119
              child: Material(
                color: Colors.transparent,
                child: Container(
                  width: 300,
                  decoration: BoxDecoration(
                      color: Color(0xfff7f7fa),
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
                        product:cart.products.last
                      )),
                      ClipRect(
                        child: Align(
                          alignment: Alignment.topCenter,
                          heightFactor: _controller
                              .drive(CurveTween(curve: Curves.easeInOutCubic))
                              .value,
                          child: Container(
                            constraints: BoxConstraints(minHeight: 150),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                ProductsList(cart: cart),
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: TextButton(
                                            style: TextButton.styleFrom(
                                              padding: EdgeInsets.symmetric(
                                                  vertical: 20),
                                              elevation: 50,
                                              backgroundColor: Colors.orange,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                            ),
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                PageRouteBuilder(
                                                    opaque: false,
                                                    pageBuilder: (_, __, ___) =>
                                                        const OrderDialog()),
                                              );
                                            },
                                            child: const Text(
                                              'إتمام الشراء',
                                              style: TextStyle(
                                                  color: Colors.white),
                                            ),
                                          ),
                                        ),
                                      ),
                                      
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Text(cart
                                                .calculateTotalPrice()
                                                .toString() +
                                            ''),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
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
