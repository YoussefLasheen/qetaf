import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';

class SidePanel extends StatelessWidget {
  final OrderingProcessModel process;
  const SidePanel({
    Key? key, required this.process,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildPriceTile(
                    'المجموع الجزئي',
                    process.cart.calculateTotalPrice().toString() + ' جنيه',
                    true),
                _buildPriceTile(
                    'الشحن',
                    deliveryMethodEnumDetails.getValue(
                                process.deliveryMethod)['price'] ==
                            0
                        ? 'مجاني'
                        : deliveryMethodEnumDetails
                                .getValue(process.deliveryMethod)['price']
                                .toString() +
                            ' جنيه',
                    process.status != statusEnum.editingAddress &&
                        process.status != statusEnum.onProductsSection),
                _buildPriceTile(
                    'الدفع عند الإستلام',
                    '10' + ' جنيه',
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
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Flexible(
                              child: FittedBox(
                                child: Text(
                                  process.calculateTotalPrice().toString() +
                                      ' جنيه',
                                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
          Visibility(
            visible: !process.addressNotAssigned() && process.status == statusEnum.onCompleteProductDetailsSection,
            replacement: SizedBox.shrink(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'الشحن الي',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
            Text(process.shippingAddress.fullName.toString()),
            Text(process.shippingAddress.address.toString()),
            Text(process.shippingAddress.phoneNo.toString())
              ],
            ),
          ),
          Visibility(
            visible: process.status == statusEnum.onCompleteProductDetailsSection,
            replacement: SizedBox.shrink(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'الدفع',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
            Text('عن طريق ' + paymentMethodEnumDetails.getValue(
                                process.paymentMethod)['name']),
              ],
            ),
          ),
          Visibility(
            visible: process.status == statusEnum.onCompleteProductDetailsSection,
            replacement: SizedBox.shrink(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
                  child: Divider(
                    height: 2,
                    color: Colors.black54,
                  ),
                ),
                Text(
                  'التوصيل',
                  style:
                      TextStyle(fontSize: 12, fontWeight: FontWeight.w700),
                ),
                Text('عن طريق ' +
                    deliveryMethodEnumDetails
                        .getValue(process.deliveryMethod)['name']),
              ],
            ),
          ),
        ]);
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
                      price,
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}