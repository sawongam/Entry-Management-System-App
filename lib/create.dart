import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';

class CreateEntry extends StatefulWidget {
  const CreateEntry({super.key});

  @override
  State<CreateEntry> createState() => _CreateEntryState();
}

class _CreateEntryState extends State<CreateEntry> {

  int counter = 0;
  var name = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCounter();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Create Entry',
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 90.0),
            SizedBox(
              width: 340,
              child: TextField(
                controller: name,
                style: const TextStyle(
                  color: Colors.white,
                ),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                        color: Colors.white,
                      ),
                      borderRadius: BorderRadius.circular(36.0),
                    ),
                    labelText: 'Name',
                    labelStyle: const TextStyle(
                      color: Colors.white,
                    ),
                    suffixIcon: IconButton(
                      icon: const Icon(
                        Icons.arrow_forward,
                        color: Colors.white,
                      ),
                      onPressed: () {
                        createList();
                      },
                    ),
                  ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void getCounter() async {
    var prefs = await SharedPreferences.getInstance();
    setState(() {
      counter = prefs.getInt('counter') ?? 0;
    });
  }

   createList() {
     if(name.text.isNotEmpty) {
       var entryName = name.text;
       SharedPreferences.getInstance().then((prefs) {
         prefs.setString('name_$counter', entryName);
         name.clear();
         Fluttertoast.showToast(msg: 'Entry Created');
         counter++;
         prefs.setInt('counter', counter);
       });
     } else {
       Fluttertoast.showToast(msg: 'Name is required');
     }
   }


}
