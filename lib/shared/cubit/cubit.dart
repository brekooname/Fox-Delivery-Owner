import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/PackageModels.dart';
import 'package:fox_delivery_owner/Models/ProblemModel.dart';
import 'package:fox_delivery_owner/Modules/AllOrdersScreen/AllOrdersScreen.dart';
import 'package:fox_delivery_owner/Modules/Offers/Offers.dart';
import 'package:fox_delivery_owner/Modules/OrdersScreen/OrdersScreen.dart';
import 'package:fox_delivery_owner/Modules/Problems/Problems.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

import '../constants/constants.dart';

class FoxCubit extends Cubit<FoxStates> {
  FoxCubit() : super(FoxInitialState());

  static FoxCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<Widget> screen = [
    OrdersScreen(),
    AllOrderScreen(),
    Offers(),
    Problems(),
  ];

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(icon: Icon(Icons.backpack), label: 'Orders'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.border_all), label: 'All Orders'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.local_offer), label: 'Offers'),
    const BottomNavigationBarItem(
        icon: Icon(Icons.bug_report_outlined), label: 'Problems'),
  ];

  void changeBottomNavBar(int index) {
    currentIndex = index;
    emit(FoxChangeBotNavBare());
  }

  DateTime selectedDay = DateTime.now();

  void getOrders(
      {BuildContext? context,
      bool fromCompleteOrder = false,
      bool fromFirst = false}) {
    if (fromCompleteOrder == false) {
      emit(FoxGetOrdersLoadingState());
    }
    orders = [];
    FirebaseFirestore.instance
        .collection('packages')
        .orderBy('dateTime', descending: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
        orders.add(PackageModel.fromJson(element.data()));
        packagesID.add(element.id);
      }
      setSelectedDate(newDate: DateTime.now(), fromGetOrders: true);
      if (fromCompleteOrder == true) {
        Navigator.pop(context!);
      }
      if (fromFirst) {
        getProblems(fromStart: true);
      }
      if (!fromFirst) {
        emit(FoxGetOrdersSuccessState());
      }
      // if(fromCompleteOrder == false){
      //   emit(FoxGetOrdersSuccessState());
      // }
    }).catchError((error) {
      emit(FoxGetOrdersErrorState());
    });
  }

  void setSelectedDate({
    required DateTime newDate,
    bool fromGetOrders = false,
  }) {
    if (!fromGetOrders) {
      emit(FoxSetSelectedDateLoadingState());
    }
    selectedDay = newDate;
    selectedOrders = [];
    for (var element in orders) {
      if (isSameTime(date1: element.dateTime!, date2: selectedDay)) {
        selectedOrders.add(element);
      }
    }

    if (!fromGetOrders) {
      emit(FoxSetSelectedDateSuccessState());
    }
  }

  void goToToday() {
    selectedDay = DateTime.now();
    setSelectedDate(newDate: selectedDay);
  }

  void checkConnection() async {
    internetConnection = await InternetConnectionChecker().hasConnection;
    if (internetConnection) {
      getOrders(fromFirst: true);
      // getProblems();
      // getPackagesNumber();
    } else {
      Get.snackbar('Fox Delivery', 'No Internet Connection',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void completeOrder({
    required BuildContext context,
    required String id,
    required String clientFirstName,
    required String clientLastName,
    required String clientUid,
    required String dateTime,
    required String dateTimeDisplay,
    required String description,
    required String fromLocation,
    required String toLocation,
    required int packageId,
    required String packageName,
  }) {
    emit(FoxCompleteOrderLoadingState());
    FirebaseFirestore.instance.collection('packages').doc(id).update({
      'clientFirstName': clientFirstName,
      'clientLastName': clientLastName,
      'clientUid': clientUid,
      'dateTime': dateTime,
      'dateTimeDisplay': dateTimeDisplay,
      'description': description,
      'fromLocation': fromLocation,
      'toLocation': toLocation,
      'packageId': packageId,
      'packageName': packageName,
      'status': 'Completed',
    }).then((value) {
      getOrders(fromCompleteOrder: true, context: context);
      showToast(
          msg: 'The order is Completed',
          color: buttonColor,
          textColor: Colors.white);
      // emit(FoxCompleteOrderSuccessState());
    }).catchError((error) {
      showToast(msg: 'Error', color: Colors.red, textColor: Colors.white);
      print("Error while complete order ====> ${error.toString()}");
      emit(FoxCompleteOrderErrorState());
    });
  }

  bool isSameTime({
    required String date1,
    required DateTime date2,
  }) {
    if (num.parse(date1.substring(0, 4)).toString() == date2.year.toString() &&
        num.parse(date1.substring(5, 7)).toString() == date2.month.toString() &&
        num.parse(date1.substring(8, 10)).toString() == date2.day.toString()) {
      return true;
    } else {
      return false;
    }
  }

  void getProblems({required bool fromStart}) {
    problems = [];
    if (fromStart == false) {
      emit(FoxGetProblemsLoadingState());
    }
    FirebaseFirestore.instance
        .collection('problem')
        .orderBy('dateTime', descending: false)
        .get()
        .then((value) {
      for (var element in value.docs) {
        problems.add(ProblemModel.fromJson(element.data()));
      }
      emit(FoxGetProblemsSuccessState());
    }).catchError((error) {
      emit(FoxGetProblemsErrorState());
    });
  }
}
