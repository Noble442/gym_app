import 'package:gym_app/exercises.dart';
import 'package:gym_app/workout.dart';

class WorkoutData {
  List<Workout> workoutList = [];

  List<Workout> getWorkoutList() {
    return workoutList;
  }

  void addWorkout(String name) {
    workoutList.add(Workout(name: name, exercises: []));
  }

  void addExercise(String workoutName, String exerciseName, String weight,
      String reps, String sets) {
    Workout relevantWorkout= getRelevantWorkout(workoutName);

    relevantWorkout.exercises.add(
        Exercises(name: exerciseName, weight: weight, reps: reps, sets: sets));
  }

  void checkExercise(String workoutName,String exerciseName){
   Exercises relevantExercise = getRelevantExercise(workoutName, exerciseName);

   relevantExercise.isCompleted= !relevantExercise.isCompleted;
  }




  Workout getRelevantWorkout(String workoutName){
    Workout relevantWorkout =
        workoutList.firstWhere((workout) => workout.name == workoutName);

    return relevantWorkout;
  }

  Exercises getRelevantExercise(String workoutName, String exerciseName){
    Workout relevantWorkout= getRelevantWorkout(workoutName);

    Exercises relevantExercise =relevantWorkout.exercises.firstWhere((exercise) => exercise.name==exerciseName);

    return relevantExercise;

  }

}
