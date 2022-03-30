
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/services/geoLocator.dart';
import 'package:provider/provider.dart';
import '../Model/DateTime.dart';
import '../Model/LocationDetails.dart';
import '../services/directions_repository.dart';
import 'States.dart';

class parkingLocatorCubit extends Cubit<parkingLocatorSates>
{
  static parkingLocatorCubit get(context)=>BlocProvider.of(context);


  parkingLocatorCubit() : super(parkingInitialSates());

  Location home=new Location(lng: 30.0395,lat: 331.2025 );
  List<DT> dt=  [];
   // final currentLocation=new Location(lng: 30.0395,lat: 331.2025 );
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
     emit(parkingDTSates());
    // return dt;
  }





  Set<Marker> addMarkers( List<LocationDetails> loc )
  {
    final Set<Marker> markers = new Set();
    for(int i=0;i<loc.length;i++)
    {
      markers.add(Marker( //add first marker
        markerId: MarkerId(loc[i].name),
        position: LatLng(loc[i].location.lat, loc[i].location.lng),
        icon: BitmapDescriptor.defaultMarker,
//Icon for Marker
      ));
    }
    emit(parkingMArkerSates());
    return markers;
  }
  //final Set<Marker> markers = addMarkers(locs);

}