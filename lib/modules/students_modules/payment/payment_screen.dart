import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sms_flutter/layout/student_general/student_general.dart';
import 'package:sms_flutter/modules/students_modules/payment/payment_cubit/payment_cubit.dart';
import 'package:sms_flutter/modules/students_modules/payment/payment_cubit/payment_states.dart';
import 'package:sms_flutter/shared/components/components.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Price {
  final String title;
  final String price;
  final String hours;
  bool colored;
  Price(
      {required this.title,
      required this.price,
      required this.hours,
      this.colored = false});
}

class PaymentScreen extends StatelessWidget {

  final List<Price> price = [
    Price(
      title: 'ََAlgebra ',
      price: '1800EGP',
      hours: '3h',
    ),
    Price(
      title: 'ََoop ',
      price: '1800EGP',
      hours: '3h',
    ),
    Price(
      title: 'ََoop ',
      price: '1800EGP',
      hours: '3h',
    ),
    Price(
      title: 'ََoop ',
      price: '1800EGP',
      hours: '3h',
    ),
    Price(
      title: 'ََoop ',
      price: '1800EGP',
      hours: '3h',
    ),
    Price(
      title: 'ََoop ',
      price: '1800EGP',
      hours: '3h',
    ),
    Price(
      title: 'ََTotal Number of hours :',
      price: '10800EGP',
      hours: '17h',
      colored: true,
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => PaymentCubit(),
      child: BlocConsumer<PaymentCubit, PaymentStates>(
        listener: (BuildContext context, Object? state) {},
        builder: (BuildContext context, state) {
          var paymentCubit = PaymentCubit.get(context);
          return Scaffold(
            appBar: projectAppBar(context),
            drawer: StudentGeneral(),
            body: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        Text(
                          'Student Name: Ahmed Mohamed',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text(
                          'Student ID: 203009',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
// Text(
//   'Course Name: oop',
//   style: TextStyle(fontWeight: FontWeight.bold),
// ),
                      ],
                    ),
                  ),
                  myDivider(),
                  Expanded(
                    child: ListView.separated(
                        itemCount: price.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            child: Container(
                              height: 40,
                              color: price[index].colored
                                  ? Colors.greenAccent
                                  : Colors.white,
                              padding: EdgeInsets.all(9),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
// padding: const EdgeInsets.only(left: 16),
                                    child: Text(price[index].title),
                                  ),
                                  Spacer(),
                                  Expanded(
                                    child: Text(price[index].hours),
                                  ),
                                  Spacer(),
                                  Expanded(
// padding: const EdgeInsets.only(right: 16),
                                    child: Text(
                                      price[index].price,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
// Build your separator widget here
                          return Divider(
                            color: Colors.black54,
                          );
                        }),
                  ),
                  myDivider(),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          "Payment State:",
                          style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                              color: Colors.black26),
                        ),
                        Icon(
                          paymentCubit.paid?Icons.dangerous:Icons.verified,
                          color: paymentCubit.paid?Colors.red:Colors.green,
                          size: 30.0,
                          semanticLabel:
                              'Text to announce in accessibility modes',
                        ),
                        Text(
                          paymentCubit.paid?'Not paid':'paid',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ]),
          );
        },
      ),
    );
  }
}
