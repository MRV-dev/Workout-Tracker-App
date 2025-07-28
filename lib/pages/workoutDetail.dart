import 'package:flutter/material.dart';
import 'dart:async';
import 'selectworkout.dart'; // Access staticWorkouts

class WorkoutDetailsPage extends StatefulWidget {
  final List<Map<String, dynamic>> workouts;

  const WorkoutDetailsPage({Key? key, required this.workouts}) : super(key: key);

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  late List<Map<String, dynamic>> _workouts;
  Set<String> finishedStaticWorkouts = {}; // After timer
  Set<String> completedDynamicWorkouts = {}; // Immediate done

  @override
  void initState() {
    super.initState();
    _workouts = widget.workouts
        .map((w) => {
      ...w,
      'timer': staticWorkouts.containsKey(w['workout']) ? 15 : 0,
      'isStatic': staticWorkouts.containsKey(w['workout']),
    })
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF031E3A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF063B74),
        title: const Text("Workout Details"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: _workouts.isEmpty
            ? const Center(
          child: Text('All workouts done!',
              style: TextStyle(color: Colors.white, fontSize: 18)),
        )
            : ListView.builder(
          itemCount: _workouts.length,
          itemBuilder: (context, index) {
            final workout = _workouts[index];
            final name = workout['workout'];
            final isStatic = workout['isStatic'] == true;
            final hasStarted = finishedStaticWorkouts.contains(name);
            final isCompleted = completedDynamicWorkouts.contains(name);

            String timeText = 'Duration: ${workout['timer']} seconds';
            String repsText = workout['repetitions'] == 0 ? '' : 'Reps: ${workout['repetitions']}';
            String setsText = workout['sets'] == 0 ? '' : 'Sets: ${workout['sets']}';

            return Container(
              margin: const EdgeInsets.only(bottom: 16),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFF021427),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFF0C77E9), width: 2),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 28,
                        backgroundColor: const Color(0xFF0C77E9).withOpacity(0.2),
                        child: const Icon(Icons.fitness_center,
                            color: Color(0xFF3D96F5), size: 32),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: Text(name ?? '',
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2A8BF4),
                            )),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(timeText, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  if (setsText.isNotEmpty) const SizedBox(height: 4),
                  if (setsText.isNotEmpty)
                    Text(setsText, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  if (repsText.isNotEmpty) const SizedBox(height: 4),
                  if (repsText.isNotEmpty)
                    Text(repsText, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      onPressed: () {
                        if (isStatic) {
                          hasStarted
                              ? _removeWorkout(index)
                              : _startTimerDialog(context, name);
                        } else {
                          isCompleted
                              ? null
                              : _startDynamicModal(name, workout['repetitions'], workout['sets']);

                        }
                      },
                      child: Text((isStatic && hasStarted) || isCompleted ? "Done" : "Start"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (isStatic && !hasStarted) || (!isStatic && !isCompleted)
                            ? const Color(0xFF0C77E9)
                            : Colors.green,
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }

  void _removeWorkout(int index) {
    final workoutName = _workouts[index]['workout'];

    setState(() {
      _workouts.removeAt(index);
      finishedStaticWorkouts.add(workoutName);
    });

    if (_workouts.isEmpty) {
      Future.microtask(() {
        Navigator.pop(context, []); // Triggers homepage rebuild and card removal
      });
    }
  }


  void _removeDynamicWorkout(String workoutName) {
    setState(() {
      completedDynamicWorkouts.add(workoutName);
      _workouts.removeWhere((w) => w['workout'] == workoutName);
    });

    if (_workouts.isEmpty) {
      Future.microtask(() {
        Navigator.pop(context, []); // Triggers homepage rebuild and card removal
      });
    }

  }


  void _startTimerDialog(BuildContext context, String workoutName) async {
    int secondsRemaining = 15;

    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Timer? timer;
        return StatefulBuilder(
          builder: (context, setModalState) {
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (secondsRemaining <= 1) {
                t.cancel();
                Navigator.of(context).pop('done'); // ✅ Return 'done'
              } else {
                setModalState(() => secondsRemaining--);
              }
            });

            return AlertDialog(
              backgroundColor: const Color(0xFF021427),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Workout Timer',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 12),
                  Text('$secondsRemaining',
                      style: const TextStyle(fontSize: 48, color: Colors.green)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      timer?.cancel();
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    child: const Text('Cancel'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    // ✅ Update parent state AFTER dialog closes
    if (result == 'done') {
      setState(() {
        finishedStaticWorkouts.add(workoutName);
      });
    }
  }


  void _showRestTimer() async {
    int restSeconds = 10;

    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        Timer? timer;
        return StatefulBuilder(
          builder: (context, setModalState) {
            timer ??= Timer.periodic(const Duration(seconds: 1), (t) {
              if (restSeconds <= 1) {
                t.cancel();
                Navigator.of(context).pop();
              } else {
                setModalState(() => restSeconds--);
              }
            });

            return AlertDialog(
              backgroundColor: const Color(0xFF021427),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text('Rest Time',
                      style: TextStyle(color: Colors.white, fontSize: 20)),
                  const SizedBox(height: 12),
                  Text('$restSeconds',
                      style: const TextStyle(fontSize: 48, color: Colors.orangeAccent)),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      timer?.cancel();
                      Navigator.of(context).pop();
                    },
                    child: const Text('Skip'),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _startDynamicModal(String workoutName, int reps, int sets) async {
    await showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF021427),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          contentPadding: const EdgeInsets.all(20),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(workoutName,
                  style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white)),
              const SizedBox(height: 12),
              Text('Sets: $sets',
                  style:
                  const TextStyle(fontSize: 18, color: Colors.orangeAccent)),
              const SizedBox(height: 8),
              Text('Repetitions: $reps',
                  style:
                  const TextStyle(fontSize: 18, color: Colors.orangeAccent)),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  _removeDynamicWorkout(workoutName);
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                child: const Text('Finish'),
              ),
            ],
          ),
        );
      },
    );
  }




}
