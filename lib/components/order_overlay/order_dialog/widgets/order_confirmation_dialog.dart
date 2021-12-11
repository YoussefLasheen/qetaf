import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';

class OrderConfirmationDialog extends StatefulWidget {
  final OrderingProcessModel process;
  OrderConfirmationDialog({Key? key, required this.process,}) : super(key: key);

  @override
  _OrderConfirmationDialogState createState() =>
      _OrderConfirmationDialogState();
}

class _OrderConfirmationDialogState extends State<OrderConfirmationDialog> {
  bool _loading = true;
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 500), () {
      _loading = false;
      setState(() {});
    });
    return Card(
      child: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Success",),
                    Icon(Icons.done_rounded,color: Colors.green,),
                  ],
                ),
                Text('Order Number: 1153364788'),
                Spacer(),
                TextButton(onPressed: (){
                      Navigator.pop(context);
                      widget.process.reset();
                    }, child: Text('Close'))
              ],
            ),
          ),
    );
  }
}