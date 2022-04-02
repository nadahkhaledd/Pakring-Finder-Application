import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/Network/Remote/Dio_helper.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';
import '../Model/DateTime.dart';
import '../Model/LocationDetails.dart';
import '../Network/endpoints.dart';
import '../services/directions_repository.dart';
import 'States.dart';

class parkingLocatorCubit extends Cubit<parkingLocatorStates> {
  parkingLocatorCubit() : super(parkingInitialStates());

  static parkingLocatorCubit get(context) => BlocProvider.of(context);

  Location home = new Location(lng: 30.0395, lat: 331.2025);
  List<DT> dt = [];
  Set<Marker> markers;
  // final currentLocation=new Location(lng: 30.0395,lat: 331.2025 );
  void getDistanceAndTime2(
      List<LocationDetails> loc,
      ) async {
    for (int i = 0; i < loc.length; i++) {
      final directions = await DirectionsRepository().getDirections(
          origin: LatLng(30.0313, 31.2107),
          destination: LatLng(loc[i].location.lat, loc[i].location.lng));
      locs[i].distance = directions.totalDistance;
      locs[i].time = directions.totalDuration;
    }
    print("SS");
    emit(parkingDTStates());
    //  return dt;
  }

  void getDistanceAndTime(
      List<LocationDetails> loc,
      ) async {

    for(int i=0;i<loc.length;i++)
    {
      final directions = await DirectionsRepository()
          .getDirections(origin: LatLng(30.0313, 31.2107),
          destination:LatLng(loc[i].location.lat, loc[i].location.lng) );
      DT dtt=new DT (directions.totalDistance,directions.totalDuration);
      dt.add(dtt);
    }
  }



  Set<Marker> addMarkers(List<LocationDetails> loc) {
    emit(parkingLoadingStates());
    final Set<Marker> markers = new Set();
    for (int i = 0; i < loc.length; i++) {
      markers.add(Marker(
        //add first marker
        markerId: MarkerId(loc[i].name),
        position: LatLng(loc[i].location.lat, loc[i].location.lng),
        icon: BitmapDescriptor.defaultMarker,
      ));
    }
    emit(parkingMarkerStates());
    return markers;
  }

  String getCapacity;
  void getData({@required String url, @required String capacity}) {
    emit(parkingLoadingStates());

    DioHelper.postData(url: FIND, data:{
      "url": url,
      "capacity": capacity,
    })
        .then((value) {
      print("QQQQQQQQQQ"+value.data["spots"].toString());
      getCapacity=value.data["spots"].toString();
      emit(parkingGetDataStates());
    }).catchError((error){
      print("WWWWWWWWWW");
      print(error.toString());
      emit(parkingErrorStates(error));
    });
  }

}
