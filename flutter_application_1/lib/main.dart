import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp( {super.key}) ;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              onPressed: () {
                _getCurrentLocation(context); // Call method to get current location
              },
              child: Text("Get Current Location"),
            ),
          ),
        ),
      ),
    );
  }

  // Method to get current location
  void _getCurrentLocation(BuildContext context) async {
    var status = await Permission.location.status;
    if (status.isDenied || status.isRestricted) {
      // Location permission is denied or restricted, request permission from the user
      status = await Permission.location.request();
      if (status.isDenied || status.isRestricted) {
        // Permission still not granted, show a message to the user
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text("Permission Required"),
              content:
                  Text("Location permission is required to use this feature."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text("OK"),
                ),
              ],
            );
          },
        );
        return; // Exit the method
      }
    }
    // Get device's current location
    try {
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);
      // Do something with the position, such as displaying it in a dialog
      print(position);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Current Location"),
            content: Text(
                "Latitude: ${position.latitude}, Longitude: ${position.longitude}"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );
    } catch (e) {
      // Handle any errors that occur during geolocation retrieval
      print("Error getting location: $e");
      try {showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("Error"),
            content: Text("Error getting location: $e"),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text("Close"),
              ),
            ],
          );
        },
      );}
      catch(e){
        print(e);
      }
    }
  }
}
