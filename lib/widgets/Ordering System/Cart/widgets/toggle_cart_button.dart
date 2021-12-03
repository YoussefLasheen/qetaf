import 'package:flutter/material.dart';
import 'package:qetaf/widgets/Ordering%20System/widgets/product_listing.dart';
import 'package:qetaf/widgets/products_section/models/product.dart';

class ToggleCartButton extends StatelessWidget {
  final void Function() toggleExpand;
  final bool isExpanded;
  final ProductListingModel product;
  const ToggleCartButton(
      {Key? key, required this.toggleExpand, required this.isExpanded, required this.product})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: toggleExpand,
      child: Container(
        child: isExpanded
            ? const Align(
                alignment: Alignment.topLeft,
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.close),
                ),
              )
            : Column(
                children: [
                  ProductListing(product: product,)
                ],
              ),
      ),
    );
  }
}