import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/PackageModels.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';
import 'package:get/get.dart';

import '../../shared/constants/constants.dart';
import '../../shared/cubit/states.dart';

class PackageContent extends StatelessWidget {
  final bool fromTracking;
  final int packageIndex;
  PackageModel package;

  PackageContent(
      {required this.package,
      required this.packageIndex,
      required this.fromTracking});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: Get.height * 0.30,
                decoration: BoxDecoration(color: thirdDefaultColor),
                child: Stack(
                  children: [
                    Container(
                      height: Get.height * 0.20,
                      color: secondDefaultColor,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          height: Get.height * 0.25,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: secondDefaultColor,
                                  backgroundImage: const AssetImage(
                                      'assets/images/package3.png'),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  textDirection: TextDirection.ltr,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      // userPackages[packageIndex]
                                      package.clientFirstName!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: secondDefaultColor),
                                    ),
                                    Text(
                                      ' ${package.clientLastName!} ',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(color: secondDefaultColor),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10.0,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'package_id'.tr,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: secondDefaultColor,
                                              fontSize: 16),
                                    ),
                                    Text(
                                      ': ${
                                      // userPackages[packageIndex]
                                      package.packageId!}',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!
                                          .copyWith(
                                              color: secondDefaultColor,
                                              fontSize: 16),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: thirdDefaultColor,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Table(
                        textBaseline: TextBaseline.alphabetic,
                        border: TableBorder.symmetric(
                            inside: const BorderSide(color: Colors.white)),
                        children: [
                          buildTableRow('package_id'.tr,
                              "${/*userPackages[packageIndex]*/ package.packageId}"),
                          buildTableRow('client_name'.tr,
                              "${/*userPackages[packageIndex]*/ package.clientFirstName} ${/*userPackages[packageIndex]*/ package.clientLastName}"),
                          buildTableRow('package_name'.tr,
                              "${/*userPackages[packageIndex]*/ package.packageName}"),
                          buildTableRow('package_description'.tr,
                              "${/*userPackages[packageIndex]*/ package.description}"),
                          buildTableRow('package_from'.tr,
                              "${/*userPackages[packageIndex]*/ package.fromLocation}"),
                          buildTableRow('package_to'.tr,
                              "${/*userPackages[packageIndex]*/ package.toLocation}"),
                          buildTableRow('order_time'.tr,
                              "${/*userPackages[packageIndex]*/ package.dateTimeDisplay}"),
                          buildTableRow('status'.tr,
                              "${/*userPackages[packageIndex]*/ package.status}"),
                        ],
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: [
                          Expanded(
                            child: defaultButton(
                                text: 'ok',
                                fun: () {
                                  Navigator.pop(context);
                                },
                                borderRadius: 15,
                                TextColor: Colors.white,
                                backgroundColor: buttonColor),
                          ),
                          if (/*userPackages[packageIndex]*/ package.status ==
                              'New')
                            SizedBox(
                              width: 10,
                            ),
                          Expanded(
                            child: defaultButton(
                                text: 'Complete Order',
                                fun: () {
                                  FoxCubit.get(context).completeOrder(
                                      context: context,
                                      idNumber: packageIndex,
                                      id: packagesID[packageIndex],
                                      clientFirstName: /*userPackages[packageIndex]*/ package
                                          .clientFirstName!,
                                      clientLastName:
                                          /*userPackages[packageIndex]*/ package
                                              .clientLastName!,
                                      clientUid:
                                          /*userPackages[packageIndex]*/ package
                                              .clientUid!,
                                      dateTime: /*userPackages[packageIndex]*/ package
                                          .dateTime!,
                                      dateTimeDisplay:
                                          /*userPackages[packageIndex]*/ package
                                              .dateTimeDisplay!,
                                      description:
                                          /*userPackages[packageIndex]*/ package
                                              .description!,
                                      fromLocation:
                                          /*userPackages[packageIndex]*/ package
                                              .fromLocation!,
                                      toLocation:
                                          /*userPackages[packageIndex]*/ package
                                              .toLocation!,
                                      packageId:
                                          /*userPackages[packageIndex]*/ package
                                              .packageId!,
                                      packageName:
                                          /*userPackages[packageIndex]*/ package
                                              .packageName!);
                                },
                                backgroundColor: Colors.amber,
                                TextColor: Colors.white),
                          )
                        ],
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }

  TableRow buildTableRow(String text1, String text2) {
    return TableRow(
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
                color: Colors.white,
              ),
              top: BorderSide(
                color: Colors.white,
              ),
              right: BorderSide(color: Colors.white),
              left: BorderSide(color: Colors.white))),
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text1,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Text(
            text2,
            style: TextStyle(color: Colors.white, fontSize: 15),
          ),
        ),
      ],
    );
  }
}
