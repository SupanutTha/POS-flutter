import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import '../style/app_style.dart';
import '../widgets/dropdown.dart';
import '../widgets/imagePicker.dart';
import 'package:http/http.dart' as http;

class AddRoom extends StatefulWidget {
  @override
  _AddRoomState createState() => _AddRoomState();
}

class _AddRoomState extends State<AddRoom> {
  late TextEditingController _roomNumberController;
  late TextEditingController _roomTypeController;
  late TextEditingController _descriptionController;
  late TextEditingController _bedNumberController;
  late List<TextEditingController> _bedTypeControlers = [];
  late TextEditingController _smokingController;
  late TextEditingController _bathTubController;
  late TextEditingController _balconyController;
  late TextEditingController _rate;
  @override
  void initState() {
    super.initState();
    _roomNumberController = TextEditingController();
    _roomTypeController = TextEditingController();
    //_bedTypeControlers = [TextEditingController()];
    _bedTypeControlers = [TextEditingController(text: "single bed")];
    _descriptionController = TextEditingController();
    _roomTypeController.text = "Standard";
    _bedNumberController = TextEditingController();
    _bedNumberController.text = "1";
    _smokingController = TextEditingController( text:"false");
    _bathTubController = TextEditingController( text: "false");
    _balconyController = TextEditingController( text: "false");
    _rate = TextEditingController();
  }

  List<String> convertControllersToStringList(List<TextEditingController> controllers) {
  List<String> result = [];
  for (TextEditingController controller in controllers) {
    result.add(controller.text);
  }
  return result;
}

