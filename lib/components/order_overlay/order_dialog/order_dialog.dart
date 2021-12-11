import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/components/order_overlay/cart/models/cart_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/cart_overview_section.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/navigation_buttons.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/order_details_section/order_details_section.dart';

import 'widgets/order_confirmation_dialog.dart';
import 'widgets/side_panel.dart';

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
                child: Consumer<OrderingProcessModel>(
                  builder: (_,process,___) {
                    return Padding(
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
                                    BoxConstraints(maxWidth: 300, minHeight: 125),
                                child: Card(
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  child: Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        SidePanel(process: process,),
                                        SizedBox(height: 20,),
                                        NavigationButtons(controller: controller, process: process,)
                                      ],
                                    ),
                                  ),
                                )),
                          ),
                        ],
                      ),
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}


