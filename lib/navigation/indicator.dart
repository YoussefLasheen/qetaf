import 'package:flutter/material.dart';

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
                  )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
