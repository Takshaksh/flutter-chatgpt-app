import 'package:flutter/material.dart';
import 'package:flutter_chatgpt/src/utils/constants.dart';

import '../../utils/colors.dart';

class ModelDropDownWidget extends StatefulWidget{
  const ModelDropDownWidget({super.key});
  
  @override
  State<StatefulWidget> createState() => _ModelDropDownWidgetState();
}

class _ModelDropDownWidgetState extends State<ModelDropDownWidget>{
  String currentModel = "ChatGPT 4";

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      dropdownColor: Rang.backgroundColor,
      iconEnabledColor: Rang.textColor,
      style: const TextStyle(color: Rang.textColor),
      items: getDataModelItems,
      value: currentModel,
      onChanged: (value) {
        setState(() {
          currentModel = value.toString();
        });
      },
    );
  }

}