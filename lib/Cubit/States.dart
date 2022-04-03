abstract class parkingLocatorStates{}
class parkingInitialStates extends parkingLocatorStates{}
class parkingDTStates extends parkingLocatorStates{}
class parkingFindStates extends parkingLocatorStates{}
class parkingMarkerStates extends parkingLocatorStates{}
class parkingLoadingStates extends parkingLocatorStates{}
class parkingGetDataStates extends parkingLocatorStates{}
class parkingErrorStates extends parkingLocatorStates{
 final String error;

  parkingErrorStates(this.error);

}



