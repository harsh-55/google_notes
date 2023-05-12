import 'package:flutter/material.dart';
import 'package:google_notes/main.dart';
import 'package:google_notes/dataBaseclass.dart';
import 'package:google_notes/editnote.dart';
import 'package:share_plus/share_plus.dart';
import 'package:sqflite_common/sqlite_api.dart';
import 'package:intl/intl.dart';

class noteview extends StatefulWidget {
  int ind;

  noteview(this.ind);

  @override
  State<noteview> createState() => _noteviewState();
}

class _noteviewState extends State<noteview> {

  Color currentnotecolor = Colors.transparent;


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    viewnotesdata();
  }

  Database? database;

  void viewnotesdata() {
    Notesdatabase().GetDatabase().then((value) {
      setState(() {
        database = value;
      });

      Notesdatabase().notedataview(database!).then((value1) {
        setState(() {
          print("=============$value1");
          note = value1[widget.ind];
        });
      });
    });
  }

  Map note = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212227),
      appBar: AppBar(
        backgroundColor: Color(0xFF212227),
        elevation: 0.0,
        leading: IconButton(
            onPressed: () {
              Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) {
                  return notes();
                },
              ));
            },
            icon: Icon(Icons.arrow_back_sharp)),
        actions: [
          IconButton(
              splashRadius: 17,
              onPressed: () {
                String time =
                    DateFormat('d/M/yyyy , kk:mm a').format(DateTime.now());
                String first = note['HEADING'];
                String second = note['NOTES'];

                Share.share("$time\n$first\n$second");
              },
              icon: Icon(Icons.share_outlined)),
          IconButton(
              splashRadius: 17,
              onPressed: () {
                int ID = note['id'];

                Notesdatabase().deletenote(ID, database!).then((value) {
                  Navigator.pushReplacement(context, MaterialPageRoute(
                    builder: (context) {
                      return notes();
                    },
                  ));
                });
              },
              icon: Icon(Icons.delete_outline)),
          IconButton(
              splashRadius: 17,
              onPressed: () {
                Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) {
                    return editnote(note, database!, widget.ind);
                  },
                ));
              },
              icon: Icon(Icons.edit_outlined))
        ],
      ),
      body: Container(
        margin: EdgeInsets.all(16),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 20,
                width: double.infinity,
                child: Row(
                  children: [
                    Text(
                      DateFormat('d/M/yyyy , kk:mm a').format(DateTime.now()),
                      style: TextStyle(color: Colors.white.withOpacity(0.5)),
                    ),
                    SizedBox(width: 150,),
                    Container(
                      height: 15,
                      width: 15,

                      decoration: BoxDecoration(
                          color: Color(note["COLOR"]),
                          shape: BoxShape.circle
                      ),
                    ),
                  ],
                ),
              ),
              Text(
                "${note['HEADING']}",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 27,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                '${note['NOTES']}',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 19,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  List notecolor = [
    Colors.indigo,
    Colors.blue,
    Colors.red,
    Colors.amber,
    Colors.blueAccent,
    Colors.blueGrey,
    Colors.cyanAccent,
    Colors.yellowAccent,
    Colors.tealAccent,
    Colors.brown,
    Colors.purpleAccent,
    Colors.redAccent,
    Colors.indigoAccent,
    Colors.orange,
    Color(0xFF85354F),
    Color(0xFFA2024A),
    Color(0xFF522964),
    Color(0xFFA1CFDC),
    Color(0xFFDC0860),
    Color(0xFF016C9F),
    Color(0xFF714C0C),
    Color(0xFF25AE0B),
    Color(0xFF782D23),
    Color(0xFF324655),
    Color(0xFF5F7896),
    Color(0xFFC86469),
    Color(0xFF64505A),
    Color(0xFF00324B),
    Color(0xFF82CDD7),
    Color(0xFFF57DDC),
    Color(0xFFA08C78),
    Color(0xFFEBDCC3),
    Color(0xFF28373C),
    Color(0xFFFFB946),
  ];
}
