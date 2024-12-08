import 'package:flutter/material.dart';

class GymCalculator extends StatelessWidget {
  final TextEditingController weightInput = TextEditingController();
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      appBar: AppBar(
        title: const Text("Weight Calculator"),
        backgroundColor: const Color.fromARGB(255, 135, 227, 5),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: weightInput,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Enter Weight",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    double weight = double.parse(weightInput.text);
                    result = "${(weight * 2.25).toStringAsFixed(2)} lbs";
                    showResult(context, result);
                  },
                  child: Text("Kg to Lbs"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: const Color.fromARGB(255, 135, 227, 5),
                    padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    double weight = double.parse(weightInput.text);
                    result = "${(weight / 2.25).toStringAsFixed(2)} kg";
                    showResult(context, result);
                  },
                  child: Text("Lbs to Kg"),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.grey,
                    backgroundColor: const Color.fromARGB(255, 135, 227, 5),
                    padding:const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    elevation: 5,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void showResult(BuildContext context, String result) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        content: Text(result),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child:const Text("OK"),
          ),
        ],
      ),
    );
  }
}
