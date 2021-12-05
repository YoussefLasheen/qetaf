import 'package:flutter/material.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/models/cart_model.dart';
import 'package:qetaf/widgets/Ordering%20System/Order%20Dialog/models/shippingaddress_model.dart';

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
enum paymentMethodEnum { COD , CARD}

class paymentMethodEnumDetails {
  static Map getValue(paymentMethodEnum paymentMethod) {
    switch (paymentMethod) {
      case paymentMethodEnum.COD:
        return {
          'name': 'Cash on Delivery',
          'price': 10,
          'icon': Icons.money_rounded,
          'isAvailble':true
        };
        case paymentMethodEnum.CARD:
        return {
          'name': 'Banking Card',
          'price': 0,
          'icon': Icons.credit_card_rounded,
          'isAvailble':false
        };
    }
  }
}

class OrderingProcessModel extends ChangeNotifier {
  statusEnum status = statusEnum.onProductsSection;
  deliveryMethodEnum deliveryMethod = deliveryMethodEnum.pickup;
  paymentMethodEnum paymentMethod = paymentMethodEnum.COD;
  final CartModel cart;
  ShippingAddressModel shippingAddress = ShippingAddressModel.notAssigned();

  OrderingProcessModel({required this.cart});


  double calculateTotalPrice() {
    double sum = cart.calculateTotalPrice() + deliveryMethodEnumDetails.getValue(deliveryMethod)['price'] + 10;
    return sum;
  }

  void switchAddress(ShippingAddressModel newShippingAddress) {
    shippingAddress = newShippingAddress;
    notifyListeners();
  }
  bool addressNotAssigned() {
    bool result = [shippingAddress.fullName, shippingAddress.address, shippingAddress.phoneNo].contains('NA');
    print(shippingAddress.fullName);
    return result;
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
  void switchPaymentMethod(paymentMethodEnum newMethod) {
    paymentMethod = newMethod;
    notifyListeners();
  }
}
