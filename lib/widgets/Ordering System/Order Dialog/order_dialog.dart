import 'package:flutter/material.dart';

class OrderDialog extends StatelessWidget {
  const OrderDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'tag',
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 100, horizontal: 200),
        child: Material(
          color: Colors.transparent,
          child: Container(
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black,
                    blurRadius: 10,
                  )
                ]),
            child: IconButton(
              icon: const Icon(Icons.exit_to_app),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
