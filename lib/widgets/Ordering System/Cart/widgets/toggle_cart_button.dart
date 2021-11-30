import 'package:flutter/material.dart';

class ToggleCartButton extends StatelessWidget {
  final void Function() toggleExpand;
  final bool isExpanded;
  const ToggleCartButton(
      {Key? key, required this.toggleExpand, required this.isExpanded})
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
            : Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.shopping_cart),
                  ),
                  Center(child: Text("open")),
                ],
              ),
      ),
    );
  }
}