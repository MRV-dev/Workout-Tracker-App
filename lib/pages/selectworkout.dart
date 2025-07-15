import 'package:flutter/material.dart';

class SelectWorkoutScreen extends StatefulWidget {
  @override
  _SelectWorkoutScreenState createState() => _SelectWorkoutScreenState();
}

class _SelectWorkoutScreenState extends State<SelectWorkoutScreen> {
  final Map<String, List<String>> categorizedWorkouts = {
    'Bodyweight Exercises': [
      'Push-ups',
      'Squats',
      'Lunges',
      'Plank',
      'Mountain Climbers',
      'Burpees',
      'Tricep Dips',
      'Leg Raises',
      'High Knees',
      'Glute Bridges',
      'Bicycle Crunches',
      'Jumping Jacks',
      'Side Plank',
    ],
    'Dumbbell Workouts': [
      'Dumbbell Curl',
      'Dumbbell Shoulder Press',
      'Dumbbell Squats',
      'Dumbbell Rows',
      'Dumbbell Lunges',
      'Dumbbell Deadlifts',
      'Dumbbell Chest Press',
      'Dumbbell Tricep Extensions',
      'Dumbbell Bicep Curls',
      'Dumbbell Chest Flys',
      'Dumbbell Russian Twists',
    ],
    'Core Workouts': [
      'Plank',
      'Russian Twists',
      'Leg Raises',
      'Bicycle Crunches',
      'Sit-ups',
      'Flutter Kicks',
      'Side Plank',
      'V-ups',
      'Hanging Leg Raises',
      'Mountain Climbers',
    ],
    'Cardio Workouts': [
      'Jump Rope',
      'Running in Place',
      'Burpees',
      'High Knees',
      'Jumping Jacks',
      'Sprinting',
      'Step-ups',
      'Fast Walking',
      'Box Jumps',
    ],
    'Flexibility and Stretching': [
      'Hamstring Stretch',
      'Hip Flexor Stretch',
      'Quad Stretch',
      'Shoulder Stretch',
      'Triceps Stretch',
      'Chest Opener Stretch',
      'Child’s Pose',
      'Downward Dog',
      'Cat-Cow Stretch',
    ],
  };

  List<String> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select a Workout'),
      ),
      body: ListView(
        children: categorizedWorkouts.entries.map((entry) {
          return ExpansionTile(
            title: Text(entry.key, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            children: entry.value.map((workout) {
              return CheckboxListTile(
                title: Text(workout),
                value: selectedWorkouts.contains(workout),
                onChanged: (bool? value) {
                  setState(() {
                    if (value != null && value) {
                      selectedWorkouts.add(workout);
                    } else {
                      selectedWorkouts.remove(workout);
                    }
                  });
                },
              );
            }).toList(),
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, selectedWorkouts);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}
