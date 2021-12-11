import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/shippingaddress_model.dart';

class ShippingAddressForm extends StatelessWidget {
  static var _formKey = GlobalKey<FormState>();
  static final _nameController = TextEditingController();
  static final _addressController = TextEditingController();
  static final _phoneController = TextEditingController();
  final OrderingProcessModel process;
  static String p =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  const ShippingAddressForm({Key? key, required this.process})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    String contactNumber;
    String pin;
    return Form(
      key: _formKey,
      child: Align(
        alignment: AlignmentDirectional.topStart,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxHeight: 300,
              maxWidth: 400
            ),
            child: Column(
              children: [
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 70),
                  child: TextFormField(
                    controller: _nameController,
                    decoration: const InputDecoration(
                        hintText: 'الاسم', icon: Icon(Icons.person)),
                    validator: (val) => val!.isEmpty ? 'الاسم غير صحيح' : null,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 70),
                  child: TextFormField(
                    controller: _addressController,
                    decoration: const InputDecoration(
                        hintText: 'العنوان', icon: Icon(Icons.house_rounded)),
                    validator: (val) => val!.isEmpty ? 'العنوان غير صحيح' : null,
                  ),
                ),
                ConstrainedBox(
                  constraints: BoxConstraints(minHeight: 70),
                  child: TextFormField(
                    controller: _phoneController,
                    decoration: const InputDecoration(
                        hintText: 'رقم التيليفون', icon: Icon(Icons.phone)),
                    validator: (val) => val!.isEmpty ? 'رقم التيليفون غير صحيح' : null,
                  ),
                ),
                Spacer(),
                Align(
                  alignment: Alignment.centerRight,
                  child: ConstrainedBox(
                    constraints: BoxConstraints.expand(height: 50, width: 150),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextButton(
                        onPressed: () {
                          final form = _formKey.currentState;
                          if (form!.validate()) {
                            form.save();
                            process.switchAddress(ShippingAddressModel(
                                fullName: _nameController.text,
                                address: _addressController.text,
                                phoneNo: _phoneController.text));
                            process
                                .switchStatus(statusEnum.editingPaymentOptions);
                          }
                        },
                        child: Text(
                          "تأكيد العنوان",
                          style: TextStyle(color: Colors.white),
                        ),
                        style: TextButton.styleFrom(
                          backgroundColor: Colors.orange,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}