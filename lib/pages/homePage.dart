import 'package:flutter/material.dart';
import 'package:workout_tracker/pages/workoutDetail.dart';
import 'package:intl/intl.dart' show DateFormat;


class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  List<Map<String, dynamic>> workouts = [];
  DateTime? selectedDate = DateTime.now();
  int selectedMonth = DateTime
      .now()
      .month; // default to current month
  int selectedYear = DateTime
      .now()
      .year;


  void _addWorkout(List<Map<String, dynamic>> selectedWorkoutList, DateTime selectedDate) {
    setState(() {
      workouts.add({
        'cardLabel': selectedWorkoutList.map((w) => w['workout']).join(', '),
        'date': selectedDate.toLocal().toString().split(' ')[0],
        'workouts': selectedWorkoutList,
        'timeOfDay': selectedWorkoutList[0]['timeOfDay'],
        'reps': selectedWorkoutList.map((w) => w['reps']).join(', '),
        'sets': selectedWorkoutList.map((w) => w['sets']).join(', '),
      });
      this.selectedDate = selectedDate;
      print("Added workouts: ${selectedWorkoutList.map((w) => w['workout']).join(', ')}");
    });
  }



  List<Map<String, dynamic>> _getWorkoutsForCategory(String category) {
    if (category == 'Arms') {
      return [
        {'workout': 'Push-ups', 'sets': 3, 'reps': 15},
        {'workout': 'Tricep Dips', 'sets': 3, 'reps': 12},
        {'workout': 'Diamond Push-ups', 'sets': 3, 'reps': 12},
        {'workout': 'Bicep Curls', 'sets': 3, 'reps': 12},
        {'workout': 'Close-grip Push-ups', 'sets': 3, 'reps': 12},
        {'workout': 'Inchworms', 'sets': 3, 'reps': 10},
        {'workout': 'Arm Circles', 'sets': 3, 'reps': 30},
        {'workout': 'Tricep Push-ups', 'sets': 3, 'reps': 15},
        {'workout': 'Bicep Curls (Resistance Band)', 'sets': 3, 'reps': 12},
      ];
    } else if (category == 'Abs') {
      return [
        {'workout': 'Crunches', 'sets': 3, 'reps': 20},
        {'workout': 'Leg Raises', 'sets': 3, 'reps': 15},
        {'workout': 'Russian Twists', 'sets': 3, 'reps': 20},
        {'workout': 'Plank', 'duration': 15},
        {'workout': 'Bicycle Crunches', 'sets': 3, 'reps': 15},
        {'workout': 'Flutter Kicks', 'sets': 3, 'reps': 20},
        {'workout': 'V-ups', 'sets': 3, 'reps': 15},
        {'workout': 'Side Crunches', 'sets': 3, 'reps': 20},
        {'workout': 'Scissor Kicks', 'sets': 3, 'reps': 20},
        {'workout': 'Toe Touches', 'sets': 3, 'reps': 20},
        {'workout': 'Mountain Climbers', 'sets': 4, 'reps': 30},
        {'workout': 'Lying Leg Raise Hold', 'duration': 15},
        {'workout': 'V-Sit Hold', 'duration': 15},
      ];
    } else if (category == 'Legs') {
      return [
        {'workout': 'Squats', 'sets': 3, 'reps': 15},
        {'workout': 'Lunges', 'sets': 3, 'reps': 12},
        {'workout': 'Glute Bridges', 'sets': 3, 'reps': 15},
        {'workout': 'Step-ups (Chair)', 'sets': 3, 'reps': 12},
        {'workout': 'Jump Squats', 'sets': 3, 'reps': 15},
        {'workout': 'Calf Raises', 'sets': 3, 'reps': 20},
        {'workout': 'Bulgarian Split Squats', 'sets': 3, 'reps': 12},
        {'workout': 'Curtsy Lunges', 'sets': 3, 'reps': 12},
        {'workout': 'Wall Sit', 'duration': 15},
        {'workout': 'Hip Thrusts', 'sets': 3, 'reps': 15},
        {'workout': 'Single-leg Romanian Deadlifts', 'sets': 3, 'reps': 12},
        {'workout': 'Static Lunge Hold', 'duration': 15},
      ];
    } else if (category == 'Full Workout') {
      return [
        {'workout': 'Burpees', 'sets': 4, 'reps': 20},
        {'workout': 'Mountain Climbers', 'sets': 4, 'reps': 30},
        {'workout': 'High Knees', 'sets': 4, 'reps': 30},
        {'workout': 'Jumping Jacks', 'sets': 4, 'reps': 30},
        {'workout': 'Bodyweight Circuit', 'sets': 3, 'reps': 10},
        {'workout': 'Jump Lunges', 'sets': 3, 'reps': 12},
        {'workout': 'Tuck Jumps', 'sets': 3, 'reps': 15},
        {'workout': 'Bear Crawls', 'sets': 3, 'reps': 15},
        {'workout': 'Frog Jumps', 'sets': 3, 'reps': 15},
        {'workout': 'Windshield Wipers', 'sets': 3, 'reps': 15},
        {'workout': 'Skater Jumps', 'sets': 3, 'reps': 15},
        {'workout': 'Plank Hold', 'duration': 15},
        {'workout': 'Wall Sit Hold', 'duration': 15},
      ];
    }
    return [];
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
      context: context,
      initialDate: selectedDate ?? DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2101),
    ) ?? selectedDate!;

    setState(() {
      selectedDate = picked;
    });
  }


  @override
  Widget build(BuildContext context) {
    final Purple = Color(0xFFCFBAE1);

    List<Map<String, dynamic>> filteredWorkouts = workouts.where((workout) {
      if (selectedDate == null) return false;
      final workoutDate = DateTime.parse(workout['date']);
      return workoutDate.day == selectedDate!.day &&
          workoutDate.month == selectedDate!.month &&
          workoutDate.year == selectedDate!.year;
    }).toList();

    return Scaffold(
      backgroundColor: Color(0xFF04284E),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 🔷 Header
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
                            color: Color(0xFF77B5F8),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              SizedBox(height: 10),

              // 🔷 Category Scroll Cards
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: SizedBox(
                  height: 110,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      CategoryCard(
                        imagePath: 'assets/gym.png',
                        imageWidth: 60,
                        imageHeight: 60,
                        category: 'Arms',
                        onAddWorkout: _addWorkout,
                        selectedDate: selectedDate ?? DateTime.now(),
                        onDateChanged: _selectDate,
                        getWorkoutsForCategory: _getWorkoutsForCategory,
                      ),
                      CategoryCard(
                        imagePath: 'assets/abdominal.png',
                        imageWidth: 50,
                        imageHeight: 50,
                        category: 'Abs',
                        onAddWorkout: _addWorkout,
                        selectedDate: selectedDate ?? DateTime.now(),
                        onDateChanged: _selectDate,
                        getWorkoutsForCategory: _getWorkoutsForCategory,
                      ),
                      CategoryCard(
                        imagePath: 'assets/leg.png',
                        imageWidth: 50,
                        imageHeight: 50,
                        category: 'Legs',
                        onAddWorkout: _addWorkout,
                        selectedDate: selectedDate ?? DateTime.now(),
                        onDateChanged: _selectDate,
                        getWorkoutsForCategory: _getWorkoutsForCategory,
                      ),
                      CategoryCard(
                        imagePath: 'assets/man.png',
                        imageWidth: 60,
                        imageHeight: 60,
                        category: 'Full Workout',
                        onAddWorkout: _addWorkout,
                        selectedDate: selectedDate ?? DateTime.now(),
                        onDateChanged: _selectDate,
                        getWorkoutsForCategory: _getWorkoutsForCategory,
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 1),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Filter by Date:',
                      style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(width: 12),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color(0xFF021427),
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () async {
                        final picked = await showDatePicker(
                          context: context,
                          initialDate: selectedDate ?? DateTime.now(),
                          firstDate: DateTime(2023, 1),
                          lastDate: DateTime(2030),
                          builder: (context, child) {
                            return Theme(
                              data: ThemeData.dark(),
                              child: child!,
                            );
                          },
                        );
                        if (picked != null) {
                          setState(() {
                            selectedDate = picked;
                          });
                        }
                      },
                      child: Text(DateFormat.yMMMd().format(selectedDate ?? DateTime.now())),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 12),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: filteredWorkouts.isEmpty
                    ? Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20),
                  child: Text(
                    'No workouts added for this month. Tap "Add Workout" to begin.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
                    : Column(
                  children: filteredWorkouts.map((workout) {
                    return Stack(
                      children: [
                        _WorkoutCard(
                          icon: Icons.fitness_center,
                          label: workout['cardLabel'] ?? '',
                          time: '${workout['timeOfDay'] ?? 'No time set'}',
                          reps: '',
                          sets: '',
                          cal: workout['workouts'][0]['timer'] ?? 0,
                          progressColor: Purple,
                          iconColor: Color(0xFF3D96F5),
                          backgroundColor: Color(0xFF1C3552),
                          onTap: () async {
                            List<Map<String, dynamic>> selectedWorkoutList = workout['workouts'];

                            final remainingWorkouts = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WorkoutDetailsPage(workouts: selectedWorkoutList),
                              ),
                            );

                            setState(() {
                              if (remainingWorkouts == null || remainingWorkouts.isEmpty) {
                                workouts.remove(workout);
                              } else {
                                workout['workouts'] = remainingWorkouts;
                                workout['cardLabel'] =
                                    remainingWorkouts.map((w) => w['workout']).join(', ');
                              }
                            });
                          },
                        ),

                        // 🗑️ Delete icon
                        Positioned(
                          top: 4,
                          right: 4,
                          child: GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text("Delete Workout"),
                                  content: Text("Are you sure you want to remove this workout?"),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context),
                                      child: Text("Cancel"),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          workouts.remove(workout);
                                        });
                                        Navigator.pop(context);
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text("Workout deleted 🗑️")),
                                        );
                                      },
                                      child: Text("Delete", style: TextStyle(color: Colors.red)),
                                    ),
                                  ],
                                ),
                              );
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.black54,
                              ),
                              padding: EdgeInsets.all(4),
                              child: Icon(Icons.delete_outline, size: 20, color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    );
                  }).toList(),
                ),
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}



