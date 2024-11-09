

import 'dart:async';


import 'package:be_local_app/Utils/be_plant_theme.dart';
import 'package:be_local_app/Utils/icon_button.dart';
import 'package:be_local_app/Utils/util.dart';
import 'package:be_local_app/Utils/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_google_places_hoc081098/flutter_google_places_hoc081098.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_api_headers/google_api_headers.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/directions.dart';
import 'package:google_maps_webservice/places.dart';
import 'dart:io';

import '../../../Utils/model.dart';
import '../../../components/custom_app_bar_widget.dart';
import '../splash/splash_widget.dart';
import 'address_model.dart';



class OnboardingAddressWidget extends StatefulWidget {

  //final bool fromRegister;

  const OnboardingAddressWidget({super.key});


  @override
  _OnboardingAddressWidget createState() => _OnboardingAddressWidget();
}

class _OnboardingAddressWidget extends State<OnboardingAddressWidget> {
  late OnboardingAddressModel _model;
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController streetController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController townController = TextEditingController();
  final Completer<GoogleMapController> _cntr = Completer();
  String googleApikey = "AIzaSyD5maQo1oIJr7Kaz6Zm_KGHKNL6FusuTDE";
  GoogleMapController? mapController; //contrller for Google map
  CameraPosition? cameraPosition;
  LatLng startLocation = LatLng(37.2941, -121.7992);
  late Placemark locationName;

  //Location location = Location();
  late String addressMade;
  String? _currentAddress;
  late Position _currentPosition;
  bool mapToggle = false;
  bool loading = false;

  String strLatLong = "";

  String strAlamat = 'Mencari lokasi...';
  final LocationSettings locationSettings = LocationSettings(
    accuracy: LocationAccuracy.high,
    distanceFilter: 100,
  );


  @override
  initState() {
    super.initState();
    Future.delayed(Duration.zero, () async {
      _currentPosition = await _getGeoLocationPosition();
      print(_currentPosition);
      locationName = await getAddressFromLongLat(_currentPosition);
    });
    mapToggle = false;
    _model = createModel(context, () => OnboardingAddressModel());
  }

