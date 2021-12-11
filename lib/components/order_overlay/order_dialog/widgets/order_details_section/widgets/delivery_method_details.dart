import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';

class DeleveryMethodDetails extends StatelessWidget {
  final OrderingProcessModel process;
  const DeleveryMethodDetails({Key? key, required this.process})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            'التوصيل',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black),
          ),
        ),
        Row(
          children: [
            deliveryCard(deliveryMethodEnum.fedex, process),
            deliveryCard(deliveryMethodEnum.pickup, process),
          ],
        ),
      ],
    );
  }

  Widget deliveryCard(
    deliveryMethodEnum deliveryMethod,
    OrderingProcessModel process,
  ) {
    bool _isSelected = process.deliveryMethod == deliveryMethod;
    return Expanded(
      child: Card(
        color: _isSelected ? Colors.orange : Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: InkWell(
          onTap: () => process.switchDeliveryMethod(deliveryMethod),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  deliveryMethodEnumDetails.getValue(deliveryMethod)['name'],
                  style: TextStyle(
                      fontWeight:
                          _isSelected ? FontWeight.bold : FontWeight.normal,
                      color: _isSelected ? Colors.white : Colors.black),
                ),
                Icon(deliveryMethodEnumDetails.getValue(deliveryMethod)['icon'],
                    size: 30, color: _isSelected ? Colors.white : Colors.black),
                SizedBox(
                  height: 6,
                ),
                Text(
                  deliveryMethodEnumDetails
                      .getValue(deliveryMethod)['estimatedDeliveryTime'],
                  style: TextStyle(
                      color: _isSelected ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}