import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/shippingaddress_model.dart';

import 'shipping_address_form.dart';

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
                fontWeight: FontWeight.w900, fontSize: 18, color: Colors.black),
          ),
        ),
        Card(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: IndexedStack(
              index: (process.addressNotAssigned() && !_currentlyEditing) ||
                      (!process.addressNotAssigned() && _currentlyEditing)
                  ? 0
                  : 1,
              children: [
                Positioned.fill(
                  child: TextButton(
                    style: TextButton.styleFrom(
                      primary: Colors.orange,
                    ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("أضف عنوان جديد"),
                          Icon(Icons.add_business_rounded),
                        ],
                      ),
                      onPressed: () {
                        process.switchAddress(ShippingAddressModel.notAssigned());
                        process.switchStatus(statusEnum.editingAddress);
                      }
                      ),
                ),
                Column(
                  children: [
                    !_currentlyEditing
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    process.shippingAddress.fullName,
                                  ),
                                  FlatButton(
                                    onPressed: () {
                                      process.switchStatus(
                                          statusEnum.editingAddress);
                                      process.switchAddress(ShippingAddressModel.notAssigned());
                                    },
                                    child: Text(
                                      'تغيير',
                                      style: TextStyle(color: Colors.orange),
                                    ),
                                  ),
                                ],
                              ),
                              Text(process.shippingAddress.address),
                              Text(process.shippingAddress.phoneNo),
                            ],
                          )
                        : Container(),
                    ClipRect(
                      child: Align(
                        heightFactor: _currentlyEditing ? 1 : 0,
                        child: ShippingAddressForm(
                          process: process,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}