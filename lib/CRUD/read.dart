import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ViewEntryList extends StatefulWidget {
  const ViewEntryList({super.key});

  @override
  State<ViewEntryList> createState() => _ViewEntryListState();
}

class _ViewEntryListState extends State<ViewEntryList> {

  List<String> finalName = [];

  @override
  void initState() {
    super.initState();
    getName();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100.0),
          const Text(
            'Entry List',
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 30.0),
          Expanded(
            child: ListView.builder(itemBuilder: (context, index) {
              return Card(
                color: Colors.blueGrey[800],
                child: ListTile(
                  title: Center(
                    child: Text(finalName[index],
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        fontSize: 20.0,
                      ),
                    ),
                  )
                ),
              );
            },
             itemCount: finalName.length),
          ),
        ],
      ),
    );
  }

  void getName() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      int count = prefs.getInt('counter') ?? -1;
      if (count == -1) {
        finalName.add('No Entries');
      }
      for (int i = 0; i < count; i++) {
        String? list = prefs.getString('name_$i');
        if (list != null) {
          finalName.add(prefs.getString('name_$i') ?? 'No Value');
        } else {
          continue;
        }
      }
    });
  }


}