import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/directionsDetails.dart';
import 'package:park_locator/widgets/d_widgets/from_to.dart';
import 'package:park_locator/widgets/d_widgets/time.dart';
import 'package:park_locator/widgets/review.dart';
import '../Model/LocationDetails.dart';
import '../Shared/Marker.dart';


class direction_screen extends StatefulWidget{
  @required var currentLocation;
  @required directionsDetails info;
  @required List <LocationDetails> data;
  direction_screen({this.currentLocation,this.info,this.data});


  @override
  State<direction_screen> createState() => _searchState();


}

class _searchState extends State<direction_screen> {


  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = addMarkers2(widget.currentLocation,widget.info.getDestination());

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width,
           // color: Colors.black,
            child: from_to(source: widget.info.myLocation_name,target: widget.info.destination_name,),
          ),
          Container(
            //padding: const EdgeInsets.only(left: 0.0,top:140,right: 0.0),
            height: MediaQuery.of(context).size.height*0.40,
            width: MediaQuery.of(context).size.width,
            child: GoogleMap(
              initialCameraPosition: (widget.currentLocation != null) ? (CameraPosition(target:
              LatLng(widget.currentLocation.latitude,widget.currentLocation.longitude), zoom: 15.0,))
                  : (CameraPosition(target: LatLng(30.0313, 31.2107), zoom: 13.0)),

              zoomGesturesEnabled: true,
              zoomControlsEnabled: true,
              rotateGesturesEnabled: true,
              myLocationButtonEnabled: true,
              //myLocationEnabled: true,
              padding: EdgeInsets.only(top: 200.0,),
              polylines: Set<Polyline>.of(widget.info.getPolylines().values),
              markers:markers ,


            ),
          ),
          Container(
            height: MediaQuery.of(context).size.height*0.10,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),

              child: Container(

                child: Text(
                  "Reviews",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.blueGrey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          (widget.data.length!=0)? Flexible(child: review(widget.data)):
          Container(
            alignment: Alignment.bottomCenter,
            child: Text('\nNo nearby places with vacant spots found',
              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 15),),
          ),
        ],
      ),
    );

  }

}