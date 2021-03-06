import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

class WelcomeSection extends StatelessWidget {
  final ItemScrollController itemScrollController;
  const WelcomeSection({Key? key, required this.itemScrollController}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight,
      decoration: BoxDecoration(
        gradient:  LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color.fromARGB(255 ,255, 196, 33,),
                Color.fromARGB(255, 252, 186, 3)
              ],
            )
      ),
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Image.network('https://firebasestorage.googleapis.com/v0/b/qetaf-website.appspot.com/o/welcome_section_2.png?alt=media&token=a160915f-1b83-4411-b271-66167ecc5308'),
                ),
                Expanded(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(
                        width: 30,
                      ),
                      FittedBox(
                        fit: BoxFit.fitHeight,
                        child: ElevatedButton(
                          style: OutlinedButton.styleFrom(
                            elevation: 50,
                            backgroundColor: Colors.black,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () {
                            itemScrollController.scrollTo(
                                index: 1,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOutCubic);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                '????????????????',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      FittedBox(
                        child: OutlinedButton(
                          style: OutlinedButton.styleFrom(
                            side: const BorderSide(
                              color: Colors.black,
                              style: BorderStyle.solid,
                            ),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(15)),
                          ),
                          onPressed: () {
                            itemScrollController.scrollTo(
                                index: 2,
                                duration: const Duration(seconds: 1),
                                curve: Curves.easeInOutCubic);
                          },
                          child: const Padding(
                            padding: EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                '???? ??????',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer()
              ],
            ),
          ),
          Expanded(
            child: Image.network('https://firebasestorage.googleapis.com/v0/b/qetaf-website.appspot.com/o/welcome_section_1.png?alt=media&token=2b3b4d6f-9a04-4a89-8009-a56b1b81e6a1'),
          ),
        ],
      ),
    );
  }
}
