import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/Ordering%20System/widgets/product_listing.dart';
import 'package:qetaf/widgets/Ordering%20System/widgets/products_list.dart';
import 'package:qetaf/widgets/products_section/models/product.dart';


class OrderDialog extends StatelessWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel cart = Provider.of<CartModel>(context);
    PageController controller = PageController();
    return Hero(
      tag: 'tag',
      child: ChangeNotifierProvider(
        create: (_) => OrderingProcessModel(cart: cart),
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(width: 1500, height: 800),
            child: Material(
              color: Color(0xfff7f7fa),
              elevation: 20,
              borderRadius: BorderRadius.circular(20),
              shadowColor: Colors.black,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(minWidth: 1500, minHeight: 800),
                          child: PageView(
                            pageSnapping: true,
                            scrollDirection: Axis.vertical,
                            physics: const NeverScrollableScrollPhysics(),
                            controller: controller,
                            children: [
                              CartOverviewSection(cart: cart),
                              OrderDetailsSection()
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        child: SidePanel(controller: controller),
                      ),
                    ],
                  ),
                ),
              ),
            ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ConstrainedBox(
                          constraints:
                              BoxConstraints(maxHeight: 100, maxWidth: 50),
                          child: Container(
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey)),
                            padding: EdgeInsets.all(10),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Expanded(
                                    child: Row(
                                      children: [
                                        Expanded(child: Text('المجموع')),
                                        Expanded(
                                            child: Text(cart
                                                    .calculateTotalPrice()
                                                    .toString() +
                                                ' جنيه')),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.stretch,
                                      children: [
                                        ElevatedButton(
                                          style: ElevatedButton.styleFrom(
                                            elevation: 50,
                                            primary: Colors.black,
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                          onPressed: () {},
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Text(
                                                'تابع الشراء',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white),
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        OutlinedButton(
                                          style: OutlinedButton.styleFrom(
                                            side: const BorderSide(
                                              color: Colors.black,
                                              style: BorderStyle.solid,
                                            ),
                                            shape: RoundedRectangleBorder(
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                          ),
                                          onPressed: () {
                                            Navigator.pop(context);
                                          },
                                          child: const Padding(
                                            padding: EdgeInsets.all(8.0),
                                            child: FittedBox(
                                              child: Text(
                                                'الرجوع للموقع',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.black),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ]),
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
      ),
    );
  }
}