  bool smoke =  false;
  bool bathTub = false;
  bool balcony = false;
  List<File?> _selectedImages = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add room", style: AppTextStyles.welcomeText),
        actions: [],
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              Row(// first row
                children: [
                  Expanded(// Room number
                    flex: 1,
                    child: TextField(
                      //room number
                      controller: _roomNumberController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Room Number",
                      ),
                    ),
                  ),
                  Expanded(// Room Type
                    flex: 1,
                    child: CustomDropdownMenu(
                      controller: _roomTypeController,
                      dropList: ['Standard', 'Deluxe', 'Suite', 'Family Room'],
                    ),
                  ),
                ],
              ),
              Row(//number of bed
                children: [
                  Expanded(
                    flex: 2,
                    child: (Text("Number of bed")),
                  ),
                  Expanded(
                    flex: 1,
                    child: (Text(_bedNumberController.text)),
                  ),
                  Expanded(
                    flex: 1,
                    child: (IconButton(
                      icon: Icon(
                        Icons.remove,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        if (_bedTypeControlers.length != 1) {
                          setState(() {
                            _bedNumberController.text =
                                (int.parse(_bedNumberController.text) - 1)
                                    .toString();
                            _bedTypeControlers.removeLast();
                            print(_bedTypeControlers.length);
                          });
                        }
                      },
                    )),
                  ),
                  Expanded(
                    flex: 1,
                    child: (IconButton(
                      icon: Icon(
                        Icons.add,
                        color: Colors.green,
                      ),
                      onPressed: () {
                        setState(() {
                          _bedNumberController.text =
                              (int.parse(_bedNumberController.text) + 1)
                                  .toString();
                          _bedTypeControlers
                              .add(TextEditingController(text: "single bed"));
                          print(_bedTypeControlers.length);
                        });
                      },
                    )),
                  ),
                ],
              ),
              ListView.builder(//bed type
                  shrinkWrap: true,
                  itemCount: int.parse(_bedNumberController.text),
                  itemBuilder: (context, index) {
                    return Row(
                      children: [
                        Expanded(flex: 1, child: Text("Bed ${index + 1}")),
                        Expanded(
                            flex: 1,
                            child: CustomDropdownMenu(
                              controller: _bedTypeControlers[index],
                              dropList: ['Single Bed', 'Double Bed'],
                            )),
                      ],
                    );
                  }),
              Text("feature"),
              Column( // feature
                children: [
                    CheckboxListTile(
                      activeColor: Colors.green,
                      value: smoke ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          smoke = value!;
                          // print("smoke $smoke");
                          // print("value $value");
                        });
                      },
                      title: const Text('Smoke room'),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      value: bathTub ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          bathTub = value!;
                          // print("smoke $bathTub");
                          // print("value $value");
                        });
                      },
                      title: const Text('bathTub'),
                    ),
                    CheckboxListTile(
                      activeColor: Colors.green,
                      value: balcony ?? false,
                      onChanged: (bool? value) {
                        setState(() {
                          balcony = value!;
                          // print("smoke $balcony");
                          // print("value $value");
                        });
                      },
                      title: const Text('Balcony'),
                    ),
                ],
                
              ),
              Row(// description
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _descriptionController,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Description",
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: TextField(
                      controller: _rate,
                      decoration: InputDecoration(
                        border: UnderlineInputBorder(),
                        labelText: "Rate",
                      ),
                    ),
                    )
                ],
              ),
              CustomImagePicker(
                onImagesSelected: (images){
                  setState(() {
                    _selectedImages = images;
                  });
                },
              ),
              Container(
                child: Text("test"),
              )
            ],
          ),
        ),
      ),
      floatingActionButton : FloatingActionButton(
  onPressed: () {
    // Build and show the confirmation dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirmation"),
          content: Text("Are you sure you want to proceed?"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // Close the dialog
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // Close the dialog with a confirmation flag
              },
              child: Text("Confirm"),
            ),
          ],
        );
      },
    ).then((confirmed) async {
      // The code inside this block will be executed after the dialog is closed
      if (confirmed != null && confirmed) {
        // User confirmed, proceed with the actions
        List<String> bedTypeStrings = convertControllersToStringList(_bedTypeControlers);
        _smokingController.text = smoke.toString();
        _bathTubController.text = bathTub.toString();
        _balconyController.text = balcony.toString();
        print("room number: ${_roomNumberController.text}");
        print('room type: ${_roomTypeController.text}');
        print(_bedNumberController.text);
        print(bedTypeStrings);
        print(_smokingController.text);
        print(_bathTubController.text);
        print(_balconyController.text);
        print(_descriptionController.text);
        print(_selectedImages);
        print(_rate.text);
        print("done");
        // Create a Map to represent the room data
      Map<String, dynamic> roomData = {
        'roomNumber': _roomNumberController.text,
        'roomType': _roomTypeController.text,
        'rate': {
            'baseRate': int.parse(_rate.text), // Replace with your actual base rate
            'currency': 'THB',
        },
        'amenities': [], // You can add amenities here
        'description': _descriptionController.text,
        'features': {
            'beds': int.parse(_bedNumberController.text),
            'bedType': 'Single Bed', // Replace with the actual bed type
            'maxOccupancy': 2, // Replace with the actual max occupancy
            'isSmokingAllowed': smoke,
            'hasBathtub': bathTub,
            'hasBalcony': balcony,
        },
        // ... other fields
    };


      // Send a POST request to your API
      try{
      final response = await http.post(
        Uri.parse('http://localhost:4200/rooms'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key':'c65f213d-c776-4781-8fda-26b3be0b22b8'
        },
        body: jsonEncode(roomData),
      );
      print(roomData);

      if (response.statusCode == 201) {
        print('Room created successfully');
        // Handle success, e.g., navigate to a success screen
      } else {
        print('Failed to create room. Status code: ${response.statusCode}');
        // Handle error, e.g., show an error message to the user
      }
      }catch(error){
        print('Error: $error');
      }

      }
    });
  },
)

      // floatingActionButton: FloatingActionButton(
      //   onPressed: () {
      //     List<String> bedTypeStrings = convertControllersToStringList(_bedTypeControlers);
      //     _smokingController.text = smoke.toString();
      //     _bathTubController.text = bathTub.toString();
      //     _balconyController.text = balcony.toString();
      //     print("roomnumber :  ${_roomNumberController.text}");
      //     print('room type : ${_roomTypeController.text}');
      //     print(_bedNumberController.text);
      //     print(bedTypeStrings);
      //     print( _smokingController.text);
      //     print( _bathTubController.text);
      //     print( _balconyController.text);
      //     print(_descriptionController.text);
      //     print(_selectedImages);
      //     print("done");
          
      //   },
      // ),
    );
  }
}
