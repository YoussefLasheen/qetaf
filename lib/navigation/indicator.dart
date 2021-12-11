import 'package:flutter/material.dart';
import 'package:qetaf/components/order_tracker_overlay/order_tracker_dialog.dart';

class Indicator extends StatelessWidget {
  final int activePage;
  final List pages;
  final void Function(int) callback;

  const Indicator({
    Key? key,
    required this.activePage,
    required this.pages,
    required this.callback,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          Expanded(
            child: Row(
              textDirection: TextDirection.rtl,
              children: <Widget>[
                for (var pageIndex = 0; pageIndex < pages.length; pageIndex++)
                  GestureDetector(
                    onTap: () => callback(pageIndex),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: FittedBox(
                        child: Text(
                          pages[pageIndex],
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                              color: activePage == pageIndex
                                  ? Colors.amber
                                  : Colors.black),
                        ),
                      ),
                    ),
                  ),
                  Spacer(),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                          opaque: false,
                          pageBuilder: (_, __, ___) => const OrderTrackerDialog()),
                    );
                  },
                  child: Text("متابعة الطلب"),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/qetaf-website.appspot.com/o/logo.png?alt=media&token=883440b9-bdb9-412e-a81f-c12cec2ae8da'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
