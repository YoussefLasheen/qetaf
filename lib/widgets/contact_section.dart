import 'package:flutter/material.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    return Container(
      height: screenHeight * 0.25,
      color: Colors.black,
      child: Column(
        children: [
          const Spacer(),
          Expanded(
            child: Row(
              children: [
                const Spacer(),
                Expanded(
                  child: Column(
                    children: const [
                      Text('01012546889',style: TextStyle(color: Colors.white),),
                      Text('10151584135',style: TextStyle(color: Colors.white),),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: const[
                       Placeholder(fallbackWidth: 50,),
                       Placeholder(fallbackWidth: 50,),
                       Placeholder(fallbackWidth: 50,),
                       Placeholder(fallbackWidth: 50,),
                    ],
                  ),
                ),
                const Spacer(),
                Expanded(
                  child: Image.asset('logo.png'),
                ),
                const Spacer(),
              ],
            ),
          ),
          const Spacer()
        ],
      ),
    );
  }
}