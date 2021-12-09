import 'package:flutter/material.dart';
import 'package:qetaf/components/order_overlay/widgets/product_listing.dart';
import 'package:qetaf/components/static_sections/products_section/models/product.dart';

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
            ? const Center(
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.arrow_drop_down_sharp),
                ),
              )
            : Column(
                children: [
                  const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Icon(Icons.arrow_drop_up_sharp),
                    ),
                  ),
                  ProductListing(
                    product: product,
                  )
                ],
              ),
      ),
    );
  }
}
