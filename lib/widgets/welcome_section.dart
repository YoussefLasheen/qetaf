import 'package:flutter/material.dart';

class WelcomeSection extends StatelessWidget {
  const WelcomeSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      height: screenHeight,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Container(
              color: Colors.amberAccent,
              width: double.infinity,
              height: double.infinity,
              child: const UnconstrainedBox(
                child: Placeholder(),
              ),
            ),
          ),
          Expanded(
            child: Column(
              children: [
                const Spacer(),
                Expanded(
                  flex: 8,
                  child: Container(
                    color: Colors.black12,
                    width: double.infinity,
                    height: double.infinity,
                    child: const UnconstrainedBox(
                      child: Placeholder(),
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    color: Colors.pink,
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
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  'منتجاتنا',
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
                            onPressed: () {},
                            child: const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: FittedBox(
                                child: Text(
                                  'من نحن',
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
                ),
                const Spacer()
              ],
            ),
          )
        ],
      ),
    );
  }
}
