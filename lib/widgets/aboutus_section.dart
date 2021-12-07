import 'package:flutter/cupertino.dart';
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
          Positioned.fill(child: Image.network('assets/images/aboutus_bg.jpg',fit: BoxFit.cover,)),
          Positioned(
            right: 50,
            top: 100,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: 500,
                maxHeight: 300
              ),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.white,
                  boxShadow: const [BoxShadow(color: Colors.black,blurRadius: 10,)]),
              child: Padding(
                padding: EdgeInsets.all(40.0),
                child: Column(
                  children: [
                    Text('الق نظرة علي مزارعنا في طنطا',style: TextStyle(fontSize: 45,fontWeight: FontWeight.bold),),
                    Align(
                      alignment: AlignmentDirectional.bottomEnd,
                      child: FittedBox(
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
                                  'شاهد',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
