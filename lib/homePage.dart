import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    final Purple = Color(0xFFCFBAE1);
    final tiffanyblue = Color(0xFF9AD2D6);
    final pastelPink = Color(0xFFfad2e1);
    final pastelBlue = Color(0xFFc1e0fc);


    return Scaffold(
      backgroundColor: Color(0xFFF8F8FB),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [Purple, tiffanyblue]),
                      borderRadius: BorderRadius.circular(24)
                  ),
                  padding: EdgeInsets.all(24),
                  child: Row(
                    children: [
                      Stack(
                        alignment: Alignment.center,
                        children: [
                          SizedBox(
                            height: 56,
                            width: 56,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.white,
                              value: 0.3,
                              strokeWidth: 8,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          ),
                          Icon(Icons.local_fire_department, color: Colors.white, size: 33),
                        ],
                      ),
                      SizedBox(width: 30),
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Flexible(
                              fit: FlexFit.loose,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Streak:',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  Text(
                                    '4 Days',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20),
                            Container(
                              width: 150,
                              padding: EdgeInsets.fromLTRB(0, 0, 40, 0),
                              child: Text(
                                'Keep going you are crushing it',
                                style: TextStyle(color: Colors.white),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20,),
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

              // Workout List
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    _WorkoutCard(
                      icon: Icons.fitness_center,
                      label: "Full Body",
                      time: "30 mins",
                      cal: 200,
                      progressColor: Purple,
                    ),
                    SizedBox(height: 10),
                    _WorkoutCard(
                      icon: Icons.pets,
                      label: "Arms",
                      time: "20 mins",
                      cal: 200,
                      progressColor: pastelPink,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: _BottomNavBar(),
    );
  }
}


class _WorkoutCard extends StatelessWidget {
  final IconData icon;
  final String label, time;
  final int cal;
  final Color progressColor;

  const _WorkoutCard({
    required this.icon,
    required this.label,
    required this.time,
    required this.cal,
    required this.progressColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [BoxShadow(blurRadius: 6, color: Colors.black12)],
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: progressColor.withOpacity(0.25),
            child: Icon(icon, color: progressColor),
          ),
          SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                SizedBox(height: 4),
                Text('$time  |  $cal Cal', style: TextStyle(color: Colors.grey[600], fontSize: 12)),
                SizedBox(height: 6),
                LinearProgressIndicator(
                  value: cal / 300, // Just a sample
                  backgroundColor: progressColor.withOpacity(0.15),
                  color: progressColor,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BottomNavBar extends StatelessWidget {
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
      ),
    );
  }
}
