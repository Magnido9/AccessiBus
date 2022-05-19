
import 'package:firebase_database/firebase_database.dart';

class WaitStation{
  int passengersCounter;
  int stationId;
  WaitStation(this.passengersCounter, this.stationId );
}
class DriverData {

  static FirebaseDatabase database = FirebaseDatabase.instance;

  static Future<List<WaitStation>> getNextStations(int line) async {
     List<WaitStation> results=[];
     List<int> threeNearestStation = getNearestStations(3);
     for(var i = 0; i < threeNearestStation.length; i++){
       results.add(WaitStation (await getPassengersCount(threeNearestStation[i], line), threeNearestStation[i]));
    }

     return results;
  }

  static List<int> getNearestStations(int numberOfStations){
     return [41507,41507,41507];
  }

  static Future<int> getPassengersCount(int stationId, int line) async {
    var snapshotPassengers = await database.ref().child('stations/$stationId/$line/passengers').get();
    if(snapshotPassengers.exists){
      var numPass = snapshotPassengers.value as int;
      return numPass;
    }
    print("didn't found");
    return 0; // the station is probably with out disable pass.
  }

}
