import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/PackageModels.dart';
import 'package:fox_delivery_owner/Modules/AllOrdersScreen/AllOrdersScreen.dart';
import 'package:fox_delivery_owner/Modules/OrdersScreen/OrdersScreen.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../constants/constants.dart';

class FoxCubit extends Cubit<FoxStates> {
  FoxCubit() : super(FoxInitialState());

  static FoxCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    OrdersScreen(),
    AllOrderScreen(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.backpack), label: 'Orders'),
    BottomNavigationBarItem(icon: Icon(Icons.backpack), label: 'Orders'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(FoxChangeBotNavBare());
  }


  DateTime selectedDay = DateTime.now();

  void getOrders() {
    emit(FoxGetOrdersLoadingState());
    orders = [];
    FirebaseFirestore.instance
        .collection('packages')
        .orderBy('dateTime', descending: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
        orders.add(PackageModel.fromJson(element.data()));
      }
      setSelectedDate(newDate: DateTime.now());
      emit(FoxGetOrdersSuccessState());
    }).catchError((error) {
      emit(FoxGetOrdersErrorState());
    });
  }

  void goToToday(){
    selectedDay = DateTime.now();
    setSelectedDate(newDate: selectedDay);
  }

  bool isSameTime({
    required String date1,
    required DateTime date2,
  }) {
    if (num.parse(date1.substring(0,4)).toString() == date2.year.toString() &&
        num.parse(date1.substring(5,7)).toString() == date2.month.toString() &&
        num.parse(date1.substring(8,10)).toString() == date2.day.toString()) {
      return true;
    } else {
      return false;
    }
  }

  void setSelectedDate({
  required DateTime newDate,
    bool fromStart = false,
}) {
    selectedDay = newDate;
    selectedOrders = [];
    for (var element in orders) {
      if(isSameTime(date1: element.dateTime!, date2: selectedDay)){
        selectedOrders.add(element);
      }
    }

    // getDatabase(database!);
    if(fromStart){
      emit(FoxSetNewDateState());
    }
  }
}
