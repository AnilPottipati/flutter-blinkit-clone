import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart' as geocoding;
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../../routes/route.dart';
import '../../../data/controller/delivery_address_controller.dart';
import '../../../data/controller/saved_address_controller.dart';
import '../../../data/model/address_model.dart';
import '../../../core/colors.dart';
import '../../../core/fonts.dart';

class LocationSelectionSheet extends StatefulWidget {
  const LocationSelectionSheet({super.key});

  @override
  State<LocationSelectionSheet> createState() => _LocationSelectionSheetState();
}

class _LocationSelectionSheetState extends State<LocationSelectionSheet> {
  final SavedAddressController _savedAddressController = Get.put(
    SavedAddressController(),
  );
  bool _isLoading = false;

  Future<void> _useCurrentLocation() async {
    setState(() {
      _isLoading = true;
    });

    try {
      Position position = await _determinePosition();
      final latLng = LatLng(position.latitude, position.longitude);
      List<geocoding.Placemark> placemarks = await geocoding
          .placemarkFromCoordinates(latLng.latitude, latLng.longitude);

      if (placemarks.isNotEmpty) {
        geocoding.Placemark place = placemarks.first;
        final address = [
          if (place.name != null && place.name!.isNotEmpty) place.name,
          if (place.subLocality != null && place.subLocality!.isNotEmpty)
            place.subLocality,
          if (place.locality != null && place.locality!.isNotEmpty)
            place.locality,
        ].join(', ');

        Get.find<DeliveryAddressController>().setAddress(latLng, address);
        Get.back(); // Close the sheet
      } else {
        Get.snackbar('Error', 'Could not determine address from location.');
      }
    } catch (e) {
      Get.snackbar('Error', 'Failed to get location: ${e.toString()}');
    }

    if (mounted) {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permissions are permanently denied, we cannot request permissions.',
      );
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.9,
      minChildSize: 0.5,
      builder: (_, controller) {
        return Container(
          decoration: BoxDecoration(
            color: AppColors.scaffoldBackground,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20.r),
              topRight: Radius.circular(20.r),
            ),
          ),
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.all(16.w),
                child: Row(
                  children: [
                    IconButton(
                      icon: Icon(Icons.close, color: AppColors.textDark),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Center(
                        child: Text(
                          'Select delivery location',
                          style: AppFonts.title2.copyWith(fontSize: 18.sp),
                        ),
                      ),
                    ),
                    SizedBox(width: 48), // Spacer to balance the close button
                  ],
                ),
              ),
              Expanded(
                child: ListView(
                  controller: controller,
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  children: [
                    TextField(
                      decoration: InputDecoration(
                        hintText: 'Search for area, street name...',
                        prefixIcon: Icon(
                          Icons.search,
                          color: AppColors.textHint,
                        ),
                        filled: true,
                        fillColor: Colors.white,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(color: AppColors.lightGrey),
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Column(
                        children: [
                          _buildLocationOptionTile(
                            icon: Icons.gps_fixed,
                            iconColor: AppColors.primary,
                            title: 'Use current location',
                            onTap: _isLoading ? () {} : _useCurrentLocation,
                            trailingWidget:
                                _isLoading
                                    ? const SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                      ),
                                    )
                                    : null,
                          ),
                          Divider(
                            height: 1.h,
                            indent: 50.w,
                            color: AppColors.lightGrey.withOpacity(0.5),
                          ),
                          _buildLocationOptionTile(
                            icon: Icons.add,
                            iconColor: AppColors.primary,
                            title: 'Add new address',
                            onTap: () async {
  final result = await Get.toNamed(Routes.addressPicker);
  if (result != null && result is Map) {
    final latlng = result['latlng'] as LatLng;
    final address = result['address'] as String;

    String? customName = await showDialog<String>(
      context: context,
      builder: (context) {
        String tempName = '';
        return AlertDialog(
          title: const Text('Name this address'),
          content: TextField(
            autofocus: true,
            decoration: const InputDecoration(hintText: 'e.g. Home, Work'),
            onChanged: (val) => tempName = val,
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () => Navigator.of(context).pop(tempName.trim()),
              child: const Text('Save'),
            ),
          ],
        );
      },
    );

    if (customName != null) {
      final fallbackTitle = customName.isNotEmpty ? customName : address.split(',').firstOrNull ?? 'Saved Address';
      final newAddress = AddressModel(
        title: fallbackTitle,
        address: address,
        latlng: latlng,
      );
      _savedAddressController.addAddress(newAddress);
      Get.find<DeliveryAddressController>().setAddress(latlng, address);
      Get.back();
    }
  }
},
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 24.h),
                    Text(
                      'Your saved addresses',
                      style: AppFonts.bodySmall.copyWith(
                        color: AppColors.textSecondary,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Obx(() {
                      if (_savedAddressController.savedAddresses.isEmpty) {
                        return Container(
                          padding: EdgeInsets.symmetric(vertical: 40.h),
                          alignment: Alignment.center,
                          child: Text(
                            'You have no saved addresses.',
                            style: AppFonts.bodyMedium.copyWith(
                              color: AppColors.textHint,
                            ),
                          ),
                        );
                      }
                      return ListView.separated(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount:
                            _savedAddressController.savedAddresses.length,
                        itemBuilder: (context, index) {
                          final address =
                              _savedAddressController.savedAddresses[index];
                          return _buildSavedAddressCard(
                            addressModel: address,
                            onTap: () {
                              Get.find<DeliveryAddressController>().setAddress(
                                address.latlng,
                                address.address,
                              );
                              Get.back();
                            },
                          );
                        },
                        separatorBuilder:
                            (context, index) => SizedBox(height: 12.h),
                      );
                    }),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLocationOptionTile({
    required IconData icon,
    required Color iconColor,
    required String title,
    String? subtitle,
    required VoidCallback onTap,
    Widget? trailingWidget,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor, size: 24.sp),
      title: Text(
        title,
        style: AppFonts.bodyMedium.copyWith(
          color: AppColors.primary,
          fontWeight: FontWeight.w600,
        ),
      ),
      subtitle:
          subtitle != null
              ? Text(
                subtitle,
                style: AppFonts.caption.copyWith(
                  color: AppColors.textSecondary,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              )
              : null,
      trailing:
          trailingWidget ??
          Icon(Icons.arrow_forward_ios, size: 16.sp, color: AppColors.textHint),
      onTap: onTap,
    );
  }

  Widget _buildSavedAddressCard({
    required AddressModel addressModel,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(16.w),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.location_on_outlined,
              color: AppColors.textDark,
              size: 24.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(addressModel.title, style: AppFonts.title3),
                  SizedBox(height: 8.h),
                  Text(
                    addressModel.address,
                    style: AppFonts.bodySmall,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
            SizedBox(width: 12.w),
            IconButton(
              icon: Icon(Icons.delete_outline, color: AppColors.error),
              onPressed: () async {
                final confirm = await showDialog<bool>(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text('Delete Address'),
                    content: const Text('Are you sure you want to delete this address?'),
                    actions: [
                      TextButton(
                        onPressed: () => Navigator.of(context).pop(false),
                        child: const Text('Cancel'),
                      ),
                      ElevatedButton(
                        onPressed: () => Navigator.of(context).pop(true),
                        style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                        child: const Text('Delete'),
                      ),
                    ],
                  ),
                );
                if (confirm == true) {
                  _savedAddressController.removeAddress(addressModel);
                }
              },
              tooltip: 'Delete address',
            ),
          ],
        ),
      ),
    );
  }
}
