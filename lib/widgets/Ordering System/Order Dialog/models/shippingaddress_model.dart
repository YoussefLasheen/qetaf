import 'package:qetaf/models/user_model.dart';

class ShippingAddressModel {
  final String fullName;
  final String phoneNo;
  final String address;

  ShippingAddressModel({required this.fullName, required this.address, required this.phoneNo});

  
  static ShippingAddressModel notAssigned() {
      return ShippingAddressModel(
        fullName: 'NA',
        address: 'NA',
        phoneNo: 'NA'
      );
   }
}