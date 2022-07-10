import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/Model/directionsDetails.dart';
import 'package:park_locator/services/API/APIManager.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:park_locator/widgets/d_widgets/from_to.dart';
import 'package:park_locator/widgets/d_widgets/time.dart';
import 'package:park_locator/widgets/review.dart';
import 'package:provider/provider.dart';
import '../Model/DBModels/Recent.dart';
import '../Network/API/Recents.dart';
import '../Network/API/Reviews.dart';
import '../Shared/Functions.dart';
import '../Shared/Marker.dart';


class direction_screen extends StatefulWidget{
  @required var currentLocation;
  @required directionsDetails info;
  @required List <Review> review;
  @required List <String> users;
  @required String cameraID;
  String bookmarkID;
  bool ifBookmark;

  direction_screen({this.currentLocation,this.info,this.review,this.users,this.cameraID, this.ifBookmark, this.bookmarkID});



  @override
  State<direction_screen> createState() => _searchState();


}

class _searchState extends State<direction_screen> {

  String valueText;
  AppProvider provider;
  GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);
    Set<Marker> markers = addMarkers2(widget.currentLocation,widget.info.getDestination());


    return SafeArea(
      child: Scaffold(
        key: _scaffoldState,
        drawer: Appdrawer(context),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height*0.22,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.black,
                  child: from_to(source: widget.info.myLocation_name,target: widget.info.destination_name,
                      isBookmark: widget.ifBookmark, bookmarkID: widget.bookmarkID, destination: widget.info.getDestination()),
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
                  //height: MediaQuery.of(context).size.height*0.10,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.white,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20, right: 20, top: 3, bottom: 3),
                    child: Flexible(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding:const EdgeInsets.only(),
                            child:  Text("Reviews", style: TextStyle(fontSize: 20, color: Colors.blueGrey, fontWeight: FontWeight.bold),
                            ),
                          ),

                          Padding(
                              padding:const EdgeInsets.only(left: 130),
                              child:  ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  primary: Colors.blueGrey, // background (button) color
                                  onPrimary: Colors.white,
                                  //side: BorderSide(color: Colors.black, width: 1),
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                  padding: EdgeInsets.only(left: 15,right: 15),
                                ),
                                child: Text("Add Review"),
                                onPressed: (){
                                  opendialog();
                                },
                              )
                          )

                        ],
                      ),
                    ),
                  ),
                ),
                (widget.review.length!=0)? Flexible(child: review(widget.review,widget.users)):
                Container(
                  alignment: Alignment.bottomCenter,
                  child: Text('\nNo reviews',
                    style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 15),),
                ),
              ],
            ),

            Padding(
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.30),
            child: Center(
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  primary: Colors.red, // background (button) color
                  onPrimary: Colors.white,
                  elevation: 10,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  //padding: EdgeInsets.only(left: 10,right: 10),
                ),
                child: Text("Start", style: TextStyle(fontWeight: FontWeight.bold),),
                onPressed: ()async {
                  var lat = widget.info.getDestination().latitude;
                  var long = widget.info.getDestination().longitude;
                  recent recentData = new recent(address: widget.info.destination_name,
                      location: Location(lat: lat, long: long),
                      locationURL: "http://www.google.com/maps/place/$lat,$long");
                  var response = await addRecent({"driverID": provider.currentUser.id, "recent": recentData.toJson()}, provider.currentUser.token);
                  if (response == 200)
                    {

                    }
                },
              ),
            ),),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 12, right: 25, bottom: 25),
                child: FloatingActionButton(
                  heroTag: 'side-menu',
                  backgroundColor: Colors.blueGrey,
                  mini: true,
                  child: const Icon(Icons.menu, color: Colors.white),
                  onPressed: ()  {
                    _scaffoldState.currentState.openDrawer();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );


  }
  Future opendialog() => showDialog(

      context: context,
      builder: (context)=>AlertDialog(

        title: Text("Your review",style: TextStyle(color: Colors.blueGrey),),
        content: TextField(
          decoration: InputDecoration(
              hintText: "type here"
          ),
          onChanged: (value){
              setState(() {
               valueText = value;
          });},
        ),
        actions: [
          TextButton(onPressed: () async {

            await addReview(user: provider.currentUser,cameraID: widget.cameraID,content: valueText);
            var x = await getReviews(widget.cameraID,provider.currentUser.token);
            Navigator.pop(context);
            final snackBar = SnackBar(content:  Text("Review added"));
            setState(() {
              widget.review=x;
            });
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, child: Text("Submit",style: TextStyle(color: Colors.blueGrey),))
        ],
      )
  );
}