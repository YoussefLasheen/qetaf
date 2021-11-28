import 'package:flutter/material.dart';

import 'indicator.dart';

class NavBar extends StatelessWidget {
  const NavBar({Key? key, required this.currentIndex, required this.onTap}) : super(key: key);

  final int currentIndex;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      decoration: const BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(color: Colors.black,blurRadius: 10,)
        ]
      ),      
      child: Indicator(
        activePage: currentIndex,
        pages: pages,
        callback: (int index) {
          onTap(index);
        },
      ),
    );
  }
}

List pages = [
  'مقدمة',
    'منتجاتنا',
    'مزارعنا',
];