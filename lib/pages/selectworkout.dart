import 'package:flutter/material.dart';

// Define dynamic and static workouts
final Map<String, Map<String, dynamic>> dynamicWorkouts = {
  'Push-ups': {'sets': 3, 'repetitions': 15, },
  'Squats': {'sets': 4, 'repetitions': 20, },
  'Lunges': {'sets': 3, 'repetitions': 12, },
  'Mountain Climbers': {'sets': 3, 'repetitions': 30, },
  'Burpees': {'sets': 4, 'repetitions': 15, },
  'Tricep Dips': {'sets': 3, 'repetitions': 12, },
  'Leg Raises': {'sets': 3, 'repetitions': 15, },
  'High Knees': {'sets': 4, 'repetitions': 30, },
};

final Map<String, Map<String, dynamic>> staticWorkouts = {
  'Plank': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Side Plank': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Wall Sit': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Glute Bridge Hold': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Isometric Squat Hold': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Boat Pose': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Superman Hold': {'sets': 0, 'repetitions': 0, 'timer': 60, },
  'Handstand Hold': {'sets': 0, 'repetitions': 0, 'timer': 60, },
};


class SelectWorkoutScreen extends StatefulWidget {
  @override
  _SelectWorkoutScreenState createState() => _SelectWorkoutScreenState();
}

class _SelectWorkoutScreenState extends State<SelectWorkoutScreen> {
  List<String> selectedWorkouts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF031E3A),
      appBar: AppBar(
        backgroundColor: Color(0xFF063B74),
        title: Text('Select a Workout'),
      ),
      body: ListView(
        children: [
          // Dynamic Workouts (sets and repetitions)
          ExpansionTile(
            title: Text('Dynamic Workouts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            children: dynamicWorkouts.keys.map((workout) {
              return CheckboxListTile(
                title: Text(workout, style: TextStyle( color: Colors.white, fontWeight: FontWeight.w400),),
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
          ),

          // Static Workouts (timer-only)
          ExpansionTile(
            title: Text('Static Workouts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white)),
            children: staticWorkouts.keys.map((workout) {
              return CheckboxListTile(
                title: Text(workout, style: TextStyle( color: Colors.white, fontWeight: FontWeight.w400),),
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
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Collect selected workouts with predefined values and send to homepage
          List<Map<String, dynamic>> selectedWorkoutsData = selectedWorkouts.map((workout) {
            bool isTimerOnly = staticWorkouts.containsKey(workout);

            // Select videoPath based on workout type
            String? videoPath;
            if (isTimerOnly) {
              videoPath = staticWorkouts[workout]?['videoPath'];
            } else {
              videoPath = dynamicWorkouts[workout]?['videoPath'];
            }

            return {
              'workout': workout,
              'sets': isTimerOnly ? 0 : dynamicWorkouts[workout]?['sets'] ?? 0,
              'repetitions': isTimerOnly ? 0 : dynamicWorkouts[workout]?['repetitions'] ?? 0,
              'timer': staticWorkouts[workout]?['timer'] ?? dynamicWorkouts[workout]?['timer'] ?? 0,
              'videoPath': videoPath,
            };
          }).toList();


          Navigator.pop(context, selectedWorkoutsData);
        },
        child: Icon(Icons.check),
      ),
    );
  }
}

