import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:qetaf/components/order_overlay/order_dialog/models/ordering_process_model.dart';

class NavigationButtons extends StatelessWidget {
  final PageController controller;
  final OrderingProcessModel process;

  const NavigationButtons({Key? key, required this.controller, required this.process}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
            children: [
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  elevation: 50,
                  primary: Colors.black,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () => _forwardButtonFunction(process, context),
                child: Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: (process.status ==
                            statusEnum.onCompleteProductDetailsSection)
                        ? Text('تأكيد الطلب')
                        : Text(
                            'التالي',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              OutlinedButton(
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(
                    color: Colors.black,
                    style: BorderStyle.solid,
                  ),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                ),
                onPressed: () => _backwardButtonFunction(process, context),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: FittedBox(
                    child: Text(
                      'الرجوع',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black),
                    ),
                  ),
                ),
              ),
            ],
          );
  }
  void _backwardButtonFunction(OrderingProcessModel process, BuildContext context) {
    switch (process.status) {
      case statusEnum.onProductsSection:
      {
        Navigator.pop(context);
      }
      break;
      default:
        {
          controller.animateToPage(0,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          process.switchStatus(statusEnum.onProductsSection);
        }
    }
  }

  void _forwardButtonFunction(
      OrderingProcessModel process, BuildContext context) {
    switch (process.status) {
      case statusEnum.onProductsSection:
        {
          controller.animateToPage(1,
              duration: Duration(milliseconds: 500), curve: Curves.linear);
          process.switchStatus(statusEnum.editingAddress);
        }
        break;
      case statusEnum.onCompleteProductDetailsSection:
        {
          if (process.deliveryMethod == deliveryMethodEnum.fedex) {
            if (process.addressNotAssigned()) {
              print("1");
              showDialog<String>(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: Center(child: const Text('من فضلك أدخل عنوانك')),
                  content: const Text(
                    '''لقد اخترت التوصيل للمنزل,
                   فمنفضلك ادخل العنوان او اختر الإستلام من الفرع''',
                    textAlign: TextAlign.center,
                  ),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.pop(context, 'OK'),
                      child: const Text('موافق'),
                    ),
                  ],
                ),
              );
            }else{
            process.switchStatus(statusEnum.done);  
            }
          } else {
            process.switchStatus(statusEnum.done);
          }
        }
        break;
      default:
        {
          null;
        }
    }
  }
}