import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LocationPage(),
    );
  }
}

class LocationPage extends StatefulWidget {
  @override
  _LocationPageState createState() => _LocationPageState();
}
// main code
class _LocationPageState extends State<LocationPage> {
  String _locationMessage = ''; //used to stores location deatils

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location Demo'), // title above the buttoon
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(_locationMessage),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _getLocation();
              },
              child: Text('Get Location'),
            ),
          ],
        ),
      ),
    );
  }

  void _getLocation() async {
    Position position = await Geolocator.getCurrentPosition( //call the geolocator library
      desiredAccuracy: LocationAccuracy.high, // for accurate location
    );

    setState(() {
      _locationMessage =
          'Latitude: ${position.latitude}, Longitude: ${position.longitude}';
    });

    // Send location data to backend (replace this with your backend API call)
    _sendLocationToBackend(position.latitude, position.longitude);
  }

  void _sendLocationToBackend(double latitude, double longitude) {
    // You can send the latitude and longitude to your backend here
    print('Sending location to backend...');
    print('Latitude: $latitude, Longitude: $longitude');
    // You can make HTTP requests or use any other method to send the data to your backend
  }
}
