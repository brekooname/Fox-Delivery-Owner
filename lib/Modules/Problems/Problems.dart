import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/Models/ProblemModel.dart';
import 'package:fox_delivery_owner/Modules/Problems/ProblemsDetailsScreen.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/constants/constants.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:get/get.dart';

import '../../styles/Themes.dart';

class Problems extends StatefulWidget {
  @override
  State<Problems> createState() => _ProblemsState();
}

class _ProblemsState extends State<Problems> {
  @override
  void initState() {
    // FoxCubit.get(context).getProblems();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Problems',
              style: Theme.of(context)
                  .textTheme
                  .bodyText1!
                  .copyWith(color: Colors.white),
            ),
          ),
          body: state is FoxGetProblemsLoadingState
              ? Center(
                  child: CircularProgressIndicator(
                    color: thirdDefaultColor,
                    backgroundColor: Colors.white,
                  ),
                )
              : Column(
                  children: [
                    problems.isEmpty
                        ? Expanded(
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.emoji_emotions_outlined,
                                      color: Colors.white,
                                      size: 50.0,
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    const Text(
                                      'No Problems',
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
                          )
                        : Expanded(
                            child: ListView.separated(
                                itemBuilder: (context, index) {
                                  return problemBuilder(model: problems[index]);
                                },
                                separatorBuilder: (context, index) {
                                  return const SizedBox(
                                    height: 10.0,
                                  );
                                },
                                itemCount: problems.length),
                          ),
                  ],
                ),
        );
      },
    );
  }

  Widget problemBuilder({required ProblemModel model}) {
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
                    Row(
                      children: [
                        Text(
                          '${model.clientFirstName!} ',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                        Text(
                          model.clientLastName!,
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ],
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
                        navigateTo(context, ProblemDetails(model));
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
