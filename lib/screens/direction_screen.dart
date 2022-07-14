import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:park_locator/Model/directionsDetails.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:park_locator/widgets/Appdrawer.dart';
import 'package:park_locator/widgets/d_widgets/from_to.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:park_locator/widgets/review.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Model/DBModels/Recent.dart';
import '../Network/API/Bookmarks.dart';
import '../Network/API/Recents.dart';
import '../Network/API/Reviews.dart';
import '../Network/API/UserAPi.dart';
import '../Shared/Functions.dart';
import '../Shared/Marker.dart';
import '../widgets/bookmarkButton.dart';


class direction_screen extends StatefulWidget{
  @required LatLng currentLocation;
  @required directionsDetails info;
  @required String destinationName;
  @required List <Review> review;
  @required List <String> users;
  @required String cameraID;
  @required bool isStreet;
  @required String garageID;
  String bookmarkID;
  bool ifBookmark;

  direction_screen({this.currentLocation,this.info, this.destinationName, this.review,this.users,this.cameraID, this.ifBookmark, this.bookmarkID,this.isStreet, this.garageID});

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
                  height: MediaQuery.of(context).size.height*0.18,
                  width: MediaQuery.of(context).size.width,
                  // color: Colors.black,
                  child: from_to(source: widget.info.myLocation_name,target: widget.destinationName,
                       destination: widget.info.getDestination()),
                ),
                Container(

                  //padding: const EdgeInsets.only(left: 0.0,top:140,right: 0.0),
                  height: MediaQuery.of(context).size.height*0.42,
                  width: MediaQuery.of(context).size.width,
                  child:
                      GoogleMap(
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
                              padding:const EdgeInsets.only(left: 1),
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
                padding: EdgeInsets.only(top: MediaQuery.of(context).size.height*0.22),
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
                  double destLat = widget.info.getDestination().latitude;
                  double destLong = widget.info.getDestination().longitude;
                  double srcLat = widget.currentLocation.latitude;
                  double srcLong = widget.currentLocation.longitude;
                  String message;

                  recent recentData = new recent(address: widget.destinationName,
                      location: Location(lat: destLat, long: destLong),
                      locationURL: "http://www.google.com/maps/place/$destLat,$destLong");
                  var response = await addRecent({"driverID": provider.currentUser.id, "recent": recentData.toJson()}, provider.currentUser.token);
                  if (response == 200)
                    {
                      url = "https://www.google.com/maps/dir/?api=1&origin=$srcLat,$srcLong&destination=$destLat,$destLong";
                      if (await canLaunchUrlString(url)) {
                        message = "directing to google maps...";
                        await launchUrlString(url);
                      } else {
                        message = "Could not launch url";
                        throw 'Could not launch $url';
                      }
                    }
                  final snackBar = SnackBar(content:  Text(message));
                  ScaffoldMessenger.of(context).showSnackBar(snackBar);
                },
              ),
            ),),

            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.only(top: 10, left: 9, right: 25, bottom: 25),
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
            Align(
              alignment: Alignment(0.96,-0.65),
              child: Padding(
                padding: const EdgeInsets.only(left: 9),
                child: bookmarkButton( context, widget.ifBookmark, widget.bookmarkID, widget.info.getDestination(), widget.destinationName, provider.currentUser),
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
            if (widget.isStreet==true)
              {
                await addStreetReview(user: provider.currentUser,cameraID: widget.cameraID,content: valueText);
              }
            else
            {
              await addGarageReview(user: provider.currentUser,cameraID: widget.cameraID,content: valueText,garageID:widget.garageID);
              }
            var x = await getReviews(widget.cameraID,provider.currentUser.token);
            Navigator.pop(context);
            final snackBar = SnackBar(content:  Text("Review added"));
            setState(() {
              widget.review=x;
              widget.users.add(provider.currentUser.name);
            });
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
          }, child: Text("Submit",style: TextStyle(color: Colors.blueGrey),))
        ],
      )
  );
}