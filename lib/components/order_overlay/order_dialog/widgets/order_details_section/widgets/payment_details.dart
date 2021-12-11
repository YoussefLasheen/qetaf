import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';

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
                fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black),
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
                                paymentMethodEnumDetails
                        .getValue(process.paymentMethod)['name']
                        .toString(),
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
                        ],
                      )
                    : Container(),
                ClipRect(
                  child: Align(
                    heightFactor: _currentlyEditing ? 1 : 0,
                    child: Row(
                      children: [
                        _buildPaymentMethodCard(paymentMethodEnum.COD, process),
                        _buildPaymentMethodCard(
                            paymentMethodEnum.CARD, process),
                      ],
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

  Widget _buildPaymentMethodCard(
    paymentMethodEnum paymentMethod,
    OrderingProcessModel process,
  ) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: InkWell(
        onTap: paymentMethodEnumDetails.getValue(paymentMethod)['isAvailble']
            ? () {
                process.switchPaymentMethod(paymentMethod);
                process.switchStatus(statusEnum.onCompleteProductDetailsSection);
              }
            : null,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(minWidth: 100),
            child: Column(
              children: [
                Text(
                  paymentMethodEnumDetails.getValue(paymentMethod)['name'],
                  style: TextStyle(
                      fontWeight: FontWeight.normal,
                      color:Colors.black),
                ),
                Icon(paymentMethodEnumDetails.getValue(paymentMethod)['icon'],
                    size: 30, color: Colors.black),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '+' +
                      paymentMethodEnumDetails
                          .getValue(paymentMethod)['price']
                          .toString(),
                  style:
                      TextStyle(color:Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}