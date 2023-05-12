import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_notes/main.dart';

class setting extends StatefulWidget {
  const setting({Key? key}) : super(key: key);

  @override
  State<setting> createState() => _settingState();
}

class _settingState extends State<setting> {

  bool value = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF212227),
      appBar: AppBar(
        backgroundColor: const Color(0xFF212227),
        elevation: 0.0,
        title: Row(
          children: [
            IconButton(onPressed: () {
              Get.off(() => notes());
            }, icon: Icon(Icons.arrow_back_sharp)),
            const SizedBox(width: 15,),
            Text('Settings'),
          ],
        ),
      ),
      body: Container(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Row(
            children: [
              Text(
                '   sync notes',
                style: TextStyle(color: Colors.white, fontSize: 20),
              ),
              const Spacer(),
              Switch.adaptive(splashRadius: 30,value: value, onChanged: (value) {
                setState(() {
                  this.value=value;
                });
              },)
            ],
          ),
        ),
      ),
    );
  }
}
