
import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:get/get.dart';
import 'package:google_notes/dataBaseclass.dart';
import 'package:google_notes/main.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';


class createnote extends StatefulWidget {
  const createnote({Key? key}) : super(key: key);

  @override
  State<createnote> createState() => _createnoteState();
}

class _createnoteState extends State<createnote> {
  TextEditingController heading = TextEditingController();
  TextEditingController notesss = TextEditingController();

  Color currentnotecolor = Colors.transparent;

  Database? db;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getdatabase();
  }

  void getdatabase() {
    Notesdatabase().GetDatabase().then((value) {
      setState(() {
        db = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212227),
      appBar: AppBar(
        backgroundColor: Color(0xFF212227),
        leading: IconButton(
            onPressed: () {
              Get.off(() => notes());
            },
            icon: Icon(Icons.arrow_back_sharp)),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Pick a color!'),
                    content: SingleChildScrollView(
                      child: ColorPicker(
                        pickerColor: currentnotecolor,
                        onColorChanged: (value) {
                          setState(() {
                            currentnotecolor = value;
                          });
                        },
                      ),
                    ),
                    actions: <Widget>[
                      ElevatedButton(
                        child: const Text('Got it'),
                        onPressed: () {
                          setState(
                                  () => currentnotecolor = currentnotecolor);
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  );
                },
              );
            },
            icon: Center(child: Icon(Icons.bolt_rounded)),
            color: Colors.white,
            iconSize: 35,
          ),
          IconButton(
              splashRadius: 18,
              onPressed: () {
                showModalBottomSheet(
                  backgroundColor: Colors.transparent,
                  context: context,
                  builder: (context) {
                    return Container(
                      height: 180,
                      color: Colors.transparent,
                      child: GridView.builder(
                        physics: BouncingScrollPhysics(),
                        itemCount: notecolor.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                setState(() {
                                  currentnotecolor = notecolor[index];
                                });
                              },
                              child: Container(
                                margin: EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                    color: notecolor[index],
                                    border: Border.all(
                                        color: Colors.white.withOpacity(0.6),
                                        width: 2)),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 6)),
                    );
                  },
                );
              },
              icon: Icon(
                Icons.color_lens_outlined,
                size: 27,
              )),
          IconButton(
              splashRadius: 18,
              onPressed: () {
                String heding = heading.text;
                String note = notesss.text;
                int cc = currentnotecolor.value;


                Notesdatabase().insertdatanote(heding, note,cc , db!).then((value) {
                  Get.off(() => notes());
                });
              },
              icon: Icon(
                Icons.save_outlined,
                size: 27,
              )),
          const SizedBox(width: 10)
        ],
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                SizedBox(
                  height: 20,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        DateFormat('d/M/yyyy , kk:mm a').format(DateTime.now()),
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                      const SizedBox(width: 150,),
                      Container(
                        height: 15,
                        width: 15,

                        decoration: BoxDecoration(
                            color: currentnotecolor,
                          shape: BoxShape.circle
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: heading,
                  cursorColor: Colors.white,
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.white,
                  ),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      hintText: "Title",
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.grey.withOpacity(0.8))),
                ),
                SizedBox(
                  height: 300,
                  child: TextField(
                    controller: notesss,
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: null,
                    cursorColor: Colors.white,
                    style: TextStyle(fontSize: 18, color: Colors.white),
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: " Note",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8))),
                  ),
                ),
              ],
            ),
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
