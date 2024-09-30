import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database_sample/data/my_record.dart';
import 'package:realtime_database_sample/data/resource_states.dart';

class RecordsController {

  // TODO 3: get the database instance
  FirebaseDatabase database = FirebaseDatabase.instance;
  final ValueNotifier<StateResource<List<MyRecord>>> dataNotifier = ValueNotifier(StateResource.init());

  void init() async {
    // TODO 4: refer to the root node of the created database
    DatabaseReference databaseReference = database.ref('record');
    // TODO 5: listen to the stream of the database reference
    Stream<DatabaseEvent> dataStream = databaseReference.onValue;
    dataStream.listen((DatabaseEvent event) {
      dataNotifier.value = StateResource.loading();
      List<MyRecord> recordsList = [];
      // TODO 6: capture the snapshot in a variable with the same data type
      // the data type of the snapshot value varies according to how you save the data
      // for example if the keys are all integers it'll have the data type of list
      // if they were strings or at least one of them is a string, it'll be a map
      List<dynamic> values = event.snapshot.value as List<dynamic>;
      for(var value in values){
        if(value != null){
          // TODO 7: parse the received data
          MyRecord myRecord = MyRecord.fromJson(value);
          recordsList.add(myRecord);
        }
      }
      // TODO 8: get the new data and wrap it in an observable value.. this can be dismissed if you're gonna listen directly to the stream
      dataNotifier.value = StateResource.success(recordsList);
    });
  }
}