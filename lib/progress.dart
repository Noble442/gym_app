import 'package:flutter/material.dart';

class ProgressTrackerPage extends StatefulWidget {
  @override
  _ProgressTrackerPageState createState() => _ProgressTrackerPageState();
}

class _ProgressTrackerPageState extends State<ProgressTrackerPage> {
  List<Map<String, dynamic>> progress = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Your Progress"),
        backgroundColor: const Color.fromARGB(255, 135, 227, 5),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: progress.length,
              itemBuilder: (context, index) {
                var log = progress[index];
                return ListTile(
                  title: Text(log["exercise"]),
                  subtitle:
                      Text("Date: ${log["date"]} \nWeight: ${log["weight"]}"),
                  leading: Icon(Icons.fitness_center),
                );
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.black,
              backgroundColor:
                  const Color.fromARGB(255, 135, 227, 5),
              padding:
                  EdgeInsets.symmetric(horizontal: 50, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              elevation: 5,
            ),
            onPressed: _addProgressLog,
            child: Text("Add Progress"),
          ),
        ],
      ),
    );
  }

  void _addProgressLog() {
    showDialog(
      context: context,
      builder: (context) {
        String exercise = "";
        String weight = "";
        return AlertDialog(
          title:const Text("Add Progress Log"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration:const InputDecoration(labelText: "Exercise"),
                onChanged: (value) => exercise = value,
              ),
              TextField(
                decoration:const InputDecoration(labelText: "Weight"),
                onChanged: (value) => weight = value,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child:const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  progress.add({
                    "date": DateTime.now().toString().split(" ")[0],
                    "exercise": exercise,
                    "weight": weight,
                  });
                });
                Navigator.pop(context);
              },
              child: const Text("Add"),
            ),
          ],
        );
      },
    );
  }
}
