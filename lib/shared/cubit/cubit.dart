import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/PackageModels.dart';
import 'package:fox_delivery_owner/Modules/AllOrdersScreen/AllOrdersScreen.dart';
import 'package:fox_delivery_owner/Modules/OrdersScreen/OrdersScreen.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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
    const BottomNavigationBarItem(icon: Icon(Icons.backpack), label: 'Orders'),
    const BottomNavigationBarItem(icon: Icon(Icons.border_all), label: 'All Orders'),
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
        packagesID.add(element.id);

      }
      setSelectedDate(newDate: DateTime.now());
      emit(FoxGetOrdersSuccessState());
    }).catchError((error) {
      emit(FoxGetOrdersErrorState());
    });
  }

  void goToToday() {
    selectedDay = DateTime.now();
    setSelectedDate(newDate: selectedDay);
  }

  void checkConnection() async {
    internetConnection = await InternetConnectionChecker().hasConnection;
    if (internetConnection) {
      getOrders();;
      // getPackagesNumber();
    } else {
      Get.snackbar('Fox Delivery', 'No Internet Connection',
          colorText: Colors.white, backgroundColor: Colors.red);
    }
  }

  void completeOrder({
    required BuildContext context,
    required int idNumber,
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
      getOrders();
      showToast(msg: 'The order is Completed');
    }).catchError((error) {
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

  void setSelectedDate({
    required DateTime newDate,
    bool fromStart = false,
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
}
