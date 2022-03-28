import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/Location.dart';
import 'package:provider/provider.dart';

import '../../Model/DateTime.dart';
import '../../Model/LocationDetails.dart';
import '../../Shared/Components.dart';
import '../../Shared/Constants.dart';
import '../direction_screen.dart';


class MarkedPlaces extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final currentLocation = Provider.of<Position>(context);
    Location home=new Location(lng: 30.0395,lat:31.2025);
    final Set<Marker> markers = addMarkers(locs);
  //  final Set<DT> dt =  getDistanceAndTime(locs,home);
    return  Scaffold(
      body: SafeArea(
            child: Container(
              //color: Colors.grey[200],
              child: Expanded(
                child: Column(

                  crossAxisAlignment:CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: MediaQuery.of(context).size.height * 1.5 / 3,
                      width: MediaQuery.of(context).size.width,
                      child: GoogleMap(
                        markers:markers,
                        initialCameraPosition: (currentLocation != null)
                            ? (CameraPosition(
                            target: LatLng(currentLocation.latitude,
                                currentLocation.longitude),
                            zoom: 15.0))
                            : (CameraPosition(
                            target: LatLng(30.0395, 31.2025), zoom: 13.0)),
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        rotateGesturesEnabled: true,
                        myLocationButtonEnabled: true,
                        // myLocationEnabled: true,
                        padding: EdgeInsets.only(
                          top: 270.0,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Expanded(
                        child: Text("Nearby Places",style: TextStyle(
                          fontSize: 20,
                          //color: Colors.blue,
                          fontWeight: FontWeight.bold
                        ),
                 ),
                      ),
                    ),
                    Expanded(
                      child:Padding(
                        padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
                        child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.vertical( top: Radius.circular(30) ),
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

                              itemCount: locs.length,
                              itemBuilder: (context, index) => ListTile(
                                leading: Container(
                                    alignment: Alignment.center,
                                    height:heightResponsive(height: 15,context: context),
                                    width: widthResponsive(context: context, width: 8),
                                    decoration: BoxDecoration(
                                      color: Colors.blue,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Text(
                                         getDistance(locs[index].location,home) .toString(),
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15
                                      ),
                                    ),
                                ),
                                title: Text(locs[index].name),
                                subtitle: Text(locs[index].capacity+" Spots"),
                                trailing: IconButton(
                                  icon: Icon(Icons.directions,color: Colors.blue,size: 35,),
                                  onPressed: (){navigateTo(context, direction_screen());},


                                ),
                              )),
                        ),
                      ),

                    )
                  ],

                ),
              ),
            ),
          ));
        }

}
