import 'package:flutter/material.dart';
import 'package:rainify/core/common/app_const.dart';
import 'package:rainify/core/utils/location_service.dart';
import 'package:rainify/core/utils/storage_service.dart';

class LocationSettingWidget extends StatefulWidget {
  const LocationSettingWidget({super.key});

  @override
  State<LocationSettingWidget> createState() => _NotificationWidgetState();
}

class _NotificationWidgetState extends State<LocationSettingWidget> {
  bool isLocationPermission = false;

  @override
  void didChangeDependencies() async {
    final storageService = StorageService();
    isLocationPermission = await storageService.getPreciseLocation() ?? false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        mainAxisAlignment: .start,
        crossAxisAlignment: .start,
        children: [
          const SizedBox(height: 20.0),
          Text(
            "Location".toUpperCase(),
            style: Theme.of(context).textTheme.titleMedium!.copyWith(
              fontWeight: FontWeight.bold,
              letterSpacing: 0,
            ),
          ),
          const SizedBox(height: 10.0),
          Card(
            child: Column(
              mainAxisAlignment: .start,
              crossAxisAlignment: .start,
              children: [
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(
                    horizontal: 20.0,
                    vertical: 20.0,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: .start,
                          crossAxisAlignment: .start,
                          children: [
                            Text(
                              "Precise Location",
                              style: Theme.of(context).textTheme.displayMedium!
                                  .copyWith(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              "Allow app to use high-accurancy GPS",
                              style: Theme.of(
                                context,
                              ).textTheme.titleMedium!.copyWith(fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                      Switch(
                        trackColor: WidgetStatePropertyAll(
                          isLocationPermission
                              ? AppConst.primaryColor
                              : AppConst.secTextColor,
                        ),

                        trackOutlineColor: WidgetStatePropertyAll(
                          isLocationPermission
                              ? AppConst.primaryColor
                              : AppConst.secTextColor,
                        ),

                        thumbColor: const WidgetStatePropertyAll(Colors.white),

                        value: isLocationPermission,

                        onChanged: (value) async {
                          showDialog(
                            context: context,
                            barrierDismissible: false,
                            builder: (_) {
                              return _locationPermissionDialog(
                                allowButtonTap: () async {
                                  try {
                                    final locationService = LocationService();

                                    final storageService = StorageService();

                                    /// SAVE LOCAL STATE
                                    await storageService.setPreciseLocation(
                                      true,
                                    );

                                    /// GET LOCATION
                                    await locationService.getCurrentPosition(
                                      isPerciseLocation: true,
                                    );

                                    /// UPDATE UI
                                    setState(() {
                                      isLocationPermission = true;
                                    });

                                    /// CLOSE DIALOG
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    debugPrint(e.toString());
                                  }
                                },
                                cancelButtonTap: () async {
                                  try {
                                    final locationService = LocationService();

                                    final storageService = StorageService();

                                    /// SAVE LOCAL STATE
                                    await storageService.setPreciseLocation(
                                      false,
                                    );

                                    /// GET LOCATION
                                    await locationService.getCurrentPosition(
                                      isPerciseLocation: false,
                                    );

                                    /// UPDATE UI
                                    setState(() {
                                      isLocationPermission = false;
                                    });

                                    /// CLOSE DIALOG
                                    if (context.mounted) {
                                      Navigator.pop(context);
                                    }
                                  } catch (e) {
                                    debugPrint(e.toString());
                                  }
                                },
                              );
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _locationPermissionDialog({
    VoidCallback? allowButtonTap,
    VoidCallback? cancelButtonTap,
  }) {
    return AlertDialog(
      content: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            height: 60,
            width: 60,
            decoration: BoxDecoration(
              color: Colors.orangeAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(50.0),
            ),
            child: Center(child: Icon(Icons.location_on)),
          ),
          const SizedBox(height: 20.0),
          Text(
            "Location Permission",
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 20.0),
          Text(
            "Precise location helps Rainify previde more accurate local weather forecasts and critical severe weather alerts tailored specifically to your exact surroundings.",
            style: Theme.of(
              context,
            ).textTheme.titleMedium!.copyWith(fontSize: 14, letterSpacing: 0.0),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 30.0),
          GestureDetector(
            onTap: allowButtonTap,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                color: AppConst.primaryColor,
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.sizeOf(context).width,
              child: Center(
                child: Text(
                  "Allow",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: Colors.black,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 20.0),
          GestureDetector(
            onTap: cancelButtonTap,
            child: Container(
              padding: const EdgeInsets.all(10.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(10.0),
              ),
              width: MediaQuery.sizeOf(context).width,
              child: Center(
                child: Text(
                  "Don't Allow",
                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                    color: AppConst.secTextColor,
                    letterSpacing: 0.0,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
