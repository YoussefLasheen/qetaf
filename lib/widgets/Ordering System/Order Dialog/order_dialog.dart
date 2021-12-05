import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/models/ordering_process_model.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/widgets/cart_overview_section.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/widgets/order_details_section.dart';

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
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ConstrainedBox(
                        constraints:
                            BoxConstraints(maxWidth: 500, maxHeight: 800),
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
                      SizedBox(
                        width: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ConstrainedBox(
                            constraints:
                                BoxConstraints(maxWidth: 300, maxHeight: 300),
                            child: SidePanel(controller: controller)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SidePanel extends StatelessWidget {
  const SidePanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    OrderingProcessModel process = Provider.of<OrderingProcessModel>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Flexible(
                child: Column(
                  children: [
                    _buildPriceTile('المجموع الجزئي',
                        process.cart.calculateTotalPrice().toString(), true),
                    _buildPriceTile(
                        'الشحن',
                        deliveryMethodEnumDetails
                            .getValue(process.deliveryMethod)['price']
                            .toString(),
                        process.status != statusEnum.editingAddress &&
                            process.status != statusEnum.onProductsSection),
                    _buildPriceTile(
                        'الدفع عند الإستلام',
                        '10',
                        process.status != statusEnum.editingAddress &&
                            process.status != statusEnum.onProductsSection),
                    Divider(
                      height: 2,
                      color: Colors.black12,
                    ),
                    process.status != statusEnum.editingAddress &&
                            process.status != statusEnum.onProductsSection
                        ? Flexible(
                            child: Row(
                              mainAxisSize: MainAxisSize.max,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      'المجموع الكلي',
                                      style: TextStyle(fontSize: 20),
                                    ),
                                  ),
                                ),
                                Flexible(
                                  child: FittedBox(
                                    child: Text(
                                      process.calculateTotalPrice().toString() +
                                          ' جنيه',
                                      style: TextStyle(fontSize: 15),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          )
                        : Container()
                  ],
                ),
              ),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 50,
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () => _forwardButtonFunction(process),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'تابع الشراء',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.white),
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
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () => _backwardButtonFunction(process),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'الرجوع',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
  }

  Widget _buildPriceTile(String title, String price, bool isShown) {
    return isShown
        ? Flexible(
            child: Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                    child: FittedBox(
                        child: Text(
                  title,
                  style: TextStyle(fontSize: 15),
                ))),
                Flexible(
                  child: FittedBox(
                    child: Text(
                      price + ' جنيه',
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }

  void _backwardButtonFunction(OrderingProcessModel process) {
    switch (process.status) {
      default:
        {
          controller.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          process.switchStatus(statusEnum.onProductsSection);
        }
    }
  }

  void _forwardButtonFunction(OrderingProcessModel process) {
    switch (process.status) {
      case statusEnum.onProductsSection:
        {
          controller.animateToPage(1,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          process.switchStatus(statusEnum.editingAddress);
        }
        break;
      case statusEnum.onCompleteProductDetailsSection:
        {
          null;
        }
        break;
      default:
        {
          null;
        }
    }
  }
}
