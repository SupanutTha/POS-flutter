import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AllRoom extends StatelessWidget {
  
  @override
  Widget build(BuildContext context) {
    Future<List<Map<String, dynamic>>> retrieveRoom() async {
      try{
      final response = await http.get(
        Uri.parse('http://localhost:4200/rooms'), // Replace with your API endpoint
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'x-api-key':'c65f213d-c776-4781-8fda-26b3be0b22b8'
        },
      );
      print(response.body);

      if (response.statusCode == 200) {
        List<Map<String, dynamic>> roomData =
            List<Map<String, dynamic>>.from(json.decode(response.body));
        return roomData;
        // Handle success, e.g., navigate to a success screen
      } else {
        print('Failed to create room. Status code: ${response.statusCode}');
        return [];
        // Handle error, e.g., show an error message to the user
      }
      }catch(error){
        print('Error: $error');
        return [];
      }
    }
    print (retrieveRoom());
    
    //var room_data = retrieveRoom();
    //print(room_data);
    return Scaffold(
      appBar:  AppBar(
        title: const Text("All rooms")
      ),
      body: FutureBuilder<List<Map<String , dynamic>>>(
        future: retrieveRoom(),
        builder:(context, snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Text('No data available');
          } else {
             return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    Text(snapshot.data![index]['roomNumber']),
                    Text(snapshot.data![index]['roomType']),
                    Divider(),
                  ],
                );
                // return ListTile(
                //   title: Text(snapshot.data![index]['roomNumber']),
                //   // Add other widgets to display additional data
                // );
              },
             );
          }

        }
         ,)

    );
  }

}