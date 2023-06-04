import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/data/providers/common_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../data/models/model_model.dart';
import '../../data/response/model_response.dart';
import '../../utils/colors.dart';

class ModelDropDownWidget extends ConsumerWidget{
  const ModelDropDownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAsyncValue = ref.watch(modelsProvider);
    final selectedModel = ref.watch(selectedModelProvider);

    return modelsAsyncValue.when(
      loading: () => const Padding(
        padding: EdgeInsets.all(16.0),
        child: SpinKitThreeBounce(color: Rang.whiteColor, size: 24,),
      ),
      data: (models){
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Rang.cardBackgroundColor
          ), 
          child: DropdownButton(
            dropdownColor: Rang.backgroundColor,
            iconEnabledColor: Rang.textColor,
            underline: Container(),
            style: const TextStyle(color: Rang.textColor),
            padding: const EdgeInsets.all(8),
            borderRadius: const BorderRadius.all(Radius.circular(16)),
            hint: const Text("Select a model", style: TextStyle(color: Rang.textColor),),
            items: getDropdownMenuItems(dataModelList: models.data),
            value: selectedModel != '' ? selectedModel : null,
            onChanged: (value) {
              ref.read(selectedModelProvider.notifier).state = value!;
              Fluttertoast.showToast(msg: "Selected → $value");
            },
          ),
        );
      }, 
      error: (error, stackTrace) {
        log("Error in Dropdown error: ${error.toString()}");
        // log("Error in Dropdown stackTrace: $stackTrace");
        return const Text("Models not loaded, try again.");
      }, 
    );
  }

  List<DropdownMenuItem<String>> getDropdownMenuItems({required List<Model> dataModelList }){
    var dataModelItems = List<DropdownMenuItem<String>>.generate(
      dataModelList.length, 
      (index) => DropdownMenuItem(
        value: dataModelList[index].id,
        child: Text(
          dataModelList[index].id
        )
      )
    );

    return dataModelItems;
  }
}
