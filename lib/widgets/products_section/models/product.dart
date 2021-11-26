class Product {
  const Product({required this.id,  required this.title, required this.shortDescription, required this.imageSource,required this.tags, required this.price});
  final String id;
  final String title;
  final String shortDescription;
  final String imageSource;
  final double price;
  final List tags;
}