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

List<ProductDetails> demoProducts = [
  ProductDetails(
      id: '1',
      title: 'عسل البرسيم',
      price: 50,
      shortDescription: '',
      tags: [],
      imageSource: 'assets/images/clover.png',
    ),
  ProductDetails(
      id: '2',
      title: 'عسل الموالح',
      price: 60,
      shortDescription: '',
      tags: [],
      imageSource: 'assets/images/citrus.png',
    ),
  ProductDetails(
      id: '3',
      title: 'عسل حبة البركة',
      price: 50,
      shortDescription: '',
      tags: [],
      imageSource: 'assets/images/blackseed.png',
    ),
    ProductDetails(
      id: '4',
      title: 'عسل البرسيم سكويز',
      price: 25,
      shortDescription: '',
      tags: [],
      imageSource: 'assets/images/clover-squeeze.png',
    ),
  ProductDetails(
      id: '5',
      title: 'عسل مكسرات',
      price: 30,
      shortDescription: '',
      tags: [],
      imageSource: 'assets/images/nuthoney.png',
    ),
  ProductDetails(
      id: '6',
      title: 'الربوة',
      price: 150,
      shortDescription: '',
      tags: [],
      imageSource: 'assets/images/rabwa.png',
    ),
];
