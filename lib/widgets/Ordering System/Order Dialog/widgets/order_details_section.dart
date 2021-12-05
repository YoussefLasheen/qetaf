import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/models/ordering_process_model.dart';

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

class ShippingDetails extends StatelessWidget {
  final OrderingProcessModel process;
  const ShippingDetails({Key? key, required this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _currentlyEditing = process.status == statusEnum.editingAddress;
    return Column(
      children: [
        const Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            'العنوان',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                !_currentlyEditing
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'سلمي أحمد',
                              ),
                              FlatButton(
                                onPressed: () => process
                                    .switchStatus(statusEnum.editingAddress),
                                child: Text(
                                  'تغيير',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                          Text("7 شارع جمال عبد الناصر متفرع من السلام"),
                        ],
                      )
                    : Container(),
                ClipRect(
                  child: Align(
                    heightFactor: _currentlyEditing ? 1 : 0,
                    child: TextButton(
                      onPressed: () {
                        process.switchStatus(statusEnum.editingPaymentOptions);
                      },
                      child: Text(
                        "تأكيد العنوان",
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class PaymentDetails extends StatelessWidget {
  final OrderingProcessModel process;

  const PaymentDetails({Key? key, required this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    bool _currentlyEditing = process.status == statusEnum.editingPaymentOptions;
    return Column(
      children: [
        const Align(
          alignment: AlignmentDirectional.topStart,
          child: Text(
            'طرق الدفع',
            style: TextStyle(
                fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                !_currentlyEditing
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Jane Doe',
                              ),
                              FlatButton(
                                onPressed: () => process.switchStatus(
                                    statusEnum.editingPaymentOptions),
                                child: Text(
                                  'تغيير',
                                  style: TextStyle(color: Colors.orange),
                                ),
                              ),
                            ],
                          ),
                          Text(
                            "الدفع عند الإستلام",
                          ),
                        ],
                      )
                    : Container(),
                ClipRect(
                  child: Align(
                    heightFactor: _currentlyEditing ? 1 : 0,
                    child: TextButton(
                      onPressed: () {
                        process.switchStatus(
                            statusEnum.onCompleteProductDetailsSection);
                      },
                      child: Text("تأكيد طريقة الدفع",
                          style: TextStyle(color: Colors.black)),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

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
                fontWeight: FontWeight.w900, fontSize: 12, color: Colors.black),
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
