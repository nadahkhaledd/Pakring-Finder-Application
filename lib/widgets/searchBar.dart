import 'package:flutter/material.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:search_map_location/search_map_location.dart';

class searchBar extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    final isPortrait = MediaQuery.of(context).orientation == Orientation.portrait;

    return FloatingSearchBar(
      hint: 'enter location',
      openAxisAlignment: 0.0,
      axisAlignment: isPortrait ? 0.0 : -1.0 ,
      elevation: 4.0,
      automaticallyImplyDrawerHamburger: false,
      transitionCurve: Curves.easeInOut,
      transitionDuration: Duration(milliseconds: 500),
      transition: CircularFloatingSearchBarTransition(),
      debounceDelay: Duration(milliseconds: 500),

      onQueryChanged: (query)
      {
        ///
      },
      actions: [
        FloatingSearchBarAction(
          showIfOpened: false,
          child: CircularButton(icon: Icon(Icons.place),
            onPressed: null,)
        ),
        FloatingSearchBarAction.searchToClear(
          showIfClosed: false,

        )
      ],
      builder: (context, transition){
        return ClipRRect(
          child: Material(
            color: Colors.white,
            child: Container(
              height: 200.0,
              color: Colors.white,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Home'),
                    subtitle: Text('other...'),

                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

}