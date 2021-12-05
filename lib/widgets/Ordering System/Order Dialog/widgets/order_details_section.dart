import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/models/ordering_process_model.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/models/shippingaddress_model.dart';

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
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 300,
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
                  validator: (val) => val!.isEmpty ? 'العنوان غير صحيح' : null,
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
    bool _isSelected = process.paymentMethod == paymentMethod;
    return Card(
      color: _isSelected ? Colors.orange : Colors.white,
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
                      fontWeight:
                          _isSelected ? FontWeight.bold : FontWeight.normal,
                      color: _isSelected ? Colors.white : Colors.black),
                ),
                Icon(paymentMethodEnumDetails.getValue(paymentMethod)['icon'],
                    size: 30, color: _isSelected ? Colors.white : Colors.black),
                SizedBox(
                  height: 6,
                ),
                Text(
                  '+' +
                      paymentMethodEnumDetails
                          .getValue(paymentMethod)['price']
                          .toString(),
                  style:
                      TextStyle(color: _isSelected ? Colors.white : Colors.black),
                ),
              ],
            ),
          ),
        ),
      ),
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
