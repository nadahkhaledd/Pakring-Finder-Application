import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Network/API/Bookmarks.dart';
import 'package:park_locator/Shared/Functions.dart';
import 'package:park_locator/services/appprovider.dart';
import 'package:provider/provider.dart';
import '../Model/DBModels/Bookmark.dart';
import '../Model/DBModels/Review.dart';
import '../Model/DBModels/Owner.dart';
import '../Model/Location.dart';
import '../Model/UserData.dart';
import '../Model/directionsDetails.dart';
import '../Network/API/Reviews.dart';
import '../Network/API/UserAPi.dart';
import '../Shared/Components.dart';
import '../screens/direction_screen.dart';
import 'Appdrawer.dart';
import 'loadingIndicator.dart';

class NearbyPlaces extends StatefulWidget
{
   List data;
   LatLng source;
   bool isStreet;
   NearbyPlaces(this.data, this.source,this.isStreet);

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  bool isLoading = false;
  AppProvider provider;
  String bookmarkID;
  bool bookmarkBool;
  
  String setDetails(int index)
  {
    String details = '';
    if(widget.isStreet)
    {
        details = widget.data[index].spots + " spots  " + widget.data[index].distance;
    }
    else
      {
          for( var camera in widget.data[index].cameraIDs)
          {
            details += camera['cameraAddress'] + '\t\t ' + camera['spot'].toString() + ' spots\n';
          }
      }
    return details;
  }


  Future<List<Review>> reviews(q, String userToken) async {
    setState(() {
      isLoading = true;
    });
    List<Review> review;
    if (widget.isStreet==true)
      {
       review =await getStreetReviews(q, userToken);
      }
    else
      {
        review=await getGarageReviews(q, userToken);
      }
    setState(() {
      isLoading = false;
    });
    return review;
  }



  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);

    return Stack(
          children:[
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
              child: Container(
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.vertical(top: Radius.circular(30)),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: ListView.builder(

                  itemCount: widget.data.length,
                  itemBuilder: (context, index) {
                    String sub = setDetails(index);
                    return ListTile(
                      leading: Container(
                        alignment: Alignment.center,
                        height: heightResponsive(
                            height: 15, context: context),
                        width:
                        widthResponsive(context: context, width: 8),
                        decoration: BoxDecoration(
                          color: Colors.blueGrey,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          widget.data[index].time,
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                          textAlign: TextAlign.center,
                        ),
                      ),

                      title: Text(widget.data[index].name+"\n"+widget.data[index].distance, overflow:  TextOverflow.ellipsis),
                      subtitle: Text(sub),
                      trailing: IconButton(
                        icon: Icon(
                          Icons.directions,
                          color: Colors.blueGrey,
                          size: 35,
                        ),
                        onPressed: () async {
                          var info = directionsDetails(widget.source, widget.data[index].location);
                          await info.create();

                          String id = await checkUserBookmark(provider.currentUser.id,
                              Location(lat: info.getDestination().latitude, long: info.getDestination().longitude), provider.currentUser.token);
                          if(id != '0')
                          {
                            setState(() {
                              bookmarkID = id;
                              bookmarkBool = true;
                            });
                          }
                          else
                          {
                            setState(() {
                              bookmarkID = '0';
                              bookmarkBool = false;
                            });
                          }
                          if (widget.isStreet==true)
                          {
                            var review=await reviews(widget.data[index].cameraID, provider.currentUser.token);
                            navigateTo(context, direction_screen(currentLocation: widget.source,info: info,
                                destinationName: widget.data[index].name, review: review,
                                cameraID:widget.data[index].cameraID,garageID:null, ifBookmark: bookmarkBool, bookmarkID: bookmarkID,isStreet:widget.isStreet));
                          }
                          else
                          {
                            var review=await reviews(widget.data[index].garageID, provider.currentUser.token);
                            navigateTo(context, direction_screen(currentLocation: widget.source,info: info,
                                destinationName: widget.data[index].name, review: review,
                               cameraID:widget.data[index].cameraID,garageID:widget.data[index].garageID, ifBookmark: bookmarkBool, bookmarkID: bookmarkID,isStreet:widget.isStreet));

                          }
                        },
                      ),

                    );
                  }
              ),

          ),
            ),
            Center( child: isLoading == true ?
            loadingIndicator(context, "loading", true)
                : Center(),
            )
          ]


      );

  }
}