  Future<Position> _getGeoLocationPosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    //location service not enabled, don't continue
    if (!serviceEnabled) {
      await Geolocator.openLocationSettings();
      return Future.error('Location service Not Enabled');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permission denied');
      }
    }

    //permission denied forever
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        'Location permission denied forever, we cannot access',
      );
    }
    //continue accessing the position of device
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );
  }

  // //getAddress
  Future<Placemark> getAddressFromLongLat(Position position) async {
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    print(placemarks);

    Placemark place = placemarks[0];
    setState(() {
      strAlamat = '${place.street} ${place.subLocality} ${place.locality}${place
          .postalCode} ${place.country}';
    });

    return place;
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    //mapController.setMapStyle(mapTheme);
    _cntr.complete(mapController);
    //_getCurrentPosition();
    StreamSubscription<Position> positionStream = Geolocator.getPositionStream(
        locationSettings: locationSettings).listen(
            (Position? position) {
          print(position == null ? 'Unknown' : '${position.latitude
              .toString()}, ${position.longitude.toString()}');
        });
    {
      mapController?.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target:
          LatLng(_currentPosition!.latitude, _currentPosition!.longitude),
              zoom: 20),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: BePlantTheme
            .of(context)
            .primaryBackground,
        body: SafeArea(
          top: true,
          child: Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: SingleChildScrollView(
                  child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                      wrapWithModel(
                      model: _model.customAppbarModel,
                      updateCallback: () => safeSetState(() {}),
                      child: CustomAppbarWidget(
                        backButton: true,
                        actionButton: false,
                        actionButtonAction: () async {},
                        optionsButtonAction: () async {},
                      )
                      ),
                        Padding(
                          padding: EdgeInsetsDirectional.fromSTEB(20, 0, 20, 8),
                          child: Row(
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: EdgeInsetsDirectional.fromSTEB(
                                      24, 14, 24, 0),
                                  child: Text(
                                    'Add your address and confirm it on the map',
                                    style: BePlantTheme
                                        .of(context)
                                        .headlineLarge
                                        .override(
                                      fontFamily: 'Poppins',
                                      color: BePlantTheme
                                          .of(context)
                                          .secondaryText,
                                      fontSize: 20,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        Padding(
                            padding: EdgeInsetsDirectional.fromSTEB(24, 14, 24, 0),
                            child: Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Colors.white,
                                    ),
                                    borderRadius: BorderRadius.all(
                                        Radius.circular(20))
                                ),
                                child: Stack(
                                    children: [SizedBox(
                                      width: MediaQuery
                                          .of(context)
                                          .size
                                          .width - 50, // or use fixed size like 200
                                      height: MediaQuery
                                          .of(context)
                                          .size
                                          .height - 500,
                                      child:
                                      /*GoogleMap( //Map widget from google_maps_flutter package
                                          zoomGesturesEnabled: true,
                                          //enable Zoom in, out on map
                                          initialCameraPosition: CameraPosition( //innital position in map
                                            target: startLocation, //initial position
                                            zoom: 8.0, //initial zoom level
                                          ),
                                          mapType: MapType.normal,
                                          //map type
                                          onMapCreated: _onMapCreated
                                      ),*/

                                      mapToggle
                                          ? GoogleMap(
                                          onMapCreated: _onMapCreated,
                                          initialCameraPosition: CameraPosition(
                                              target: LatLng(
                                                  _currentPosition.latitude,
                                                  _currentPosition.longitude),
                                              zoom: 10.0))
                                          : Center(
                                          child: Text(
                                            'Loading.. Please wait..',
                                            style: TextStyle(fontSize: 20.0),
                                          )
                                      ),),



                                      //search autoconplete input


                                    ]
                                )
                            )
                        ),
                        GestureDetector(
                            onTap: () => FocusScope.of(context).unfocus(),
                            child: SingleChildScrollView(
                              child: Column(
                                children: [

                                  const SizedBox(height: 32),
                                  Padding(
                                      padding: EdgeInsetsDirectional.fromSTEB(
                                          24, 12, 24, 0),
                                    child: BLButtonWidget(
                                      onPressed: () async {
                                        setState(() {
                                          loading = true;
                                        });

                                        Position position = await _getGeoLocationPosition();

                                        setState(() {
                                          loading = false;
                                          strLatLong =
                                          '${position.latitude}, ${position
                                              .longitude}';
                                        });

                                        locationName = await getAddressFromLongLat(
                                            position);

                                        mapToggle = true;
                                        print(position);
                                        print(strLatLong);
                                      },
                                      text: "Get Current Location",
                                      options: BLButtonOptions(
                                        width: double.infinity,
                                        height: 60.0,
                                        padding:
                                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        iconPadding:
                                        const EdgeInsetsDirectional.fromSTEB(0.0, 0.0, 0.0, 0.0),
                                        color: BePlantTheme.of(context).success,
                                        textStyle:
                                        BePlantTheme.of(context).titleSmall.override(
                                          fontFamily: 'Plus Jakarta Sans',
                                          letterSpacing: 0.0,
                                        ),
                                        elevation: 0.0,
                                        borderSide: const BorderSide(
                                          color: Colors.transparent,
                                          width: 0.2,
                                        ),
                                        borderRadius: BorderRadius.circular(20.0),
                                      ),
                                    ),
                                  ),


                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 12, 24, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: BePlantTheme
                                            .of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x4D101213),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        controller: streetController,
                                        validator: (value) =>
                                        (value!.isEmpty)
                                            ? 'Please enter the street name'
                                            : locationName.street,
                                        decoration: mapToggle
                                            ? InputDecoration(
                                          labelText: locationName.street as String,
                                          labelStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium,
                                          hintText: 'Please enter your street name...',
                                          hintStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                            BePlantTheme
                                                .of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          BePlantTheme
                                              .of(context)
                                              .secondaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 24, 20, 24),
                                        )
                                            : InputDecoration(
                                          labelText: "Please enter your Street name and number",
                                          //locationName.street as String,
                                          labelStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium,
                                          hintText: 'Please enter your street name...',
                                          hintStyle: BePlantTheme
                                              .of(context)
                                              .bodySmall
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                            BePlantTheme
                                                .of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          BePlantTheme
                                              .of(context)
                                              .secondaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 24, 20, 24),
                                        ),
                                        style: BePlantTheme
                                            .of(context)
                                            .bodySmall,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),

                                  //last name
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 14, 24, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: BePlantTheme
                                            .of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x4D101213),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        controller: zipCodeController,
                                        validator: (value) =>
                                        (value!.isEmpty)
                                            ? 'Please enter your zip code'
                                            : locationName.postalCode,
                                        obscureText: false,
                                        decoration: mapToggle
                                            ? InputDecoration(
                                          labelText: locationName
                                              .postalCode as String,
                                          labelStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium,
                                          hintText: 'Enter your zip code...',
                                          hintStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                            BePlantTheme
                                                .of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          BePlantTheme
                                              .of(context)
                                              .secondaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 24, 20, 24),
                                        )
                                            : InputDecoration(
                                          labelText: "Your Postal Code",
                                          labelStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium,
                                          hintText: 'Enter your zip code...',
                                          hintStyle: BePlantTheme
                                              .of(context)
                                              .bodyMedium
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                            BePlantTheme
                                                .of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          BePlantTheme
                                              .of(context)
                                              .secondaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 24, 20, 24),
                                        )

                                        ,
                                        style: BePlantTheme
                                            .of(context)
                                            .bodyText1,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),

                                  //age
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        24, 14, 24, 0),
                                    child: Container(
                                      width: double.infinity,
                                      height: 60,
                                      decoration: BoxDecoration(
                                        color: BePlantTheme
                                            .of(context)
                                            .secondaryBackground,
                                        boxShadow: [
                                          BoxShadow(
                                            blurRadius: 5,
                                            color: Color(0x4D101213),
                                            offset: Offset(0, 2),
                                          )
                                        ],
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: TextFormField(
                                        controller: townController,
                                        validator: (value) =>
                                        (value!.isEmpty)
                                            ? 'Please enter your town/city name'
                                            : null,
                                        obscureText: false,
                                        decoration: mapToggle
                                            ? InputDecoration(
                                          labelText: locationName
                                              .locality as String,
                                          labelStyle: BePlantTheme
                                              .of(context)
                                              .bodyText2,
                                          hintText: 'Enter your town/city...',
                                          hintStyle: BePlantTheme
                                              .of(context)
                                              .bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                            BePlantTheme
                                                .of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          BePlantTheme
                                              .of(context)
                                              .secondaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 24, 20, 24),
                                        )
                                            : InputDecoration(
                                          labelText: " Please enter your Town/city",
                                          //locationName.locality as String,
                                          labelStyle: BePlantTheme
                                              .of(context)
                                              .bodyText2,
                                          hintText: 'Enter your town/city...',
                                          hintStyle: BePlantTheme
                                              .of(context)
                                              .bodyText1
                                              .override(
                                            fontFamily: 'Lexend Deca',
                                            color:
                                            BePlantTheme
                                                .of(context)
                                                .secondaryText,
                                            fontSize: 14,
                                            fontWeight: FontWeight.normal,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          errorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          focusedErrorBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                              color: Color(0x00000000),
                                              width: 0,
                                            ),
                                            borderRadius: BorderRadius.circular(12),
                                          ),
                                          filled: true,
                                          fillColor:
                                          BePlantTheme
                                              .of(context)
                                              .secondaryBackground,
                                          contentPadding:
                                          EdgeInsetsDirectional.fromSTEB(
                                              24, 24, 20, 24),
                                        ),
                                        style: BePlantTheme
                                            .of(context)
                                            .bodyText1,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsetsDirectional.fromSTEB(
                                        0, 24, 0, 20),
                                    child: BLButtonWidget(
                                      onPressed: () {
                                        print("pressed");
                                      },
                                      text: 'Add address',
                                      options: BLButtonOptions(
                                        width: 270,
                                        height: 50,
                                        color: const Color.fromARGB(255, 255, 242,
                                            176),
                                        textStyle:
                                        BePlantTheme
                                            .of(context)
                                            .subtitle2
                                            .override(
                                          fontFamily: 'Poppins',
                                          color: Colors.black,
                                          fontSize: 16,
                                        ),
                                        elevation: 3,
                                        borderSide: BorderSide(
                                          color: Colors.transparent,
                                          width: 1,
                                        ),
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            )
                        )
                      ]

                  )
              ),
            ),
          ),
        )
    );
  }



}






