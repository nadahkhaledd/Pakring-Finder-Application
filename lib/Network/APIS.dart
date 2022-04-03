

import 'package:flutter/material.dart';

import 'Dio_helper.dart';
import 'endpoints.dart';

Future<String> getApiData({@required String url, @required String capacity}) async {
String getCapacity;
  await DioHelper.postData(url: FIND, data:{
    "url": url,
    "capacity": capacity,
  })
      .then((value) {
    getCapacity=value.data["spots"].toString() ;
  }).catchError((error){
    print(error.toString());
  });
  return getCapacity;
}



Future<List> GetSpots(List snaps) async
{
  List newSnaps = [];
  if(snaps.length!=0)
    {
      for(int i=0;i<snaps.length;i++)
      {
        String url=snaps[i]["Path"];
        //"https://firebasestorage.googleapis.com/v0/b/parkingfinder-589b5.appspot.com/o/2ce42c9d1876a0c2dd0862a7bb8ef6db.jpg?alt=media&token=88278d5b-4bd2-4757-8ef8-797e094cbe71";
        //
        String cap=(snaps[i]["Capacity"]).toString();
        //="5";
        //
        String spots = await getApiData(url:url, capacity:cap);
         if(int.parse(spots)  > 0)
           newSnaps.add(snaps[i]);

      }
    }

    return newSnaps;
}
