import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/navigation/nav_bar.dart';
import 'package:qetaf/widgets/Ordering%20System/Cart/cart.dart';
import 'package:qetaf/widgets/contact_section.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

import 'widgets/Ordering System/Cart/models/cart_model.dart';
import 'widgets/aboutus_section.dart';
import 'widgets/products_section/products_section.dart';
import 'widgets/welcome_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ItemScrollController itemScrollController = ItemScrollController();
    final ItemPositionsListener itemPositionsListener =
        ItemPositionsListener.create();
    return ChangeNotifierProvider(
      create: (_)=> CartModel(products: []),
      child: Material(
        child: Stack(
          children: [
            Column(
              children: [
                ValueListenableBuilder<Iterable<ItemPosition>>(
                    valueListenable: itemPositionsListener.itemPositions,
                    builder: (context, positions, child) {
                      int? max = 0;
                      if (positions.isNotEmpty) {
                        max = positions.first.index;
                      }
                      return NavBar(
                          currentIndex: max,
                          onTap: (index) {
                            itemScrollController.scrollTo(
                                index: index,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOutCubic);
                          });
                    }),
                Expanded(
                  child: ScrollablePositionedList.builder(
                    itemPositionsListener: itemPositionsListener,
                    itemScrollController: itemScrollController,
                    shrinkWrap: true,
                    itemCount: items.length,
                    itemBuilder: (context, index) => items[index],
                  ),
                ),
              ],
            ),
            const Align(alignment: Alignment.bottomRight, child: Cart()),
          ],
        ),
      ),
    );
  }
}

List items = const [
  WelcomeSection(),
  ProductsSection(),
  AboutusSection(),
  ContactSection()
];
