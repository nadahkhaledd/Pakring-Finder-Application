import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/DBModels/Review.dart';
import 'package:park_locator/Model/directionsDetails.dart';
import 'package:park_locator/services/API/APIManager.dart';
import 'package:park_locator/widgets/d_widgets/from_to.dart';
import 'package:park_locator/widgets/d_widgets/time.dart';
import 'package:park_locator/widgets/review.dart';
import '../Model/DBModels/Owner.dart';
import '../Model/LocationDetails.dart';
import '../Shared/Marker.dart';


class direction_screen extends StatefulWidget{
  @required var currentLocation;
  @required directionsDetails info;
  @required List <Review> review;
  @required List <String> users;
  @required String cameraID;

  direction_screen({this.currentLocation,this.info,this.review,this.users,this.cameraID});



  @override
  State<direction_screen> createState() => _searchState();


}

class _searchState extends State<direction_screen> {

  String valueText;
  //String cameraID;
  String userID="UtxbOluLTzMTooCY01XD0vqAAUf2";
  bool isBookmark;
  String bookmarkID = '0';

  Future<void> findBookmark()
  async {
    List<Bookmark> bookmarks = await getBookmarks("UtxbOluLTzMTooCY01XD0vqAAUf2");
    bookmarks.forEach((element) {

      if( element.location.lat == widget.info.getDestination().latitude &&
          element.location.long == widget.info.getDestination().longitude)
      {
        setState(() {
          isBookmark = true;
          bookmarkID = element.id;
        });
      }
      else
        isBookmark = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = addMarkers2(widget.currentLocation,widget.info.getDestination());
    findBookmark();

    return Scaffold(
      body: Column(
        children: [
          Container(
            height: MediaQuery.of(context).size.height*0.22,
            width: MediaQuery.of(context).size.width,
           // color: Colors.black,
            child: from_to(source: widget.info.myLocation_name,target: widget.info.destination_name,
              isBookmark: isBookmark, bookmarkID: bookmarkID, destination: widget.info.getDestination(),),
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
          (widget.review.length!=0)? Flexible(child: review(widget.review,widget.users)):
          Container(
            alignment: Alignment.bottomCenter,
            child: Text('\nNo reviews',
              style: TextStyle(color: Colors.blueGrey, fontWeight: FontWeight.bold, fontSize: 15),),
          ),
        ],
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
          TextButton(onPressed: (){

            addReview(userID, widget.cameraID, valueText);
            Navigator.pop(context);
            print(valueText);
          }, child: Text("Submit",style: TextStyle(color: Colors.blueGrey),))
        ],
      )
  );
}