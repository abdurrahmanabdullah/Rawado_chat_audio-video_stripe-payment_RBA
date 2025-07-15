// ignore_for_file: use_build_context_synchronously, deprecated_member_use
import 'dart:async';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:rawado/constants/app_constants.dart';
import 'package:rawado/features_trainer/service/presentation/widgets/location_select_bottomsheet.dart';
import 'package:rawado/gen/colors.gen.dart';
import 'package:rawado/helpers/all_routes.dart';
import 'package:rawado/helpers/di.dart';
import 'package:rawado/helpers/helper_methods.dart';
import 'package:rawado/networks/api_acess.dart';
import 'package:rawado/provider/address_provider.dart';
import 'package:svg_flutter/svg.dart';
import '../../../common_wigdets/auth_button.dart';
import '../../../constants/text_font_style.dart';
import '../../../gen/assets.gen.dart';
import '../../../helpers/navigation_service.dart';
import '../../../helpers/ui_helpers.dart';

class GPSSearchScreen extends StatefulWidget {
  const GPSSearchScreen({super.key});

  @override
  State<GPSSearchScreen> createState() => _GPSSearchScreenState();
}

class _GPSSearchScreenState extends State<GPSSearchScreen> {
  //CONTROLLER & VARIABLE..
  final Completer<GoogleMapController> _controller = Completer();
  final TextEditingController _searchController = TextEditingController();

  LatLng? location;
  String address = "Loading...";
  String searchQuery = "";
  final Set<Marker> markers = {};
  late Map<String, dynamic>? poly;
  final Set<Polyline> _polylines = {};
  final List<LatLng> _polylineCoordinates = [];

  //INITSATATE...
  @override
  void initState() {
    super.initState();
    // fetchDirection();
    getCurrentLocation();
  }

  // Fetch Direction Api
  void fetchDirection() async {
    log('call fetChDirection');
    poly = await getDirectionRXObj.getDirection(
        origin: const LatLng(23.7553, 90.4411),
        destination: const LatLng(23.8223, 90.3654));
    setState(() {});
    log('direesction data is : ${poly!["geocoded_waypoints"]}');
    log('direesction data is : ${poly!["routes"]}');
    _loadPolyline(poly!["routes"][0]["overview_polyline"]["points"]);
  }

  // Set Ployline
  void _loadPolyline(String point) {
    String encodedPolyline = point; // Replace with API response polyline
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);

    _polylineCoordinates.clear();
    for (var point in result) {
      _polylineCoordinates.add(LatLng(point.latitude, point.longitude));
    }

    setState(() {
      _polylines.add(Polyline(
        polylineId: const PolylineId("polyline"),
        points: _polylineCoordinates,
        color: Colors.green,
        width: 5,
      ));
    });
  }

//DISPOSE..
  @override
  void dispose() {
    _searchController.dispose();
    markers;
    location;
    super.dispose();
  }

  // DEFAULT LOCATION..
  final CameraPosition cameraPosition = const CameraPosition(
    target: LatLng(
      23.76538939221395,
      90.42238113516323,
    ),
    zoom: 14,
  );

