import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:realtime_database_sample/data/my_record.dart';
import 'package:realtime_database_sample/data/resource_states.dart';

class RecordsController {

  FirebaseDatabase database = FirebaseDatabase.instance;
  final ValueNotifier<StateResource<List<MyRecord>>> dataNotifier = ValueNotifier(StateResource.init());

  void init() async {
    DatabaseReference databaseReference = database.ref('record');
    Stream<DatabaseEvent> dataStream = databaseReference.onValue;
    dataStream.listen((DatabaseEvent event) {
      dataNotifier.value = StateResource.loading();
      List<MyRecord> recordsList = [];
      // the data type of the snapshot value varies according to how you save the data
      // for example if the keys are all integers it'll have the data type of list
      // if they were strings or at least one of them is a string, it'll be a map
      List<dynamic> values = event.snapshot.value as List<dynamic>;
      for(var value in values){
        if(value != null){
          MyRecord myRecord = MyRecord.fromJson(value);
          recordsList.add(myRecord);
        }
      }
      dataNotifier.value = StateResource.success(recordsList);
    });
  }
}