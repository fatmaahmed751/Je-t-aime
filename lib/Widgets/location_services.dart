import "dart:async";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:geocoding/geocoding.dart";
import "package:geolocator/geolocator.dart";
import "package:go_router/go_router.dart";
import "package:permission_handler/permission_handler.dart";

class LocationService {
 // StreamSubscription<Position>? positionStream;

  // Check and request location permissions
 // Future<void> getCurrentLocation()
  Future<String?> getCurrentLocationAndAddress() async {
    print("Checking location services...");
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      print("Location services are disabled.");
      //showPermissionDeniedDialog(currentContext_!);
      return null;
    }

    print("Checking location permissions...");
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      print("Requesting location permissions...");
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        print("Location permissions are denied.");
    //    showPermissionDeniedDialog(currentContext_!);
        return null;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      print("Location permissions are permanently denied.");
   //   showPermissionDeniedDialog(currentContext_!);
      return null;
    }

    if (permission == LocationPermission.whileInUse || permission == LocationPermission.always) {
      print("Getting current position...");
      try {
        Position position = await Geolocator.getCurrentPosition(
          locationSettings: const LocationSettings(
            accuracy: LocationAccuracy.high, // Set desired accuracy
            distanceFilter: 10, // Minimum distance (in meters) to trigger updates
          ),
        );
        print("Current Position: ${position.latitude}, ${position.longitude}");
        List<Placemark> placemarks = await placemarkFromCoordinates(
          position.latitude,
          position.longitude,
        );

        if (placemarks.isNotEmpty) {
          Placemark place = placemarks.first;
          // Format the address string
          String address = [
            if (place.street != null) place.street,
            if (place.subLocality != null) place.subLocality,
            if (place.locality != null) place.locality,
            if (place.administrativeArea != null) place.administrativeArea,
            if (place.postalCode != null) place.postalCode,
            if (place.country != null) place.country,
          ].where((part) => part != null && part.isNotEmpty).join(', ');

          print("Formatted Address: $address");
          return address;
        }
        return "Lat: ${position.latitude}, Long: ${position.longitude}";
      } catch (e) {
   print("Error in getCurrentLocationAndAddress: $e");
      }
      return null;
    }
    print("Listening to position updates...");
    return null;
      // positionStream = Geolocator.getPositionStream().listen(
      //       (Position? position) {
      //     print('Position Update: ${position?.latitude}, ${position?.longitude}');
      //   },
      // );
    }


  // Show a dialog when permissions are denied
  void showPermissionDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Location Permission Required"),
        content: Text("This app needs location permissions to function properly. Please grant the permission."),
        actions: [
          TextButton(
            onPressed: () {
              SystemNavigator.pop();
             context.pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await openAppSettings();
              context.pop();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  // Show a dialog when permissions are permanently denied
  void showPermissionPermanentlyDeniedDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Location Permission Required"),
        content: Text("Location permissions are permanently denied. Please enable them in app settings."),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              SystemNavigator.pop();
            },
            child: Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              Navigator.pop(context);
              await openAppSettings();
            },
            child: Text("Open Settings"),
          ),
        ],
      ),
    );
  }

  // Dispose the position stream
  void dispose() {
 //   positionStream?.cancel();
  }
}

