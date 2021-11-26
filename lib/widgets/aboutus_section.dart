import 'package:flutter/material.dart';

class AboutusSection extends StatelessWidget {
  const AboutusSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;
    return SizedBox(
      height: screenHeight * 0.8,
      child: Stack(
        children: [
          const Placeholder(),
          Positioned(
            right: 50,
            top: 100,
            child: Container(
              width: screenWidth * 0.8 * 0.3,
              height: screenHeight * 0.8 * 0.5,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: const [BoxShadow(color: Colors.black,blurRadius: 10,)]),
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Align(
                    alignment: Alignment.topRight,
                    child: Text('!الق نظرة علي مزارعنا في طنطا',style: TextStyle(fontSize: 30),)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
