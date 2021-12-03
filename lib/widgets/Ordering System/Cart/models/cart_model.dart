import 'package:flutter/material.dart';
import 'package:qetaf/widgets/products_section/models/product.dart';

class CartModel extends ChangeNotifier {
  CartModel({
    required this.products,
  });
  List<ProductListingModel> products;

  double calculateTotalPrice() {
    double sum = 0;
    products.forEach((e) => sum += e.productDetails.price);
    return sum;
  }

  void add(ProductDetails productDetails) {
    for (var i = 0; i < products.length; i++) {
      if (productDetails.id == products[i].productDetails.id) {
        ProductListingModel oldProduct = products[i];
        oldProduct.quantity = products[i].quantity + 1;
        products.removeAt(i);
        products.add(oldProduct);
        notifyListeners();
        return;
      }
    }

    products.add(ProductListingModel(
        productDetails: productDetails,
        quantity: 1));
    notifyListeners();
  }

  void remove(ProductListingModel productListing) {
    products.remove(productListing);
    notifyListeners();
  }

  void updateQuantity(ProductDetails productDetails, int newQuantity) {
    for (var i = 0; i < products.length; i++) {
      if (productDetails.id == products[i].productDetails.id) {
        products[i].quantity += newQuantity;
        notifyListeners();
        return;
      }
    }
  }
}
