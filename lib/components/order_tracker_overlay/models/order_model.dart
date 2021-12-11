import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/cart/models/cart_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/shippingaddress_model.dart';

enum orderStatusEnum { processing, confirmed, shipped, delivered, cancelled }

class orderStatusEnumOptions {
  static Map getValue(orderStatusEnum orderStatus) {
    switch (orderStatus) {
      case orderStatusEnum.processing:
        return {
          'message': 'في انتظار التأكيد',
          'color': Colors.grey,
          'icon': Icons.wallet_giftcard,
        };
      case orderStatusEnum.confirmed:
        return {
          'message': 'تم التأكيد, بأمكانك استلامه من الفرع اذا اخترت الإستلام من الفرع',
          'color': Colors.grey,
          'icon': Icons.delivery_dining_rounded,
        };
      case orderStatusEnum.shipped:
        return {
          'message': 'تم الشحن',
          'color': Colors.yellowAccent,
          'icon': Icons.delivery_dining_rounded,
        };
      case orderStatusEnum.delivered:
        return {
          'message': 'تم التوصيل',
          'color': Colors.greenAccent,
          'icon': Icons.delivery_dining_rounded,
        };
        case orderStatusEnum.cancelled:
        return {
          'message': 'تم الألغاء',
          'color': Colors.redAccent,
          'icon': Icons.delivery_dining_rounded,
        };
    }
  }
}
class orderStatusEnumFactory {
  static orderStatusEnum getValue(String data) {
    switch (data) {
      case 'confirmed':
        return orderStatusEnum.confirmed;
      case 'delivered':
        return orderStatusEnum.delivered;
      case 'processing':
        return orderStatusEnum.processing;
      case 'shipped':
        return orderStatusEnum.shipped;
      case 'cancelled':
        return orderStatusEnum.cancelled;
      default:
        return orderStatusEnum.processing;
    }
  }
}

class OrderModel {
  final orderStatusEnum orderStatus;
  final CartModel cart;
  final deliveryMethodEnum deliveryMethod;
  final paymentMethodEnum paymentMethod;
  final ShippingAddressModel shippingAddress;
  final DateTime dateOfCreation;

  OrderModel({
    required this.orderStatus,
    required this.cart,
    required this.deliveryMethod,
    required this.paymentMethod,
    required this.shippingAddress,
    required this.dateOfCreation,
  });
}
