import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/data/providers/common_providers.dart';
import 'package:flutter_chatgpt/src/utils/constants.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/model_model.dart';
import '../../utils/colors.dart';

class ModelDropDownWidget extends ConsumerWidget{
  const ModelDropDownWidget({super.key});

  getPrefModelList() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    var data = sharedPreferences.getString(Constants.prefModels);
    
    return data;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedModel = ref.watch(selectedModelProvider);
    final sharedPref = ref.watch(sharedPrefProvider).value;
    final prefModelListFuture = ref.watch(prefModelListProvider.future);

    return FutureBuilder<String?>(
      future: prefModelListFuture,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          final value = snapshot.data;
          if (value != 'null' && value != '') {
            List<dynamic> jsonList = jsonDecode(value!);
            List<Model> modelList = jsonList.map((json) => Model.fromJson(json)).toList();

            return getDropdownButton(ref, selectedModel, modelList);
          } else {
            final modelsAsyncValue = ref.watch(modelsProvider);
            return modelsAsyncValue.when(
              loading: () => const Padding(
                padding: EdgeInsets.all(16.0),
                child: SpinKitThreeBounce(color: Rang.whiteColor, size: 24,),
              ),
              data: (models) {
                List<Map<String, dynamic>> jsonList = models.data.map((model) => model.toJson()).toList();
                sharedPref?.setString(Constants.prefModels, jsonEncode(jsonList));
                return getDropdownButton(ref, selectedModel, models.data);
              },
              error: (error, stackTrace) {
                log("Error in Dropdown error: ${error.toString()}");
                return const Text("Models not loaded, try again.");
              },
            );
          }
        } else if (snapshot.hasError) {
          return Text("Error: ${snapshot.error}");
        } else {
          return const SizedBox(); // Placeholder widget while loading
        }
      },
    );
  }

  Widget getDropdownButton(WidgetRef ref, String selectedModel, List<Model> modelList){
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
        items: getDropdownMenuItems(dataModelList: modelList),
        value: selectedModel != '' ? selectedModel : null,
        onChanged: (value) {
          ref.read(selectedModelProvider.notifier).state = value!;
          Fluttertoast.showToast(msg: "Model selected → $value");
        },
      ),
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
