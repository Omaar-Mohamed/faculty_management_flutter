import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'payment_states.dart';
class PaymentCubit extends Cubit<PaymentStates>{

  PaymentCubit() : super(paymentInitialState());

  static PaymentCubit get(context) => BlocProvider.of(context);

  bool paid=true;

  final List<Price> price = [
    Price(
      title: 'ََAlgebra ',
      price :'1800EGP',
      hours :'3h',
    ),
    Price(
      title: 'ََoop ',
      price :'1800EGP',
      hours :'3h',
    ),
    Price(
      title: 'ََoop ',
      price :'1800EGP',
      hours :'3h',
    ),
    Price(
      title: 'ََoop ',
      price :'1800EGP',
      hours :'3h',
    ),
    Price(
      title: 'ََoop ',
      price :'1800EGP',
      hours :'3h',
    ),
    Price(
      title: 'ََoop ',
      price :'1800EGP',
      hours :'3h',
    ),
    Price(
      title: 'ََTotal Number of hours :',
      price :'10800EGP',
      hours: '17h',
      colored: true,
    ),



  ];


}
class Price {
  final String title;
  final String price;
  final String hours;
  bool colored;
  Price({required this.title,required this.price,required this.hours, this.colored = false});
}
