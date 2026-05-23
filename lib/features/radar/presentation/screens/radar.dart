import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:geolocator/geolocator.dart';
import 'package:latlong2/latlong.dart';
import 'package:rainify/features/radar/bloc/bloc.dart';
import 'package:rainify/features/radar/bloc/bloc_event.dart';
import 'package:rainify/features/radar/bloc/bloc_state.dart';

import '../../../../core/common/widgets/bottom_navbar_widget.dart';
import '../../../../core/common/widgets/error_widget.dart';
import '../../../../core/utils/location_service.dart';
import '../../../../core/utils/storage_service.dart';

class RadarScreen extends StatefulWidget {
  const RadarScreen({super.key});

  @override
  State<RadarScreen> createState() => _RadarScreenState();
}

class _RadarScreenState extends State<RadarScreen> {
  final MapController mapController = MapController();

  Position? position;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    _initializeLocation();
  }

  /// GET USER LOCATION
  Future<void> _initializeLocation() async {
    try {
      final locationService = LocationService();

      final storageService = StorageService();

      final isPreciseLocation =
          await storageService.getPreciseLocation() ?? false;

      position = await locationService.getCurrentPosition(
        isPerciseLocation: isPreciseLocation,
      );

      /// LOAD RADAR
      if (mounted) {
        context.read<RadarBloc>().add(RadarDataLoadedEvent());

        setState(() {});
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    /// LOADING
    if (position == null) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    return Scaffold(
      body: BlocBuilder<RadarBloc, RadarState>(
        builder: (context, state) {
          /// LOADING
          if (state is RadarLoadingState) {
            return const Center(child: CircularProgressIndicator());
          }

          /// SUCCESS
          if (state is RadarSuccessState) {
            return Stack(
              children: [
                /// MAP
                FlutterMap(
                  mapController: mapController,

                  options: MapOptions(
                    initialZoom: 5,

                    minZoom: 3,

                    maxZoom: 10,

                    initialCenter: LatLng(
                      position!.latitude,
                      position!.longitude,
                    ),
                  ),
                  children: [
                    /// BASE MAP
                    TileLayer(
                      urlTemplate:
                          'https://api.maptiler.com/maps/dataviz-dark/{z}/{x}/{y}.png?key=jcWNzKrcU5BajlLnbGBk',

                      userAgentPackageName: "com.example.weather_app",
                    ),

                    /// RADAR LAYER
                    TileLayer(
                      urlTemplate: state.radarUrl,

                      tileProvider: NetworkTileProvider(),
                    ),

                    /// USER LOCATION
                    MarkerLayer(
                      markers: [
                        Marker(
                          point: LatLng(
                            position!.latitude,

                            position!.longitude,
                          ),

                          width: 20,

                          height: 20,

                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.blue,

                              shape: BoxShape.circle,

                              border: Border.all(color: Colors.white, width: 3),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),

                /// CURRENT LOCATION BUTTON
                Positioned(
                  bottom: 20,

                  right: 20,

                  child: GestureDetector(
                    onTap: () {
                      mapController.move(
                        LatLng(position!.latitude, position!.longitude),

                        7,
                      );
                    },

                    child: Container(
                      padding: const EdgeInsets.all(14),

                      decoration: BoxDecoration(
                        color: Colors.black87,

                        borderRadius: BorderRadius.circular(14),
                      ),

                      child: const Icon(Icons.my_location, color: Colors.white),
                    ),
                  ),
                ),
              ],
            );
          }

          /// ERROR
          if (state is RadarErrorState) {
            return CommonErrorWidget(
              onTapEvent: () {
                context.read<RadarBloc>().add(RadarDataLoadedEvent());
              },
            );
          }

          return const SizedBox();
        },
      ),

      bottomNavigationBar: const BottomNavbarWidget(),
    );
  }
}
