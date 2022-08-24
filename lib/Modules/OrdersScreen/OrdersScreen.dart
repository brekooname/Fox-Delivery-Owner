import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/constants/constants.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';
import 'package:intl/intl.dart';
import 'package:table_calendar/table_calendar.dart';

import '../../Models/PackageModels.dart';
import 'PackageDetailsScreen.dart';

class OrdersScreen extends StatefulWidget {
  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  DateTime focusedDay = DateTime.now();

  CalendarFormat calendarFormat = CalendarFormat.week;

  @override
  void initState() {
    // FoxCubit.get(context).getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(selectedOrders.length);
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            actions: [
              DateFormat.yMd().format(FoxCubit.get(context).selectedDay) !=
                      DateFormat.yMd().format(DateTime.now())
                  ? TextButton(
                      onPressed: () {
                        setState(() {
                          FoxCubit.get(context).goToToday();
                        });
                      },
                      child: const Text(
                        "TODAY",
                        style: TextStyle(
                            color: Colors.white, fontWeight: FontWeight.bold),
                      ))
                  : Container()
            ],
            title: Text(
              'Orders',
              style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 20),
            ),
            backgroundColor: secondDefaultColor,
            elevation: 0.0,
          ),
          body: /*state is FoxGetOrdersLoadingState || state is FoxSetSelectedDateLoadingState
              ? const Center(
                  child: CircularProgressIndicator(
                  color: Colors.white,
                ))
              :*/
              Container(
            color: thirdDefaultColor,
            child: Column(
              children: [
                Stack(
                  alignment: Alignment.topCenter,
                  children: [
                    Container(
                      color: secondDefaultColor,
                      height: 50,
                      width: double.infinity,
                    ),
                    TableCalendar(
                      firstDay:
                          DateTime.now().subtract(const Duration(days: 365)),
                      lastDay: DateTime.now().add(const Duration(days: 630)),
                      focusedDay: focusedDay,
                      selectedDayPredicate: (day) {
                        return isSameDay(
                            FoxCubit.get(context).selectedDay, day);
                      },
                      onDaySelected: (selectedDay, focusedDay) {
                        FoxCubit.get(context)
                            .setSelectedDate(newDate: selectedDay);
                        // this.selectedDay = selectedDay;
                        this.focusedDay =
                            focusedDay; // update `_focusedDay` here as well
                      },
                      onPageChanged: (focusedDay) {
                        focusedDay = focusedDay;
                      },
                      calendarFormat: calendarFormat,
                      daysOfWeekHeight: 50,
                      daysOfWeekStyle: const DaysOfWeekStyle(
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(20),
                                  topLeft: Radius.circular(20)))),
                      headerStyle: const HeaderStyle(
                        decoration: BoxDecoration(
                          color: Colors.white,
                        ),
                      ),
                      calendarStyle: CalendarStyle(
                          weekendTextStyle:
                              const TextStyle(color: Colors.black),
                          defaultTextStyle: TextStyle(color: Colors.black),
                          holidayTextStyle:
                              const TextStyle(color: Colors.black),
                          selectedTextStyle: TextStyle(
                              color: thirdDefaultColor,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                          rowDecoration: const BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  bottomLeft: Radius.circular(20),
                                  bottomRight: Radius.circular(20.0))),
                          selectedDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20.0)),
                          isTodayHighlighted: false,
                          defaultDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          holidayDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0)),
                          weekendDecoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10.0))),
                      headerVisible: false,
                    ),
                  ],
                ),
                state is FoxGetOrdersLoadingState ||
                        state is FoxSetSelectedDateLoadingState
                    ? Expanded(
                      child: Center(
                          child: CircularProgressIndicator(
                            backgroundColor: secondDefaultColor,
                          color: Colors.white,
                        )),
                    )
                    : Expanded(
                        child: Column(
                          children: [
                            selectedOrders.isEmpty
                                ? Expanded(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          'No Items',
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyText1!
                                              .copyWith(
                                                  color: Colors.white,
                                                  fontSize: 25,
                                                  fontWeight: FontWeight.bold),
                                        )
                                      ],
                                    ),
                                  )
                                : Expanded(
                                    child: ListView.separated(
                                        itemBuilder: (context, index) {
                                          return packageItemBuilder(
                                              model: selectedOrders[index],
                                              index: index);
                                        },
                                        separatorBuilder: (context, index) {
                                          return const SizedBox(
                                            height: 10.0,
                                          );
                                        },
                                        itemCount: selectedOrders.length))
                          ],
                        ),
                      )

                // const SizedBox(
                //   height: 20.0,
                // ),
                // defaultButton(text: 'test1', fun: (){
                //   // print(orders[4].dateTime);
                //   // print(FoxCubit.get(context).selectedDay);
                //   // print(DateFormat.yMd().format(FoxCubit.get(context).selectedDay));
                //   print('1..${FoxCubit.get(context).selectedDay}');
                //   print('2...${orders[4].dateTime}');
                //   print('3...${orders[4].dateTime!.substring(8,10)}');
                //
                //   if(FoxCubit.get(context).selectedDay.month.toString() == num.parse(orders[4].dateTime!.substring(5,7)).toString()){
                //     print("YES");
                //   }else{
                //     print('no');
                //     print(FoxCubit.get(context).selectedDay.month.toString());
                //     print(num.parse(orders[4].dateTime!.substring(5,7)));
                //   }
                // }),
                // const SizedBox(
                //   height: 20.0,
                // ),
                // defaultButton(text: 'test', fun: (){
                //   print(FoxCubit.get(context).selectedDay);
                // })
              ],
            ),
          ),
        );
      },
    );
  }

  Widget packageItemBuilder({required PackageModel model, required int index}) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(model.packageName!,
                        style: Theme.of(context).textTheme.bodyText1),
                    const SizedBox(
                      height: 10,
                    ),
                    Text(model.dateTimeDisplay!,
                        style: Theme.of(context)
                            .textTheme
                            .caption!
                            .copyWith(fontSize: 14))
                  ],
                ),
              ),
              Column(
                children: [
                  defaultButton(
                      text: 'details',
                      fun: () {
                        navigateTo(
                            context,
                            PackageDetailsScreen(
                              packageIndex: index,
                              package: selectedOrders[index],
                            ));
                      },
                      width: 100,
                      backgroundColor: thirdDefaultColor,
                      TextColor: Colors.white)
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
