import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeleteEntry extends StatefulWidget {
  const DeleteEntry({super.key});

  @override
  State<DeleteEntry> createState() => _ViewDeleteEntryState();
}

class _ViewDeleteEntryState extends State<DeleteEntry> {

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
            'Delete Entry',
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
                    ),
                  trailing: IconButton(
                    onPressed: () async {
                      deleteList(index);
                    },
                    icon: const Icon(Icons.delete),
                    color: Colors.grey[400],
                ),
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
        return;
      }
      for (int i = 0; i < count; i++) {
        String? list = prefs.getString('name_$i');
        if (list == null) {
          continue;
        } else {
          finalName.add(prefs.getString('name_$i') ?? 'No Value');
        }
      }
    });
  }

deleteList(int index) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.remove('name_$index');
    setState(() {
      finalName.removeAt(index);
    });

    // Update the indices in SharedPreferences for the remaining items
    for (int i = index; i < finalName.length; i++) {
      // Get the value for the current index (i) in the finalName list
      String? value = prefs.getString('name_$i');

      // If the value is not null, remove the old key-value pair from SharedPreferences
      if (value != null) {
        prefs.remove('name_$i');
      }

      // Add the updated value with the new key (i-1) in SharedPreferences
      prefs.setString('name_${i - 1}', value!);
    }

    // Update the counter in SharedPreferences to reflect the updated list length
    prefs.setInt('counter', finalName.length);
}


}