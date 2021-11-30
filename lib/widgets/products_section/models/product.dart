class ProductListingModel {
  ProductListingModel({
    required this.productDetails,
    required this.quantity,
  });
  final ProductDetails productDetails;
  int quantity;
}

class ProductDetails {
  ProductDetails({
    required this.id,
    required this.title,
    required this.shortDescription,
    required this.imageSource,
    required this.price,
    required this.tags,
  });
  final String id;
  final String title;
  final String shortDescription;
  final String imageSource;
  final double price;
  final List tags;
}
