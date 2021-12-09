import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/components/order_overlay/cart/models/cart_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/cart_overview_section.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/order_details_section.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    CartModel cart = Provider.of<CartModel>(context);
    PageController controller = PageController();
    return Hero(
      tag: 'tag',
      child: ChangeNotifierProvider(
        create: (_) => OrderingProcessModel(cart: cart),
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(width: 1500, height: 800),
              child: Material(
                color: Color(0xfff7f7fa),
                elevation: 20,
                borderRadius: BorderRadius.circular(20),
                shadowColor: Colors.black,
                child: Consumer<OrderingProcessModel>(
                  builder: (_,process,___) {
                    return IndexedStack(
                      index: process.status == statusEnum.done?0:1,
                      children: [
                        OrderConfirmationDialog(process: process,),
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ConstrainedBox(
                                constraints:
                                    BoxConstraints(maxWidth: 500, maxHeight: 800),
                                child: PageView(
                                  pageSnapping: true,
                                  scrollDirection: Axis.vertical,
                                  physics: const NeverScrollableScrollPhysics(),
                                  controller: controller,
                                  children: [
                                    CartOverviewSection(cart: cart),
                                    OrderDetailsSection()
                                  ],
                                ),
                              ),
                              SizedBox(
                                width: 20,
                              ),
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 20),
                                child: ConstrainedBox(
                                    constraints:
                                        BoxConstraints(maxWidth: 300, minHeight: 125),
                                    child: SidePanel(controller: controller)),
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class SidePanel extends StatelessWidget {
  const SidePanel({
    Key? key,
    required this.controller,
  }) : super(key: key);

  final PageController controller;

  @override
  Widget build(BuildContext context) {
    OrderingProcessModel process = Provider.of<OrderingProcessModel>(context);
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
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
              SizedBox(height: 20,),
              Row(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 50,
                      primary: Colors.black,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () => _forwardButtonFunction(process, context),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: (process.status ==
                                statusEnum.onCompleteProductDetailsSection)
                            ? Text('تأكيد الطلب')
                            : Text(
                                'التالي',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(
                        color: Colors.black,
                        style: BorderStyle.solid,
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15)),
                    ),
                    onPressed: () => _backwardButtonFunction(process, context),
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          'الرجوع',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ]),
      ),
    );
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

  void _backwardButtonFunction(OrderingProcessModel process, BuildContext context) {
    switch (process.status) {
      case statusEnum.onProductsSection:
      {
        Navigator.pop(context);
      }
      break;
      default:
        {
          controller.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          process.switchStatus(statusEnum.onProductsSection);
        }
    }
  }

  void _forwardButtonFunction(
      OrderingProcessModel process, BuildContext context) {
    switch (process.status) {
      case statusEnum.onProductsSection:
        {
          controller.animateToPage(1,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          process.switchStatus(statusEnum.editingAddress);
        }
        break;
      case statusEnum.onCompleteProductDetailsSection:
        {
          if (process.deliveryMethod == deliveryMethodEnum.fedex) {
            if (process.addressNotAssigned()) {
              print("1");
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(child: const Text('من فضلك أدخل عنوانك')),
                  content: const Text(
                    '''لقد اخترت التوصيل للمنزل,
                   فمنفضلك ادخل العنوان او اختر الإستلام من الفرع''',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('موافق'),
                    ),
                  ],
                ),
              );
            }else{
            process.switchStatus(statusEnum.done);  
            }
          } else {
            process.switchStatus(statusEnum.done);
          }
        }
        break;
      default:
        {
          null;
        }
    }
  }
}

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
