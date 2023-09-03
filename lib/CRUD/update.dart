import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UpdateEntry extends StatefulWidget {
   const UpdateEntry({super.key});

  @override
  State<UpdateEntry> createState() => _UpdateEntryState();
}

class _UpdateEntryState extends State<UpdateEntry> {

  List<String> finalName = [];
  var updateData = TextEditingController();

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
            'Update Entry',
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
                      updateList(index);
                    },
                    icon: const Icon(Icons.edit),
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

  updateList(int index) async {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            title: const Text('Update Entry'),
            content: TextFormField(
              controller: updateData,
              decoration: const InputDecoration(
                hintText: 'Enter updated Entry',
              ),
            ),
            actions: [
              ElevatedButton(
                onPressed:() async {
                if (updateData.text.isNotEmpty) {
                  var prefs = await SharedPreferences.getInstance();
                  prefs.setString('name_$index', updateData.text);
                  setState(() {
                    finalName[index] = updateData.text;
                  });
                  updateData.clear();
                  Fluttertoast.showToast(msg: "Entry Updated");
                  Navigator.pop(context);
                } else {
                  Fluttertoast.showToast(msg: "Please enter a value");
                }
              },
                  child: const Text("Update"))
            ],
          ),

    );
  }

}