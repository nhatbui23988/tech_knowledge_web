import 'package:flutter/material.dart';

class DropdownWidget extends StatelessWidget {
  const DropdownWidget({Key? key, required this.listItem, this.currentValue, this.hintText, required this.onChanged}) : super(key: key);
  final List<String> listItem;
  final String? currentValue;
  final String? hintText;
  final Function(String?) onChanged;
  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: currentValue,
        hint: Text(hintText??''),
        items: List.generate(listItem.length,
            (index) => DropdownMenuItem(value: listItem[index], child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(listItem[index]),
            ))),
        onChanged: onChanged);
  }
}
