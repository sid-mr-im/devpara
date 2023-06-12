import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:io';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final TextEditingController _idController = TextEditingController();

  final Stream<DocumentSnapshot> _postsStream = FirebaseFirestore.instance
      .collection('users')
      .doc(
          'testuser1') // FirebaseAuth.instance.currentUser?.uid.substring(0, 21)
      .collection('projects')
      .doc('testproject1')
      .snapshots();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
      stream: _postsStream,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          print("Error!");
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          print("Waiting...");
        }
        var progress = snapshot.data?.get('progress');
        var status = snapshot.data?.get('status');
        print("Progress: " + progress.toString());
        print("Status: " + status.toString());
        return GestureDetector(
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(10, 10, 10, 10),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Text(
                            'Greetings testuser1',
                          ),
                        ),
                        Container(
                          width: 35,
                          height: 35,
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                          ),
                          child: Image.network(
                            'https://picsum.photos/seed/515/600',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Expanded(
                          child: Container(
                            padding:
                                EdgeInsets.only(left: 10, bottom: 10, top: 10),
                            height: 60,
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Colors.white,
                              border: Border.all(color: Colors.blueAccent),
                            ),
                            child: TextField(
                              textInputAction: TextInputAction.next,
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                hintText: 'Enter a Project ID',
                                prefixIcon: Icon(Icons.account_tree_rounded),
                              ),
                              controller: _idController,
                            ),
                          ),
                        ),
                        FloatingActionButton(
                          onPressed: () {
                            print('Initialized!');
                          },
                          child: Icon(Icons.add),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 4,
                          child: Padding(
                            padding: const EdgeInsetsDirectional.fromSTEB(
                                15, 15, 15, 10),
                            child: Container(
                              decoration: BoxDecoration(
                                color: const Color(0xFFEEEEEE),
                                boxShadow: const [
                                  BoxShadow(
                                    blurRadius: 5,
                                    color: Color(0xEEEEEEEE),
                                    offset: Offset(0, 2),
                                    spreadRadius: 3,
                                  )
                                ],
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsetsDirectional.fromSTEB(
                                    15, 15, 15, 15),
                                child: Column(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              1, 1, 1, 1),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Project ID: ", // 'Device ID:  ',
                                            style: GoogleFonts.poppins(
                                              fontWeight: FontWeight.w700,
                                              fontSize: 12,
                                            ),
                                          ),
                                          Text(
                                            "testproject1", // "d.devID",
                                            style: GoogleFonts.poppins(
                                              color: Colors.blueAccent,
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding:
                                          const EdgeInsetsDirectional.fromSTEB(
                                              5, 5, 5, 5),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.max,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                progress.toString(), // "85%",
                                                // "d.currentInhalationValue",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.green,
                                                  fontSize: 50,
                                                ),
                                              ),
                                              Text(
                                                "Progress", // 'Inhalation',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            mainAxisSize: MainAxisSize.max,
                                            children: [
                                              Text(
                                                status.toString(), // "Running",
                                                // "d.currentExhalationValue",
                                                style: GoogleFonts.poppins(
                                                  color: Colors.green,
                                                  fontSize: 24,
                                                ),
                                              ),
                                              Text(
                                                "Status", // 'Exhalation',
                                                style: GoogleFonts.poppins(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w500,
                                                  fontSize: 12,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // Generated code for this Row Widget...
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () async {
                            var cmd = 'echo 123';
                            var parsedcmd = Uri.encodeComponent(cmd);
                            var getUrl =
                                'http://10.0.2.2:5000/run?uid=testuser1&pid=testproject1&cmd=${parsedcmd}';
                            var response = await http.get(Uri.parse(getUrl));
                          },
                          label: Text('Echo 123'),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {},
                          label: Text('Run'),
                        ),
                      ],
                    ),
                  ),
                  // Generated code for this Row Widget...
                  Padding(
                    padding: EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        FloatingActionButton.extended(
                          onPressed: () {},
                          label: Text('Stop'),
                        ),
                        FloatingActionButton.extended(
                          onPressed: () {},
                          label: Text('History'),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
