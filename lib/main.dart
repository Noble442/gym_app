import 'package:flutter/material.dart';
import 'package:gym_app/data.dart';
import 'package:gym_app/progress.dart';
import 'package:gym_app/workout.dart';
import 'package:gym_app/exercises.dart';
import 'gym_calculator.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: WorkoutPage(),
    );
  }
}

class WorkoutPage extends StatefulWidget {
  @override
  _WorkoutWidget createState() => _WorkoutWidget();
}

class _WorkoutWidget extends State<WorkoutPage> {
  final WorkoutData workoutData = WorkoutData();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text('Your GYMBRO')),
        backgroundColor: const Color.fromARGB(255, 135, 227, 5),
        shadowColor: Colors.grey,
        actions: [
          IconButton(
            icon: Icon(Icons.calculate),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => GymCalculator()),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.show_chart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProgressTrackerPage()),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: workoutData.getWorkoutList().length,
        itemBuilder: (context, index) {
          Workout workout = workoutData.getWorkoutList()[index];
          return ExpansionTile(
            title: Text(workout.name),
            children: workout.exercises.map((exercise) {
              return ListTile(
                tileColor: exercise.isCompleted
                    ? Color.fromARGB(255, 135, 227, 5)
                    : null, 
                subtitle: Text(
                  "Weight: ${exercise.weight},\nReps: ${exercise.reps},\nSets: ${exercise.sets}",
                ),
                trailing: Checkbox(
                  value: exercise.isCompleted,
                  onChanged: (value) {
                    setState(() {
                      workoutData.checkExercise(workout.name, exercise.name);
                    });
                  },
                ),
              );
            }).toList()
              ..add(
                ListTile(
                  title: Text("Add Exercise"),
                  leading: Icon(Icons.add),
                  onTap: () {
                    _AddExerciseDialog(workout.name);
                  },
                ),
              ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: const Color.fromARGB(255, 135, 227, 5),
        onPressed: _AddWorkoutDialog,
      ),
    );
  }

  void _AddWorkoutDialog() {
    String workoutName = "";
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Add Workout"),
          content: TextField(
            decoration: const InputDecoration(labelText: "Workout Name"),
            onChanged: (value) {
              workoutName = value;
            },
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  workoutData.addWorkout(workoutName);
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

  void _AddExerciseDialog(String workoutName) {
    String exerciseName = "";
    String weight = "";
    String reps = "";
    String sets = "";

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Exercise to $workoutName"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: const InputDecoration(labelText: "Exercise Name"),
                onChanged: (value) {
                  exerciseName = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Weight"),
                onChanged: (value) {
                  weight = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Reps"),
                onChanged: (value) {
                  reps = value;
                },
              ),
              TextField(
                decoration: const InputDecoration(labelText: "Sets"),
                onChanged: (value) {
                  sets = value;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  workoutData.addExercise(
                      workoutName, exerciseName, weight, reps, sets);
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
