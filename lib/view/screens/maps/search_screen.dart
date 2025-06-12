import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:blinkit_clone/data/controller/search_controller.dart' as search_controller;
import 'package:google_maps_flutter/google_maps_flutter.dart';

class SearchScreen extends StatelessWidget {
  final bool isSourceSelection;
  final LatLng? currentLocation;

  const SearchScreen({
    super.key,
    this.isSourceSelection = false,
    this.currentLocation,
  });

  @override
  Widget build(BuildContext context) {
    final search_controller.LocationSearchController controller = 
        Get.put(search_controller.LocationSearchController());
    final TextEditingController textEditingController = TextEditingController();
    
    // Set initial location if provided
    if (currentLocation != null) {
      controller.selectedSourceLocation.value = currentLocation;
      controller.getSourceAddressName(currentLocation!, 'Current Location');
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Search Destination'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: textEditingController,
              onChanged: controller.onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Search for a destination...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    textEditingController.clear();
                    controller.clearSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isSearching.value) {
                return const Center(child: CircularProgressIndicator());
              }
              if (controller.searchResults.isEmpty && controller.searchText.value.isNotEmpty) {
                return const Center(child: Text('No results found'));
              }
              return ListView.builder(
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final prediction = controller.searchResults[index];
                  return ListTile(
                    leading: const Icon(Icons.location_on),
                    title: Text(prediction.description ?? 'No description'),
                    onTap: () async {
                      if (isSourceSelection) {
                        final details = await controller.getPlaceDetails(prediction.placeId!);
                        if (details != null) {
                          controller.endSearchSession(); // End session on selection
                          Navigator.of(context).pop(details); // Return the correct object type
                        }
                      } else {
                        controller.selectDestination(prediction.placeId!);
                      }
                    },
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