//GET CURRENT LOCATION...
  Future<void> getCurrentLocation() async {
    // Get Pssition
    Position position = await _determinePosition();

    // Set the Camera Position
    CameraPosition newCameraPosition = CameraPosition(
      target: LatLng(
        position.latitude,
        position.longitude,
      ),
      zoom: 14,
    );
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newCameraPosition(
        newCameraPosition,
      ),
    );

    // set marker into position
    setState(() {
      location = LatLng(
        position.latitude,
        position.longitude,
      );
      markers.clear();
      markers.add(
        Marker(
          markerId: const MarkerId('currentLocation'),
          position: LatLng(position.latitude, position.longitude),
          infoWindow: InfoWindow(
            title: "Current Location",
            snippet: address,
          ),
        ),
      );
    });

    address =
        await getAddressFromLatLng(location!.latitude, location!.longitude);

    if (mounted) {
      context.read<AddressProvider>().setAddress(address,
          location!.latitude.toString(), location!.longitude.toString());
    }
  }

  // Determine Current Position
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
      return Future.error('Location permissions are permanently denied.');
    }

    return await Geolocator.getCurrentPosition();
  }

  //SEARCH LOCAITON...

  Future<void> searchLocation(String query) async {
    if (query.isEmpty) return;

    try {
      List<Location> locations = await locationFromAddress(query);
      if (locations.isNotEmpty) {
        Location location = locations.first;
        CameraPosition newCameraPosition = CameraPosition(
          target: LatLng(location.latitude, location.longitude),
          zoom: 14,
        );
        final GoogleMapController controller = await _controller.future;
        controller
            .animateCamera(CameraUpdate.newCameraPosition(newCameraPosition));

        setState(() {
          this.location = LatLng(location.latitude, location.longitude);
          address = query;
        });

        markers.clear();
        markers.add(
          Marker(
            markerId: const MarkerId('1'),
            position: LatLng(location.latitude, location.longitude),
            infoWindow: InfoWindow(
              title: "Searched Location",
              snippet: address,
            ),
          ),
        );
        if (mounted) {
          context.read<AddressProvider>().setAddress(address,
              location.latitude.toString(), location.longitude.toString());
          showBottom(context);
        }
      }
    } catch (e) {
      setState(() {
        address = "Unable to find location";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            // Google Map Screen
            GoogleMap(
              initialCameraPosition: cameraPosition,
              mapType: MapType.terrain,
              myLocationEnabled: true,
              markers: markers,
              // polylines: _polylines,

              // map ontap function
              onTap: (LatLng position) async {
                // get the address
                address = await getAddressFromLatLng(
                    position.latitude, position.longitude);

                // set the marker
                if (mounted) {
                  setState(() {
                    location = position;
                    markers.clear();
                    markers.add(
                      Marker(
                        markerId: const MarkerId('1'),
                        position: position,
                        infoWindow: InfoWindow(
                          title: "Selected Location",
                          snippet: address,
                        ),
                      ),
                    );
                  });
                }

                // Set address into provider

                if (mounted) {
                  context.read<AddressProvider>().setAddress(
                      address,
                      position.latitude.toString(),
                      position.longitude.toString());
                  showBottom(context);
                }
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),

            //LOCATION SEARCH WIDGET...
            Padding(
              padding: EdgeInsets.only(top: 15.h, left: 10.w, right: 20.w),
              child: Row(
                children: [
                  InkWell(
                    onTap: () {
                      NavigationService.goBack;
                    },
                    child: SvgPicture.asset(
                      Assets.icons.backButton,
                      color: appColor(),
                    ),
                  ),
                  UIHelper.horizontalSpace(10.w),
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 8.w),
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        border: Border.all(color: Colors.black12, width: 1),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: TextField(
                        controller: _searchController,
                        decoration: InputDecoration(
                          hintText: 'Search location...',
                          border: InputBorder.none,
                          suffixIcon: IconButton(
                            icon: const Icon(Icons.search,
                                color: AppColors.c222222),
                            onPressed: () {
                              searchLocation(_searchController.text);
                            },
                          ),
                        ),
                        onSubmitted: (query) {
                          searchLocation(query);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: Padding(
        padding: EdgeInsets.only(left: 34..h),
        child: AppCustomeButton(
          color: appColor(),
          borderRadius: 40.sp,
          context: context,
          height: 54.h,
          minWidth: double.infinity,
          name: 'CONFIRM LOCATION',
          onCallBack: () {
            if (appData.read(kKeyRoleType) == kKeyISUser) {
              NavigationService.navigateToReplacementWithObj(
                  Routes.boookingSchedule, false);
            } else if (appData.read(kKeyRoleType) == kKeyISTrainer) {
              NavigationService.navigateToReplacement(Routes.addService);
            }
          },
          textStyle: TextFontStyle.headline16StyleCabin
              .copyWith(color: appTextColor()),
        ),
      ),
    );
  }

  void showBottom(BuildContext context) {
    showModalBottomSheet(
      elevation: 0,
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      builder: (builder) {
        return LocationBottomSheet(
          onTapConfirm: () {
            NavigationService.goBack;
          },
          buttonName: 'SAVE',
        );
      },
    );
  }
}
