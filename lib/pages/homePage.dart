import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/workoutDetail.dart';
import 'package:workout_tracker/pages/selectworkout.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> workouts = [];

  void _addWorkout(List<Map<String, dynamic>> selectedWorkouts) {
    setState(() {
      workouts.add({
        'workouts': selectedWorkouts,
        'cardLabel': selectedWorkouts.map((workout) => workout['workout']).join(', '),
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final Purple = Color(0xFFCFBAE1);

    return Scaffold(
      backgroundColor: Color(0xFF04284E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(
                          'WORKOUT TRACKER',
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'RobotoCondensed',
                            color: Color(0xFF77B5F8)
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: workouts.isEmpty
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No workouts added. Tap "Add Workout" to begin.',
                    style: TextStyle(color: Colors.grey[600], fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                )
                    : Column(
                  children: workouts.map((workout) {
                    return _WorkoutCard(
                        icon: Icons.fitness_center,
                        label: workout['cardLabel']!,
                        time: 'Duration: ${workout['workouts'][0]['timer']} seconds',
                        reps: '',
                        sets: '',
                        cal: workout['workouts'][0]['timer'] ?? 0,
                        progressColor: Purple,
                        iconColor: Color(0xFF3D96F5),
                        backgroundColor: Color(0xFF1C3552),
                        onTap: () async {
                          final remainingWorkouts = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => WorkoutDetailsPage(workouts: workout['workouts']),
                            ),
                          );

                          if (remainingWorkouts != null) {
                            setState(() {
                              if (remainingWorkouts.isEmpty) {
                                workouts.remove(workout);

                                // 🎉 Show success message
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Workout completed! 🎉"),
                                    duration: Duration(seconds: 2),
                                  ),
                                );
                              } else {
                                workout['workouts'] = remainingWorkouts;
                                workout['cardLabel'] = remainingWorkouts.map((w) => w['workout']).join(', ');
                              }
                            });
                          }
                        }
                    );
                  }).toList(),
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: ElevatedButton.icon(
                  icon: Icon(Icons.add_circle_outline_rounded),
                  label: Text("Add Workout"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF084F9B),
                    foregroundColor: Colors.white,
                    padding: EdgeInsets.symmetric(vertical: 14, horizontal: 20),
                    textStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () async {
                    final selectedWorkoutsData = await Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SelectWorkoutScreen()),
                    );

                    if (selectedWorkoutsData != null) {
                      _addWorkout(selectedWorkoutsData);
                    }
                  },
                ),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String label, time, reps, sets;
  final int cal;
  final Color progressColor;
  final Color backgroundColor;
  final IconData icon;
  final Color iconColor;
  final Function onTap;

  const _WorkoutCard({
    required this.icon,
    required this.label,
    required this.time,
    required this.reps,
    required this.sets,
    required this.cal,
    required this.progressColor,
    required this.backgroundColor,
    required this.iconColor,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 28,
              backgroundColor: progressColor.withOpacity(0.2),
              child: Icon(icon, color: iconColor, size: 32),
            ),
            SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                  SizedBox(height: 4),
                  if (sets.isNotEmpty) SizedBox(height: 4),
                  if (sets.isNotEmpty) Text(sets, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  if (reps.isNotEmpty) SizedBox(height: 4),
                  if (reps.isNotEmpty) Text(reps, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  SizedBox(height: 8),

                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
