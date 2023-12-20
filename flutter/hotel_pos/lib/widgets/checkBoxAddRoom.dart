import 'package:flutter/material.dart';


class CheckboxAddRoom extends StatefulWidget {

   CheckboxAddRoom ({
    super.key,
    });

  @override
  State<CheckboxAddRoom > createState() => _CheckboxAddRoomeState();
}


class _CheckboxAddRoomeState extends State<CheckboxAddRoom> {
  late bool checkboxValue1;
  late String checkStatus;
  @override
  void initState() {
    super.initState();
    }

  @override
  Widget build(BuildContext context) {
    return CheckboxListTile(
            value: checkboxValue1,
            onChanged: (bool? value) {
              setState(() {
                checkboxValue1 = value!;
              });
            },
            title: const Text('Headline'),
            subtitle: const Text('Supporting text'),
          );
    }
}