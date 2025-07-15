import 'package:flutter/material.dart';

class Homepage extends StatelessWidget {
  const Homepage({super.key});


  @override
  Widget build(BuildContext context) {
    final Purple = Color(0xFFCFBAE1);
    final tiffanyblue = Color(0xFF9AD2D6);
    final lightblue = Color(0xFF96C3CE);


    return Scaffold(
      backgroundColor: Color(0xFFF8F8FB),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: [
                  Column(
                    children: [
                      Text('Hi, Anthony', style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      )),
                      SizedBox(height: 4),
                      Padding(
                        padding: EdgeInsets.only(right: 55),
                        child: Text('Welcome!', style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold
                        )),
                      )
                    ],
                  )
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 10),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [Purple, tiffanyblue,]),
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

                    // Wrap the entire nested section in a Flexible or Expanded if needed
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
            )


          ],
        ),
      ),
    );
  }
}
