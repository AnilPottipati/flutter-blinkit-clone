import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../../../data/controller/map_controller.dart';
import '../../screens/maps/search_screen.dart';
import 'package:blinkit_clone/data/controller/search_controller.dart';

class SourceSelectorWidget extends StatelessWidget {
  const SourceSelectorWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final mapController = Get.find<MapController>();
    
    return Positioned(
      top: 10,
      left: 10,
      right: 10,
      child: Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Pickup Location',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 8),
              Obx(() => Row(
                    children: [
                      const Icon(Icons.location_on, color: Colors.red, size: 20),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(
                          mapController.selectedSourceName.value,
                          style: const TextStyle(fontSize: 14),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          // Show dialog to select source
                          _showSourceSelectionDialog(context, mapController);
                        },
                        child: const Text('Change'),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }

  void _showSourceSelectionDialog(
      BuildContext context, MapController controller) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Pickup Location'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.my_location),
              title: const Text('Use Current Location'),
              onTap: () {
                controller.toggleSourceLocation(null, 'Current Location');
                Navigator.pop(context);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.search),
              title: const Text('Search Location'),
              onTap: () {
                Navigator.pop(context);
                _showSearchScreen(context, controller);
              },
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.map),
              title: const Text('Choose on Map'),
              onTap: () {
                Navigator.pop(context);
                _showMapForSourceSelection(context, controller);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showSearchScreen(BuildContext context, MapController mapController) {
    final currentLocation = mapController.liveUserPosition.value ??
        mapController.sourceLocation.value;

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => SearchScreen(
          isSourceSelection: true,
          currentLocation: currentLocation,
        ),
      ),
    ).then((result) {
      if (result != null && result is PlaceDetailsResult) {
        mapController.toggleSourceLocation(
          LatLng(result.lat, result.lng),
          result.name,
        );
      }
    });
  }

  void _showMapForSourceSelection(
      BuildContext context, MapController controller) {
    // You can implement a full-screen map here for precise location selection
    // For now, we'll just show a simple dialog
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Select Location on Map'),
        content: const Text('Long press on the map to select a location'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              // In a real implementation, you would get the selected location from the map
              // For now, we'll use a dummy location
              const dummyLocation = LatLng(28.6139, 77.2090); // Example: New Delhi
              controller.toggleSourceLocation(
                  dummyLocation, 'Selected Location');
              Navigator.pop(context);
            },
            child: const Text('Select Here'),
          ),
        ],
      ),
    );
  }
}
