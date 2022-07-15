import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

Widget cardItem(context, String name)
{
  return Builder(
    builder: (context){
      return GestureDetector(
        child: Card(
          child: Padding(
              padding: const EdgeInsets.all(9.0),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Text(name, style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w400, fontSize: 16),
                    overflow:  TextOverflow.fade),
              )
          ),
        ),
        onTap: (){
          final slidable = Slidable.of(context);
          final isClosed = slidable.renderingMode == SlidableRenderingMode.none;

          if(isClosed)
            slidable.open(actionType: SlideActionType.secondary);

          else
            slidable.close();
        },

      );
    },
  );

}