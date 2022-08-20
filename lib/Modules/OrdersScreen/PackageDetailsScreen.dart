import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/PackageModels.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';

import 'PackageContentScreen.dart';

class PackageDetailsScreen extends StatelessWidget {
  final int packageIndex;
  final PackageModel package;

  PackageDetailsScreen({required this.packageIndex, required this.package});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {
        if(state is FoxGetOrdersLoadingState){}
      },
      builder: (context, state) {
        return Scaffold(
            backgroundColor: thirdDefaultColor,
            body: CustomScrollView(
              slivers: [
                SliverAppBar(
                  backgroundColor: secondDefaultColor,
                ),
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: state is FoxGetOrdersLoadingState
                      ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white,
                    ),
                  )
                      : PackageContent(
                    fromTracking: false,
                    package: package,
                    packageIndex: packageIndex,
                  ),
                )
              ],
            ));
      },
    );
  }
}
