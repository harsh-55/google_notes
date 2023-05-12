import 'dart:io';
import 'package:blinking_text/blinking_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_notes/3-createnote.dart';
import 'package:google_notes/dataBaseclass.dart';
import 'package:google_notes/4-listviewnoteview.dart';
import 'package:google_notes/2-noteview.dart';
import 'package:google_notes/settingpage.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_grid_view.dart';
import 'package:staggered_grid_view_flutter/widgets/staggered_tile.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  runApp(GetMaterialApp(
    title: "Notes",
    debugShowCheckedModeBanner: false,
    home: notes(),
  ));
}

class notes extends StatefulWidget {
  @override
  State<notes> createState() => _notesState();
}

class _notesState extends State<notes> {
  GlobalKey<ScaffoldState> _drawerkey = GlobalKey();

  Database? db;

  List<Map> note = [];
  List<Map> searchlist = [];

  bool search = false;

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
          searchlist = value1;
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
          Get.off(() => createnote());
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
            SizedBox(
                height: 100,
                width: 265,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 2),
                      child: BlinkText(
                        " Notes",
                        style: GoogleFonts.alata(
                            color: Colors.redAccent, fontSize: 35),
                        beginColor: Colors.grey,
                        endColor: Colors.orange,
                        times: 10,
                        duration: const Duration(seconds: 1),
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
                    Get.off(() => notes());
                  },
                  style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(
                          Colors.cyan.withOpacity(0.3)),
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        const SizedBox(
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
            const SizedBox(height: 15),
            Container(
              margin: EdgeInsets.only(right: 30),
              child: TextButton(
                  onPressed: () {
                    Get.off(() => setting());
                  },
                  style: ButtonStyle(
                      shape:
                          MaterialStateProperty.all<RoundedRectangleBorder>(
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
                        const SizedBox(
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
          child: SizedBox(
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
                          SizedBox(
                            height: theight * 0.078,
                            width: 50,
                            child: TextButton(
                                onPressed: () {
                                  _drawerkey.currentState!.openDrawer();
                                },
                                child: Icon(
                                  Icons.menu,
                                  color: Color(0xFFFFFFFF),
                                )),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          SizedBox(
                            height: theight * 0.078,
                            width: 220,
                            child: TextField(
                              onChanged: (value) {
                                setState(() {
                                  if (value.isNotEmpty) {
                                    searchlist = [];

                                    for (int i = 0; i < note.length; i++) {
                                      String title = note[i]['HEADING'];
                                      String noteeee = note[i]['NOTES'];
                                      if (title.toLowerCase().contains(
                                              value.toLowerCase()) ||
                                          noteeee
                                              .toString()
                                              .toUpperCase()
                                              .contains(
                                                  value.toUpperCase())) {
                                        searchlist.add(note[i]);
                                      } else {}
                                    }
                                  } else {
                                    searchlist = note;
                                  }
                                  search = true;
                                });
                              },
                              style: TextStyle(
                                  color: Colors.white, fontSize: 19),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                errorBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                hintText: "search Your Note",
                                hintStyle: TextStyle(
                                    color: Color(0xFFFFFFFF).withOpacity(0.5),
                                    fontSize: 16,
                                    height: 1.9),
                              ),
                            ),
                          )
                        ],
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        height: theight * 0.055,
                        width: 40,
                        child: TextButton(
                            onPressed: () {
                              Get.off(() => listview());
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
                              Icons.list_alt,
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
                const SizedBox(
                  height: 6,
                ),
                SizedBox(
                    height: 592,
                    width: 338,
                    child: AnimationLimiter(
                        key: ValueKey("${note.length}"),
                        child: StaggeredGridView.countBuilder(
                      itemCount: search ? searchlist.length : note.length,
                      physics: BouncingScrollPhysics(),
                      crossAxisCount: 4,
                      mainAxisSpacing: 6,
                      crossAxisSpacing: 8,
                      itemBuilder: (context, index) {
                        Map map = search ? searchlist[index] : note[index];
                        return AnimationConfiguration.staggeredGrid(
                          position: index,
                          columnCount: 1,
                          child: InkWell(
                            onTap: () {
                              Get.off(() => noteview(index));
                            },
                            child: FlipAnimation(
                              delay: Duration(milliseconds: 200),
                              duration: Duration(milliseconds: 200),
                              child: Container(
                                margin: EdgeInsets.all(4),
                                decoration: BoxDecoration(
                                    color: Color(map["COLOR"]),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                        color: Colors.white, width: 2)),
                                child: Padding(
                                  padding: const EdgeInsets.all(9.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat('d/M/yyyy')
                                            .format(DateTime.now()),
                                        style: TextStyle(
                                            color: Colors.white.withOpacity(0.5),
                                            fontSize: 11),
                                      ),
                                      Text("${map['HEADING']}",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold)),
                                      const SizedBox(height: 5),
                                      SizedBox(
                                        height: 92,
                                        child: ListView(
                                          physics: BouncingScrollPhysics(),
                                          children: [
                                            Text(
                                              "${map['NOTES']}",
                                              style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 14),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                      staggeredTileBuilder: (index) =>
                          StaggeredTile.count(2, index.isOdd ? 2 : 3),
                    )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
