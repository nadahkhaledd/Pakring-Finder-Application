

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/LocationDetails.dart';
import 'package:park_locator/Shared/Constants.dart';
import 'package:park_locator/services/API/APIManager.dart';
import '../Model/DBModels/Review.dart';
import '../Model/directionsDetails.dart';
import '../Shared/Components.dart';
import '../screens/direction_screen.dart';
import 'loadingIndicator.dart';

class NearbyPlaces extends StatefulWidget
{
   List data;
   LatLng source;
   NearbyPlaces(this.data, this.source);

  @override
  State<NearbyPlaces> createState() => _NearbyPlacesState();
}

class _NearbyPlacesState extends State<NearbyPlaces> {
  bool isLoading = false;
  Future<List<Review>> reviews(q) async {
    setState(() {
      isLoading = true;
    });
    var review=await getReviews(q);
    setState(() {
      isLoading = false;
    });
    return review;
  }
  @override
  Widget build(BuildContext context) {
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
                itemBuilder: (context, index) => ListTile(
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
                  title: Text(widget.data[index].name,
                    overflow:  TextOverflow.ellipsis,

                  ),
                  subtitle: Text(widget.data[index].spots + " Spots  "+  widget.data[index].distance),
                  trailing: IconButton(
                    icon: Icon(
                      Icons.directions,
                      color: Colors.blueGrey,
                      size: 35,
                    ),
                    onPressed: () async {
                      var info = directionsDetails(widget.source, widget.data[index].location);
                      await info.create();
                     var review=await reviews(widget.data[index].cameraID);
                      navigateTo(context, direction_screen(currentLocation: widget.source,info: info,review: review,));
                    },
                  ),
                )),

        ),
          ),
          Center( child: isLoading == true ?
          loadingIndicator(context, "loading")
              : Center(),
          )
        ]


    );

  }
}
