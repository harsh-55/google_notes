
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_notes/settingpage.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import '3-createnote.dart';
import 'dataBaseclass.dart';
import 'main.dart';
import '2-noteview.dart';

class listview extends StatefulWidget {
  const listview({Key? key}) : super(key: key);

  @override
  State<listview> createState() => _listviewState();
}

class _listviewState extends State<listview> {
  GlobalKey<ScaffoldState> _drawerkey = GlobalKey();

  Database? db;

  List<Map> note = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewnotesdata();
  }

  void viewnotesdata() {
    Notesdatabase().GetDatabase().then((value) {
      setState(() {
        db = value;
      });

      Notesdatabase().notedataview(db!).then((value1) {
        setState(() {
          note = value1;
        });
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double theight = MediaQuery.of(context).size.height;
    double twidth = MediaQuery.of(context).size.width;

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) {
              return createnote();
            },
          ));
        },
        child: Icon(
          Icons.add,
          size: 37,
        ),
        backgroundColor: Colors.lightBlueAccent,
      ),
      key: _drawerkey,
      drawer: Drawer(
        width: 265,
        backgroundColor: Color(0xFF212227),
        child: Column(
          children: [
            Container(
                height: 100,
                width: 265,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: Text(
                        "Notes",
                        style: GoogleFonts.alata(
                            color: Color(0xFFFFFFFF), fontSize: 35),
                      ),
                    ),
                  ],
                )),
            Divider(
              height: 35,
              color: Colors.white.withOpacity(0.3),
            ),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return listview();
                      },
                    ));
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.cyan.withOpacity(0.3)),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))))),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.lightbulb,
                            color: Colors.white.withOpacity(0.7)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Notes",
                          style: GoogleFonts.aclonica(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 18),
                        )
                      ],
                    ),
                  )),
            ),
            SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(
                      builder: (context) {
                        return setting();
                      },
                    ));
                  },
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                  topRight: Radius.circular(50),
                                  bottomRight: Radius.circular(50))))),
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        Icon(Icons.settings_outlined,
                            color: Colors.white.withOpacity(0.7)),
                        SizedBox(
                          width: 20,
                        ),
                        Text(
                          "Settings",
                          style: GoogleFonts.aclonica(
                              color: Colors.white.withOpacity(0.7),
                              fontSize: 18),
                        )
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
      backgroundColor: Color(0xFF212227),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                  height: theight * 0.078,
                  width: twidth,
                  decoration: BoxDecoration(
                      color: Color(0xFF2D2E33),
                      borderRadius: BorderRadius.circular(8),
                      boxShadow: [
                        BoxShadow(
                            color: Color(0xFF000000).withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 3)
                      ]),
                  child: Row(
                    children: [
                      Row(
                        children: [
                          TextButton(
                              onPressed: () {
                                _drawerkey.currentState!.openDrawer();
                              },
                              child: Icon(
                                Icons.menu,
                                color: Color(0xFFFFFFFF),
                              )),
                          SizedBox(
                            width: 10,
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: theight * 0.078,
                              width: 200,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Search Your Notes",
                                    style: TextStyle(
                                        color:
                                            Color(0xFFFFFFFF).withOpacity(0.5),
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: theight * 0.055,
                        width: 40,
                        child: TextButton(
                            onPressed: () {
                              Navigator.pushReplacement(context,
                                  MaterialPageRoute(
                                builder: (context) {
                                  return notes();
                                },
                              ));
                            },
                            style: ButtonStyle(
                                overlayColor:
                                    MaterialStateColor.resolveWith((states) {
                                  return Colors.white.withOpacity(0.2);
                                }),
                                shape: MaterialStateProperty.all<
                                        RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(50)))),
                            child: Icon(
                              Icons.grid_view,
                              color: Color(0xFFFFFFFF),
                              size: 25,
                            )),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                  width: double.infinity,
                  child: Text('  All notes',
                        style: GoogleFonts.alata(
                          color: Color(0xFFFFFFFF),
                          fontSize: 30,
                        )),
                ),
                SizedBox(
                  height: 6,
                ),
                Container(
                    height: 592,
                    width: 338,
                    child: ListView.builder(
                      itemCount: note.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.pushReplacement(context,
                                MaterialPageRoute(
                              builder: (context) {
                                return noteview(index);
                              },
                            ));
                          },
                          child: Container(
                            margin: EdgeInsets.fromLTRB(5, 7, 5, 7),
                            decoration: BoxDecoration(
                                color: Colors.transparent,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color: Colors.white.withOpacity(0.6))),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.change_circle_outlined,
                                          size: 12,
                                          color: Colors.white.withOpacity(0.5)),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        DateFormat('d/M/yyyy')
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                            color:
                                                Colors.white.withOpacity(0.5),
                                            fontSize: 9),
                                      ),
                                    ],
                                  ),
                                  Text("${note[index]['HEADING']}",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                  SizedBox(height: 5),
                                  Text(
                                    "${note[index]['NOTES']}",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 14),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
