import 'package:flutter/material.dart';
import 'package:realtime_database_sample/data/my_record.dart';
import 'package:realtime_database_sample/data/resource_states.dart';
import 'package:realtime_database_sample/features/records/records_controller.dart';

class RecordsScreen extends StatefulWidget {
  const RecordsScreen({super.key});

  @override
  State<RecordsScreen> createState() => _RecordsScreenState();
}

class _RecordsScreenState extends State<RecordsScreen> {

  late final RecordsController controller = RecordsController();

  @override
  void initState() {
    super.initState();
    controller.init();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Table'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            // TODO 9: listen to the changes in the view
            child: ValueListenableBuilder<StateResource<List<MyRecord>>>(
              valueListenable: controller.dataNotifier,
              builder: (context, state, child) {
                if (state.isLoading()) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state.isSuccess()) {
                  List<MyRecord> records = state.data!;
                  if(records.isEmpty) return const Center(child: Text('No records yet.'));
                  return Table(
                    border: TableBorder.all(),
                    columnWidths: const {
                      1: FlexColumnWidth(),
                      2: FlexColumnWidth(),
                    },
                    children: [
                      TableRow(
                        children:
                        ['Name', 'Age']
                            .map(
                              (header) =>
                              TableCell(
                                verticalAlignment: TableCellVerticalAlignment.middle,
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Center(
                                    child: Text(header, textAlign: TextAlign.center),
                                  ),
                                ),
                              ),
                        )
                            .toList(),
                      ),
                      ...records.map(
                            (record) =>
                            TableRow(
                              children: [
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(record.name)
                                  ),
                                ),
                                TableCell(
                                  verticalAlignment: TableCellVerticalAlignment.middle,
                                  child: Padding(
                                      padding: const EdgeInsets.all(2),
                                      child: Text(record.age.toString())
                                  ),
                                ),
                              ],
                            ),
                      ),
                    ],
                  );
                }
                return Container();
              },
            ),
          ),
        ),
      ),
    );
  }
}