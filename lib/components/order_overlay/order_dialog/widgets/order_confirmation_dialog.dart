import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/side_panel.dart';

import 'package:qetaf/components/order_tracker_overlay/models/order_model.dart';
import 'package:qetaf/services/api.dart';

class OrderConfirmationDialog extends StatefulWidget {
  final OrderingProcessModel process;
  OrderConfirmationDialog({
    Key? key,
    required this.process,
  }) : super(key: key);

  @override
  _OrderConfirmationDialogState createState() =>
      _OrderConfirmationDialogState();
}

class _OrderConfirmationDialogState extends State<OrderConfirmationDialog> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'orderconfirmationdialog',
      child: Container(
        color: Colors.black12,
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints.expand(width: 300, height: 300),
            child: Card(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                child: FutureBuilder<String>(
              future: addOrder(widget.process),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.done_rounded, color: Colors.green,),
                            SelectableText('order No. #'+snapshot.data!, style: TextStyle(color: Colors.green),),
                          ],
                        ),
                        IconButton(onPressed: (){
                          Navigator.popUntil(context, (Route<dynamic> route) => route.isFirst);
                          widget.process.reset();
                        }, icon: Icon(Icons.close_rounded))
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Column(
                    children: [
                      Text('Something went wrong, please try again later'),
                      IconButton(onPressed: ()=> Navigator.pop(context), icon: Icon(Icons.close_rounded))
                    ],
                  );
                }

                // By default, show a loading spinner.
                return const CircularProgressIndicator();
              },
            )),
          ),
        ),
      ),
    );
  }
}

Future<String> addOrder(OrderingProcessModel order) async {
  final orderId = DateTime.now().microsecondsSinceEpoch.toString().substring(3,12);
  final response = await Api('Orders').updateDocument({
    'date': DateTime.now(),
    'deliveryMethod': order.deliveryMethod.name,
    'paymentMethod': order.paymentMethod.name,
    'status': orderStatusEnum.processing.name,
    'address': {
      'address': order.shippingAddress.address,
      'name': order.shippingAddress.fullName,
      'phone': order.shippingAddress.phoneNo,
    },
    'cart': [
      for (var product in order.cart.products)
        {
          'id': product.productDetails.id,
          'title': product.productDetails.title,
          'shortDescription': product.productDetails.shortDescription,
          'imageSource': product.productDetails.imageSource,
          'price': product.productDetails.price,
        }
    ]
  }, orderId).then((value) {
    return orderId;
  }).catchError((error) {
    return error.toString();
  });
  return response;
}
