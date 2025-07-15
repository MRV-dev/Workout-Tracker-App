import 'package:flutter/material.dart';
import 'selectworkout.dart'; // Import SelectWorkoutScreen
import 'addworkout.dart'; // Import AddWorkoutScreen

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, String>> workouts = [];

  // Function to add a new workout to the list
  void _addWorkout(Map<String, String> workout) {
    setState(() {
      workouts.add(workout); // Add workout to the list
    });
  }

  @override
  Widget build(BuildContext context) {
    final Purple = Color(0xFFCFBAE1);

    return Scaffold(
      backgroundColor: Color(0xFFF8F8FB),
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
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Latest Workouts',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Display List of Workouts
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: workouts.map((workout) {
                    return _WorkoutCard(
                      icon: Icons.fitness_center,
                      label: workout['name']!,
                      time: workout['duration']!,
                      cal: int.parse(workout['calories']!),
                      schedule: 'Scheduled for: ${workout['date']} at ${workout['time']}',
                      progressColor: Purple,
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavBar(onWorkoutAdded: _addWorkout),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final String label, time, schedule;
  final int cal;
  final Color progressColor;
  final IconData icon;

  const _WorkoutCard({
    required this.icon,
    required this.label,
    required this.time,
    required this.cal,
    required this.progressColor,
    required this.schedule,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.only(bottom: 16), // Add spacing between cards
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [BoxShadow(blurRadius: 8, color: Colors.black12)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: 28,
            backgroundColor: progressColor.withOpacity(0.2),
            child: Icon(icon, color: progressColor, size: 32),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                SizedBox(height: 4),
                Text(
                  '$time  |  $cal Cal',
                  style: TextStyle(color: Colors.grey[600], fontSize: 14),
                ),
                SizedBox(height: 8),
                LinearProgressIndicator(
                  value: cal / 300,
                  backgroundColor: progressColor.withOpacity(0.2),
                  color: progressColor,
                ),
                SizedBox(height: 8),
                Text(
                  schedule,
                  style: TextStyle(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Bottom Navigation
class _BottomNavBar extends StatelessWidget {
  final Function(Map<String, String>) onWorkoutAdded;

  _BottomNavBar({required this.onWorkoutAdded});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      child: BottomNavigationBar(
        selectedItemColor: Color(0xFFbcb9f1),
        unselectedItemColor: Colors.grey[400],
        showSelectedLabels: false,
        showUnselectedLabels: false,
        items: [
          BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.only(right: 5),
              child: Icon(Icons.home_rounded, size: 28)
          ), label: "Home"),

          BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.only(right: 60),
              child: Icon(Icons.calendar_today_rounded, size: 26)
          ), label: "Calendar"),

          BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.only(right: 60),
              child: Icon(Icons.add_circle_outline_rounded, size: 36)
          ), label: "Add"),

          BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.only(right: 60),
              child: Icon(Icons.bar_chart_rounded, size: 28)
          ),  label: "Stats"),

          BottomNavigationBarItem(icon: Padding(
              padding: EdgeInsets.only(right: 60),
              child: Icon(Icons.person_rounded, size: 26)
          ),  label: "Profile"),
        ],
        onTap: (index) {
          if (index == 2) {
            // Navigate to SelectWorkoutScreen when "Add" is pressed
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SelectWorkoutScreen()),
            ).then((selectedWorkouts) {
              if (selectedWorkouts != null) {
                // Navigate to AddWorkoutScreen to fill in the details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddWorkoutScreen(workoutTypes: selectedWorkouts),
                  ),
                ).then((newWorkout) {
                  if (newWorkout != null) {
                    onWorkoutAdded(newWorkout); // Add the new workout to the list
                  }
                });
              }
            });
          }
        },
      ),
    );
  }
}