class CategoryCard extends StatelessWidget {
  final String imagePath;
  final double imageWidth;
  final double imageHeight;
  final String category;
  final Function(List<Map<String, dynamic>>, DateTime) onAddWorkout;
  final DateTime selectedDate;
  final Function(BuildContext) onDateChanged;
  final Function(String) getWorkoutsForCategory;

  const CategoryCard({
    required this.imagePath,
    required this.imageWidth,
    required this.imageHeight,
    required this.category,
    required this.onAddWorkout,
    required this.selectedDate,
    required this.onDateChanged,
    required this.getWorkoutsForCategory,
  });



  void _showWorkoutModal(BuildContext context) {
    List<Map<String, dynamic>> filteredWorkouts = getWorkoutsForCategory(category);
    Set<String> selectedWorkouts = Set<String>();
    DateTime? selectedDate;
    TimeOfDay? selectedTime;

    Map<String, TextEditingController> workoutTimers = {};

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xFF021427),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('$category Workouts',
                      style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 12),

                  // Date selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Pick a Date', style: TextStyle(color: Colors.white)),
                      IconButton(
                        icon: Icon(Icons.calendar_today, color: Colors.white),
                        onPressed: () async {
                          DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null) {
                            setState(() {
                              selectedDate = pickedDate;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Display selected date
                  if (selectedDate != null)
                    Text(
                      'Selected Date: ${selectedDate!.toLocal().toString().split(' ')[0]}',
                      style: TextStyle(color: Colors.white),
                    ),
                  const SizedBox(height: 12),

                  // Time selection
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        selectedTime != null
                            ? 'Time: ${selectedTime!.format(context)}'
                            : 'Pick a Time',
                        style: TextStyle(color: Colors.white),
                      ),
                      IconButton(
                        icon: Icon(Icons.access_time, color: Colors.white),
                        onPressed: () async {
                          TimeOfDay? pickedTime = await showTimePicker(
                            context: context,
                            initialTime: TimeOfDay.now(),
                          );
                          if (pickedTime != null) {
                            setState(() {
                              selectedTime = pickedTime;
                            });
                          }
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Scrollable list of workouts
                  Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        children: filteredWorkouts.map((workout) {
                          final name = workout['workout'];
                          workoutTimers.putIfAbsent(name, () => TextEditingController());

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CheckboxListTile(
                                title: Text(name, style: TextStyle(color: Colors.white)),
                                value: selectedWorkouts.contains(name),
                                onChanged: selectedDate == null
                                    ? null
                                    : (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      selectedWorkouts.add(name);
                                    } else {
                                      selectedWorkouts.remove(name);
                                    }
                                  });
                                },
                              ),
                            ],
                          );
                        }).toList(),
                      ),
                    ),
                  ),

                  // Add workout button
                  ElevatedButton(
                    onPressed: selectedDate == null || selectedWorkouts.isEmpty || selectedTime == null
                        ? null
                        : () {
                      // Create a list with selected workouts, including sets, reps, and time
                      List<Map<String, dynamic>> selectedWorkoutList = selectedWorkouts.map((name) {
                        // Find the workout from the filtered list and get sets, reps, or duration
                        var selectedWorkout = filteredWorkouts.firstWhere((w) => w['workout'] == name);
                        if (selectedWorkout['duration'] != null) {
                          // Static workout, only include name and duration
                          return {
                            'workout': selectedWorkout['workout'],
                            'duration': selectedWorkout['duration'], // Only duration for static
                            'timeOfDay': selectedTime!.format(context),
                          };
                        } else {
                          // Dynamic workout, include sets and reps
                          return {
                            'workout': selectedWorkout['workout'],
                            'sets': selectedWorkout['sets'],  // Include sets
                            'reps': selectedWorkout['reps'],  // Include reps
                            'timer': int.tryParse(workoutTimers[name]?.text ?? '0') ?? 0,
                            'timeOfDay': selectedTime!.format(context),
                          };
                        }
                      }).toList();

                      // Debugging: Print selectedWorkoutList to verify sets, reps, or duration
                      print("Selected workout list: $selectedWorkoutList");

                      // Pass the selectedWorkoutList to the parent widget (onAddWorkout)
                      Navigator.of(context).pop(selectedWorkoutList);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: (selectedDate != null && selectedWorkouts.isNotEmpty && selectedTime != null)
                          ? Colors.green
                          : Colors.grey,
                    ),
                    child: const Text('Add Workouts'),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((selectedWorkoutList) {
      if (selectedWorkoutList != null &&
          selectedWorkoutList.isNotEmpty &&
          selectedDate != null &&
          selectedTime != null) {
        onAddWorkout(selectedWorkoutList, selectedDate!);
      }
    });
  }




  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _showWorkoutModal(context),
      child: SizedBox(
        width: 120,
        height: 120,
        child: Container(
          padding: EdgeInsets.all(12),
          margin: EdgeInsets.only(right: 16, bottom: 25),
          decoration: BoxDecoration(
            color: Color(0xFF0C77E9),
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imagePath,
                width: imageWidth,
                height: imageHeight,
                fit: BoxFit.contain,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void setState(Null Function() param0) {}
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
                  Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18, color: Colors.white)),
                  SizedBox(height: 4),
                  Text(time, style: TextStyle(color: Colors.grey[400], fontSize: 14)),
                  if (sets.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(sets, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ],
                  if (reps.isNotEmpty) ...[
                    SizedBox(height: 4),
                    Text(reps, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  ],
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

