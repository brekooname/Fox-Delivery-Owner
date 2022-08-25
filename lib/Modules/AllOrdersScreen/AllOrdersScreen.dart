import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/PackageModels.dart';
import 'package:fox_delivery_owner/Modules/OrdersScreen/PackageDetailsScreen.dart';
import 'package:fox_delivery_owner/shared/constants/constants.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:get/get.dart';

import '../../shared/components/components.dart';
import '../../styles/Themes.dart';

class AllOrderScreen extends StatefulWidget {
  @override
  State<AllOrderScreen> createState() => _AllOrderScreenState();
}

class _AllOrderScreenState extends State<AllOrderScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
              title: Text(
            'All Orders',
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
          )),
          body: state is FoxGetOrdersLoadingState ||
                  state is FoxCompleteOrderLoadingState
              ? CircularProgressIndicator(
                  color: buttonColor,
                  backgroundColor: thirdDefaultColor,
                )
              : Column(
                  children: [
                    orders.isNotEmpty
                        ? Expanded(
                            child: ListView.separated(
                                physics: const BouncingScrollPhysics(),
                                itemBuilder: (context, index) {
                                  return packageItemBuilder(
                                      model: orders[index], index: index);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10,
                                  );
                                },
                                itemCount: orders.length),
                          )
                        : Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.work_off,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'No Packages Yet',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    internetConnection == false
                                        ? Column(
                                            children: [
                                              const SizedBox(
                                                height: 20.0,
                                              ),
                                              defaultButton(
                                                  text: 'Refresh',
                                                  TextColor: Colors.white,
                                                  borderRadius: 5.0,
                                                  backgroundColor: buttonColor,
                                                  width: Get.width * 0.3,
                                                  fun: () {
                                                    FoxCubit.get(context)
                                                        .checkConnection();
                                                  }),
                                            ],
                                          )
                                        : Container()
                                  ],
                                ),
                              ),
                            ),
                          ),
                  ],
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
                    Text(
                      model.packageName!,
                      style: Theme.of(context).textTheme.bodyText1,
                    ),
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
                              package: orders[index],
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
