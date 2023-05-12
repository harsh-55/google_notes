
import 'package:flutter/material.dart';
import 'package:google_notes/2-noteview.dart';
import 'package:google_notes/dataBaseclass.dart';
import 'package:intl/intl.dart';
import 'package:sqflite_common/sqlite_api.dart';

class editnote extends StatefulWidget {

  Map note;
  Database database1;
  int ind;

  editnote(this.note,this.database1,this.ind);



  @override
  State<editnote> createState() => _editnoteState();
}

class _editnoteState extends State<editnote> {

  TextEditingController title = TextEditingController();
  TextEditingController description = TextEditingController();

  Color currentnotecolor = Colors.transparent;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      title.text = widget.note['HEADING'];
      description.text = widget.note['NOTES'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF212227),
      appBar: AppBar(
        backgroundColor: Color(0xFF212227),
        leading: IconButton(onPressed: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
            return noteview(widget.ind);
          },));
        }, icon: Icon(Icons.arrow_back_sharp)),
        actions: [
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
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
                splashRadius: 18,
                onPressed: () {

                  String heding = title.text;
                  String note = description.text;

                  int color = currentnotecolor.value;



                  Notesdatabase().updatenotes(heding,note,widget.note['id'],widget.database1,color).then((value) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
                      return noteview(widget.ind);
                    },));
                  });



            }, icon: Icon(Icons.save_outlined)),
          )
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
                Container(
                  height: 20,
                  width: double.infinity,
                  child: Row(
                    children: [
                      Text(
                        DateFormat('d/M/yyyy , kk:mm a').format(DateTime.now()),
                        style: TextStyle(color: Colors.white.withOpacity(0.5)),
                      ),
                      SizedBox(width: 130,),
                      Container(
                        height: 15,
                        width: 15,

                        decoration: BoxDecoration(
                            color: Color(currentnotecolor.value),
                            shape: BoxShape.circle
                        ),
                      ),
                    ],
                  ),
                ),
                TextField(
                  controller: title,
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
                      color: Colors.grey.withOpacity(0.8)
                    )
                  ),
                ),
                Container(
                  height: 300,
                  child: TextField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    minLines: 50,
                    maxLines: null,
                    cursorColor: Colors.white,
                    style: TextStyle(
                        fontSize: 18,color: Colors.white
                    ),
                    decoration: InputDecoration(
            border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        hintText: "Note",
                        hintStyle: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.withOpacity(0.8)
                        )
                    ),
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
