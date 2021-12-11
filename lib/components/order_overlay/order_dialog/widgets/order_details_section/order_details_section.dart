import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';

import 'widgets/delivery_method_details.dart';
import 'widgets/payment_details.dart';
import 'widgets/shipping_details.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    OrderingProcessModel process = Provider.of<OrderingProcessModel>(context);
    return Align(
      alignment: AlignmentDirectional.topStart,
      child: ConstrainedBox(
        constraints: BoxConstraints.tightFor(width: 1200),
        child: Column(
          children: [
            ShippingDetails(process: process),
            SizedBox(
              height: 10,
            ),
            PaymentDetails(
              process: process,
            ),
            SizedBox(
              height: 10,
            ),
            DeleveryMethodDetails(process: process)
          ],
        ),
      ),
    );
  }
}






