import 'package:flutter/material.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';

enum statusEnum {
  onProductsSection,
  editingAddress,
  editingPaymentOptions,
  onCompleteProductDetailsSection
}

enum deliveryMethodEnum { pickup, fedex }

class deliveryMethodEnumDetails {
  static Map getValue(deliveryMethodEnum deliveryMethod) {
    switch (deliveryMethod) {
      case deliveryMethodEnum.fedex:
        return {
          'name': 'FedEx',
          'price': 40,
          'icon': Icons.delivery_dining_rounded,
          'estimatedDeliveryTime': '2 - 3 days'
        };
      case deliveryMethodEnum.pickup:
        return {
          'name': 'Pickup',
          'icon': Icons.store_mall_directory_rounded,
          'price': 0,
          'estimatedDeliveryTime': 'ASAP'
        };
    }
  }
}

class OrderingProcessModel extends ChangeNotifier {
  statusEnum status = statusEnum.onProductsSection;
  deliveryMethodEnum deliveryMethod = deliveryMethodEnum.pickup;
  final CartModel cart;

  OrderingProcessModel({required this.cart});


  double calculateTotalPrice() {
    double sum = cart.calculateTotalPrice() + deliveryMethodEnumDetails.getValue(deliveryMethod)['price'] + 10;
    return sum;
  }

  void switchStatus(statusEnum newStatus) {
    status = newStatus;
    notifyListeners();
  }

  void toggleBetweenStatuses(statusEnum firstStatus, statusEnum secondStatus) {
    if (status == firstStatus) {
      switchStatus(secondStatus);
    } else if (status == secondStatus) {
      switchStatus(firstStatus);
    }
  }

  void switchDeliveryMethod(deliveryMethodEnum newMethod) {
    deliveryMethod = newMethod;
    notifyListeners();
  }
}
