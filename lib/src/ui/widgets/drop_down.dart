import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/data/providers/common_providers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/model_model.dart';
import '../../data/response/model_response.dart';
import '../../utils/colors.dart';

class ModelDropDownWidget extends ConsumerWidget{
  const ModelDropDownWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final modelsAsyncValue = ref.watch(modelsProvider);

    return modelsAsyncValue.when(
      loading: () => const CircularProgressIndicator(),
      data: (models){
        return DropdownButton(
          dropdownColor: Rang.backgroundColor,
          iconEnabledColor: Rang.textColor,
          style: const TextStyle(color: Rang.textColor),
          items: getDropdownMenuItems(dataModelList: models.data),
          onChanged: (value) {
            // Handle onChanged event
          },
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




// class ModelDropDownWidget extends StatefulWidget{
//   const ModelDropDownWidget({super.key});
  
//   @override
//   State<StatefulWidget> createState() => _ModelDropDownWidgetState();
// }

// class _ModelDropDownWidgetState extends State<ModelDropDownWidget>{
//   String currentModel = "ChatGPT 4";

//   @override
//   Widget build(BuildContext context) {
//     return DropdownButton(
//       dropdownColor: Rang.backgroundColor,
//       iconEnabledColor: Rang.textColor,
//       style: const TextStyle(color: Rang.textColor),
//       items: getDataModelItems,
//       value: currentModel,
//       onChanged: (value) {
//         setState(() {
//           currentModel = value.toString();
//         });
//       },
//     );
//   }
// }