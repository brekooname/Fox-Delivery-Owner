import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fox_delivery_owner/shared/components/components.dart';
import 'package:fox_delivery_owner/shared/cubit/cubit.dart';
import 'package:fox_delivery_owner/shared/cubit/states.dart';
import 'package:fox_delivery_owner/styles/Themes.dart';

class Offers extends StatelessWidget {
  var labelController = TextEditingController();
  var bodyController = TextEditingController();
  var formKey = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FoxCubit, FoxStates>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Create Offer'),
          ),
          body: CustomScrollView(
            slivers: [
              SliverFillRemaining(
                hasScrollBody: false,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        textFormFieldWithHint(
                            context: context,
                            controller: labelController,
                            validation: 'Enter Label',
                            label: 'Label',
                            type: TextInputType.text),
                        const SizedBox(
                          height: 10.0,
                        ),
                        textFormFieldWithHint(
                            context: context,
                            controller: bodyController,
                            validation: 'Enter body',
                            label: 'Body',
                            type: TextInputType.text),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultButton(
                            text: 'Pick Image',
                            backgroundColor: buttonColor,
                            borderRadius: 5.0,
                            TextColor: Colors.white,
                            fun: () {
                              FoxCubit.get(context).getOfferImage();
                            }),
                        const SizedBox(
                          height: 10.0,
                        ),
                        if (FoxCubit.get(context).offerImage != null)
                          Stack(
                            children: [
                              Container(
                                height: 200,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: FileImage(
                                                FoxCubit.get(context).offerImage!)
                                            as ImageProvider)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: CircleAvatar(
                                  radius: 16,
                                  child: IconButton(
                                      onPressed: () {
                                        FoxCubit.get(context).removeOfferImage();
                                      },
                                      icon: const Icon(
                                        Icons.close,
                                        size: 16,
                                      )),
                                ),
                              ),
                            ],
                          ),
                        Spacer(),
                        const SizedBox(
                          height: 10.0,
                        ),
                        defaultButton(
                            text: 'Create Offer',
                            fun: () {
                              if(formKey.currentState!.validate() && FoxCubit.get(context).offerImage != null){
                                FoxCubit.get(context).uploadOfferImage(
                                    label: labelController.text,
                                    body: bodyController.text);
                              }
                            },
                            backgroundColor: buttonColor,
                            borderRadius: 5.0,
                            TextColor: Colors.white)
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
