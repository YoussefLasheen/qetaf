import 'package:flutter/material.dart';
import 'package:qetaf/widgets/contact_section.dart';

import 'widgets/aboutus_section.dart';
import 'widgets/products_section/products_section.dart';
import 'widgets/welcome_section.dart';
class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Material(
      child: ListView(
        shrinkWrap: true,
        children: const [
          WelcomeSection(),
          ProductsSection(),
          AboutusSection(),
          ContactSection()
        ],
      ),
    );
  }
}