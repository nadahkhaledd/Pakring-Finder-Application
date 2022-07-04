import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:park_locator/Model/DBModels/Bookmark.dart';
import 'package:park_locator/Model/UserData.dart';
import 'package:park_locator/widgets/bookmarkButton.dart';
import 'package:provider/provider.dart';

import '../../services/appprovider.dart';
class from_to extends StatefulWidget
{
  final String source;
  final String target;
  bool isBookmark;
   String bookmarkID;
  LatLng destination;

  from_to({
    @required this.source,
    @required this.target,
    @required this.isBookmark,
    @required this.bookmarkID,
    @required this.destination,
  });

  @override
  State<from_to> createState() => _from_toState();
}

class _from_toState extends State<from_to> {
  AppProvider provider;

  @override
  Widget build(BuildContext context) {
    provider = Provider.of<AppProvider>(context);

    return Container(
      color: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.only(top:45.0,right: 0.0),
                  width: 30,
                  child: Column(
                    children: [
                      Container(

                          child:Icon(Icons.location_on,color: Color(0xff2283ea))
                      ),
                      Container(
                        padding: const EdgeInsets.only(top:20.0,right: 0.0),
                        child:Icon(Icons.location_on,color:Colors.red),
                      ),

                    ],

                  ),
                ),

                Padding(
                    padding: const EdgeInsets.only(top:35.0,right: 0.0),
                    child:Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height*(0.2)*0.3,
                          width:MediaQuery.of(context).size.width*0.7,

                          child: TextField(
                            readOnly: true,

                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                hintText: widget.source,
                                labelText: "source"
                            ),
                            autofocus: false,
                          ),
                        )
                        ,
                        Padding(
                          padding: const EdgeInsets.only(left: 0,top:5.0),
                          child: Container(
                            height: MediaQuery.of(context).size.height*(0.2)*0.3,
                            width:MediaQuery.of(context).size.width*0.7,
                            child: TextField(
                              readOnly: true,
                              decoration: InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: widget.target,
                                  labelText: "destination"
                              ),
                              autofocus: false,
                            ),
                          ),
                        )
                      ],
                    )),
              ],
            ),

            Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                padding: const EdgeInsets.only(left: 8),
                child: bookmarkButton( context, widget.isBookmark, widget.bookmarkID, widget.destination, widget.target, provider.currentUser),
              ),
            )

            ]),
      )

    );
  }
}