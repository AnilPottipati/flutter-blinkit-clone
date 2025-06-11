import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:blinkit_clone/data/controller/map_controller.dart';
import '../../components/maps/source_selector_widget.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final MapController controller = Get.put(MapController());

    return Scaffold(
      appBar: AppBar(
        title: Obx(() => Text(
          controller.isRouteLoaded.value ? 'Live Tracking' : 'Select Destination',
        )),
        actions: [
          Obx(() => IconButton(
                icon: const Icon(Icons.search),
                onPressed: controller.isRouteLoaded.value
                    ? null
                    : controller.navigateToSearch,
                tooltip: 'Search destination',
              )),
        ],
      ),
      body: Obx(() {
        if (controller.liveUserPosition.value == null) {
          return const Center(child: CircularProgressIndicator());
        }
        return Stack(
          children: [
            GoogleMap(
              initialCameraPosition: CameraPosition(
                target: controller.liveUserPosition.value!,
                zoom: 15,
              ),
              onMapCreated: (GoogleMapController mapController) {
                if (!controller.googleMapCompleter.isCompleted) {
                  controller.googleMapCompleter.complete(mapController);
                }
                controller.mapController = mapController;
              },
              myLocationEnabled: true,
              myLocationButtonEnabled: true,
              zoomControlsEnabled: true,
              markers: controller.markers,
              polylines: controller.polylines,
            ),
            // Source selector (always visible unless in route mode)
            if (!controller.isRouteLoaded.value) 
              const SourceSelectorWidget(),
              
            // ETA display when route is active
            if (controller.isRouteLoaded.value) ...[
              Positioned(
                top: 10,
                left: 10,
                right: 10,
                child: Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        const Icon(Icons.directions_bike, color: Colors.green),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Obx(() => Text(
                                'ETA: ${controller.estimatedArrivalTimeString.value}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              )),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
            if (controller.isRouteLoaded.value)
              Positioned(
                bottom: 20,
                left: 20,
                right: 20,
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: controller.resetRoute,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.close, size: 20),
                        label: const Text('Cancel Route'),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: ElevatedButton.icon(
                        onPressed: () {
                          // Add navigation to order confirmation
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.check, size: 20),
                        label: const Text('Confirm Pickup'),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        );
      }),
    );
  }
}
