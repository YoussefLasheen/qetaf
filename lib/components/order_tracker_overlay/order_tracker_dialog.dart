import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:qetaf/components/order_overlay/cart/models/cart_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/shippingaddress_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/widgets/side_panel.dart';
import 'package:qetaf/components/order_overlay/widgets/products_list.dart';
import 'package:qetaf/components/order_tracker_overlay/models/order_model.dart';
import 'package:qetaf/components/static_sections/products_section/models/product.dart';
import 'package:qetaf/services/api.dart';

class OrderTrackerDialog extends StatefulWidget {
  static final _searchController = TextEditingController();
  const OrderTrackerDialog({Key? key}) : super(key: key);

  @override
  State<OrderTrackerDialog> createState() => _OrderTrackerDialogState();
}

class _OrderTrackerDialogState extends State<OrderTrackerDialog> {
  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'tracker',
      child: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          color: Colors.black12,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints.expand(width: 800, height: 600),
              child: Column(
                children: [
                  Expanded(
                    child: Card(
                      color: Color(0xfff7f7fa),
                      elevation: 20,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TextField(
                            style: TextStyle(
                              fontSize: 40,
                            ),
                            decoration: new InputDecoration(
                              contentPadding: EdgeInsets.all(0),
                                border: InputBorder.none, hintText: 'رقم الطلبية'),
                            controller: OrderTrackerDialog._searchController,
                            onSubmitted: (String text) {
                              setState(() {});
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  OrderTrackerDialog._searchController.text == ''
                      ? Spacer(
                          flex: 5,
                        )
                      : Expanded(
                          flex: 5,
                          child: FutureBuilder(
                            future: Api('Orders').getDocumentById(
                                OrderTrackerDialog._searchController.text),
                            builder: (context,
                                AsyncSnapshot<DocumentSnapshot> snapshot) {
                              if (snapshot.hasError) {
                                return Text("Something went wrong");
                              }

                              if (snapshot.hasData && !snapshot.data!.exists) {
                                return Text("Document does not exist");
                              }
                              if (snapshot.connectionState ==
                                  ConnectionState.done) {
                                Map<String, dynamic> data = snapshot.data!
                                    .data() as Map<String, dynamic>;
                                OrderModel order = OrderModel(
                                    cart: CartModel(
                                      products: [
                                        for (var i = 0;
                                            i < data['cart'].length;
                                            i++)
                                          ProductListingModel(
                                            quantity: 1,
                                            productDetails: ProductDetails(
                                              id: data['cart'][i]['id'],
                                              title: data['cart'][i]['title'],
                                              shortDescription: data['cart'][i]
                                                  ['shortDescription'],
                                              imageSource: data['cart'][i]
                                                  ['imageSource'],
                                              price: data['cart'][i]['price'],
                                              tags: [],
                                            ),
                                          )
                                      ],
                                    ),
                                    deliveryMethod:
                                        data['deliveryMethod'] == 'delivery'
                                            ? deliveryMethodEnum.fedex
                                            : deliveryMethodEnum.pickup,
                                    paymentMethod: paymentMethodEnum.COD,
                                    shippingAddress: ShippingAddressModel(
                                      address: data['address']['address'],
                                      fullName: data['address']['name'],
                                      phoneNo: data['address']['phone'],
                                    ),
                                    dateOfCreation: data['date'].toDate(),
                                    orderStatus: orderStatusEnumFactory
                                        .getValue(data['status']));
                                return Column(
                                  children: [
                                    Expanded(
                                      child: Card(
                                        color: orderStatusEnumOptions.getValue(
                                            order.orderStatus)['color'],
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.stretch,
                                            children: [
                                              SelectableText(
                                                snapshot.data!.id,
                                                style: TextStyle(
                                                    fontSize: 12,
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              Text(
                                                " تم الطلب في" +
                                                    intl.DateFormat.yMMMd()
                                                        .format(order
                                                            .dateOfCreation),
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              ),
                                              Text(
                                                orderStatusEnumOptions.getValue(
                                                        order.orderStatus)[
                                                    'message'],
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 12),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      flex: 4,
                                      child: Card(
                                        color: Color(0xfff7f7fa),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Row(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Expanded(
                                                flex: 3,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ProductsList(
                                                    cart: CartModel(
                                                        products: order
                                                            .cart.products),
                                                    isEditable: false,
                                                  ),
                                                ),
                                              ),
                                              Expanded(
                                                flex: 2,
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: SidePanel(
                                                    process: OrderingProcessModel
                                                        .doneOrder(
                                                            CartModel(
                                                                products: order
                                                                    .cart
                                                                    .products),
                                                            order
                                                                .deliveryMethod,
                                                            order.paymentMethod,
                                                            order
                                                                .shippingAddress),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              }
                              return Text("loading");
                            },
                          ),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
