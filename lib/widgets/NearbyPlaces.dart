

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:park_locator/Model/LocationDetails.dart';
import '../Model/directionsDetails.dart';
import '../Shared/Components.dart';
import '../screens/direction_screen.dart';

class NearbyPlaces extends StatelessWidget
{
   List data;
   LatLng source;
   NearbyPlaces(this.data, this.source);
  @override
  Widget build(BuildContext context) {
    return Padding(
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
            itemCount: data.length,
            itemBuilder: (context, index) => ListTile(
              leading: Container(
                alignment: Alignment.center,
                height: heightResponsive(
                    height: 15, context: context),
                width:
                widthResponsive(context: context, width: 8),
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  data[index].time,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
              title: Text(data[index].name,
                overflow:  TextOverflow.ellipsis,

              ),
              subtitle: Text(data[index].spots + " Spots  "+  data[index].distance),
              trailing: IconButton(
                icon: Icon(
                  Icons.directions,
                  color: Colors.blue,
                  size: 35,
                ),
                onPressed: () async {
                  var info = directionsDetails(source, data[index].location);
                  await info.create();
                  navigateTo(context, direction_screen(currentLocation: source,info: info));
                },
              ),
            )),
      ),
    );
  }

}
