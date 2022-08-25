import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/ProblemModel.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';

class ProblemDetails extends StatelessWidget {
  final ProblemModel problem;

  ProblemDetails(this.problem);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(),
          body: CustomScrollView(
            physics: ScrollPhysics(),
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      problemBuilder(model: problem, context: context)
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

  Widget problemBuilder(
      {required ProblemModel model, required BuildContext context}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        rowBuilder(text1: 'Problem: ', text2: model.problem!, context: context),
        myDivider(color: Colors.white, paddingVertical: 16.0),
        rowBuilder(
            text1: 'Client Name: ',
            text2: "${model.clientFirstName} ${model.clientLastName}",
            context: context),
        myDivider(color: Colors.white, paddingVertical: 15.0),
        rowBuilder(
            text1: 'Client Phone: ',
            text2: model.phoneNumber!,
            context: context),
        myDivider(color: Colors.white, paddingVertical: 15.0),
        rowBuilder(
            text1: 'Date of report: ',
            text2: model.dateTimeDisplay!,
            context: context),

      ],
    );
  }

  Widget rowBuilder(
      {required String text1,
      required String text2,
      required BuildContext context}) {
    return Wrap(
      children: [
        Text(
          text1,
          style: Theme.of(context)
              .textTheme
              .bodyText1!
              .copyWith(color: thirdDefaultColor),
        ),
        Text(
          text2,
          style: Theme.of(context).textTheme.bodyText1!.copyWith(
                color: Colors.white,
              ),
        )
      ],
    );
  }
}
