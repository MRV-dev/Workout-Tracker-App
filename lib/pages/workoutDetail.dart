import 'package:flutter/material.dart';
import 'dart:async'; // Import for Timer

class WorkoutDetailsPage extends StatefulWidget {
  final List<Map<String, dynamic>> workouts;

  const WorkoutDetailsPage({Key? key, required this.workouts}) : super(key: key);

  @override
  _WorkoutDetailsPageState createState() => _WorkoutDetailsPageState();
}

class _WorkoutDetailsPageState extends State<WorkoutDetailsPage> {
  late List<Map<String, dynamic>> _workouts;

  @override
  void initState() {
    super.initState();
    _workouts = widget.workouts; // Initialize local copy of workouts
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF074588),
      appBar: AppBar(
        title: Text('Workout Details'),
        backgroundColor: Color(0xFF04284E),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // List of workouts
            Expanded(
              child: ListView.builder(
                itemCount: _workouts.length, // Use the local list here
                itemBuilder: (context, index) {
                  final workout = _workouts[index];

                  return Card(
                    margin: EdgeInsets.only(bottom: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 4,
                    color: Colors.blueAccent,
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              CircleAvatar(
                                radius: 30,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.fitness_center,
                                  color: Colors.white,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 8),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    workout['workout'],
                                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(height: 8),
                                  if (workout['duration'] == null) ...[
                                    Text('Sets: ${workout['sets']}', style: TextStyle(fontWeight: FontWeight.w500)),
                                    Text('Reps: ${workout['reps']}', style: TextStyle(fontWeight: FontWeight.w500)),
                                  ] else ...[
                                    Text('Duration: ${workout['duration']} seconds', style: TextStyle(fontWeight: FontWeight.w500)),
                                  ],
                                ],
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {
                              _showHeadstartTimerModal(context, () {
                                if (workout['duration'] != null) {
                                  _startStaticWorkoutTimerModal(context, workout, index);
                                } else {
                                  _showWorkoutStartModal(context, workout, index);
                                }
                              });
                            },
                            child: Text('Start'),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showHeadstartTimerModal(BuildContext context, VoidCallback onTimerFinish) {
    int countdown = 5;
    Timer? headstartTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            headstartTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
              if (countdown > 1) {
                setState(() {
                  countdown--;
                });
              } else {
                timer.cancel();
                Navigator.of(dialogContext).pop();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  onTimerFinish();
                });
              }
            });

            return AlertDialog(
              backgroundColor: Color(0xFF021427),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              contentPadding: EdgeInsets.all(26),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Get Ready', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text(
                    '$countdown',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      headstartTimer?.cancel();
    });
  }

  void _startStaticWorkoutTimerModal(BuildContext context, Map<String, dynamic> workout, int index) {
    int totalTime = workout['duration'] ?? 30;
    int remainingTime = totalTime;
    Timer? staticTimer;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            staticTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
              if (remainingTime > 1) {
                setState(() {
                  remainingTime--;
                });
              } else {
                timer.cancel();
                Navigator.of(dialogContext).pop();

                WidgetsBinding.instance.addPostFrameCallback((_) {
                  bool isLastWorkout = _workouts.length == 0;
                  markWorkoutDone(index);
                  if (isLastWorkout) {
                    Navigator.of(context).pop();
                  } else {
                    _startRestPeriod(context, navigateOnFinish: false);
                  }

                });
              }
            });

            return AlertDialog(
              backgroundColor: Color(0xFF021427),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              contentPadding: EdgeInsets.all(26),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Workout Timer', style: TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 20),
                  Text('$remainingTime', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 48, color: Colors.white)),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      staticTimer?.cancel();
    });
  }

  void _startRestPeriod(BuildContext context, {bool navigateOnFinish = false}) {
    int restDuration = 10;
    int remainingTime = restDuration;
    Timer? localTimer;
    bool didPop = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext dialogContext) {
        return StatefulBuilder(
          builder: (context, setState) {
            localTimer ??= Timer.periodic(Duration(seconds: 1), (timer) {
              if (remainingTime > 1) {
                setState(() {
                  remainingTime--;
                });
              } else {
                timer.cancel();
                Navigator.of(dialogContext).pop(); // close rest dialog

                if (navigateOnFinish && !didPop) {
                  didPop = true;
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    Navigator.of(context).pop([]); // return to homepage with empty list
                  });
                }
              }
            });

            double progress = (restDuration - remainingTime) / restDuration;

            return AlertDialog(
              backgroundColor: Color(0xFF021427),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              contentPadding: EdgeInsets.all(26),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text('Rest', style: TextStyle(color: Colors.white, fontSize: 28, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 17),
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(begin: 0, end: progress),
                    duration: Duration(milliseconds: 500),
                    builder: (context, animatedProgress, child) {
                      return Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            width: 120,
                            height: 120,
                            child: CircularProgressIndicator(
                              value: animatedProgress,
                              strokeWidth: 8,
                              backgroundColor: Colors.white24,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.blueAccent),
                            ),
                          ),
                          Text(
                            '$remainingTime',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 42, color: Colors.white),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
        );
      },
    ).then((_) {
      localTimer?.cancel();
    });
  }


  void _showWorkoutStartModal(BuildContext context, Map<String, dynamic> workout, int index) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              backgroundColor: Color(0xFF021427),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              contentPadding: EdgeInsets.all(20),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    workout['workout'],
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  const SizedBox(height: 12),
                  if (workout['duration'] != null) ...[
                    Text(
                      'Duration: ${workout['duration']} seconds',
                      style: TextStyle(color: Colors.white),
                    ),
                  ] else ...[
                    Text('Sets: ${workout['sets']}', style: TextStyle(color: Colors.white)),
                    Text('Reps: ${workout['reps']}', style: TextStyle(color: Colors.white)),
                  ],
                  const SizedBox(height: 12),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();

                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        markWorkoutDone(index);
                        bool isLastWorkout = _workouts.length == 0;
                        if (isLastWorkout) {
                          Navigator.of(context).pop();
                        } else {
                          _startRestPeriod(context, navigateOnFinish: false);
                        }

                      });
                    },
                    child: Text('Done'),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void markWorkoutDone(int index) {
    setState(() {
      _workouts.removeAt(index);
    });
  }
}