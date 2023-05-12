// import 'package:blurrycontainer/blurrycontainer.dart';
// import 'package:flutter/material.dart';
// import 'package:google_notes/main.dart';
// import 'package:lottie/lottie.dart';
//
// class mysplashscreen extends StatefulWidget {
//   const mysplashscreen({Key? key}) : super(key: key);
//
//   @override
//   State<mysplashscreen> createState() => _mysplashscreenState();
// }
//
// class _mysplashscreenState extends State<mysplashscreen> {
//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     Future.delayed(Duration(seconds: 3)).then((value) {
//       Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) {
//         return notes();
//       },));
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         body: Stack(
//       children: [
//         Container(
//           height: double.infinity,
//           width: double.infinity,
//           decoration: BoxDecoration(
//               image: DecorationImage(
//                   image: AssetImage("animation/11.jpg"), fit: BoxFit.fill)),
//         ),
//         BlurryContainer(
//           child: Center(child:Lottie.asset("animation/97930-loading.json")),
//           blur: 8,
//           height: double.infinity,
//           width: double.infinity,
//           elevation: 0,
//           color: Colors.transparent,
//           padding: const EdgeInsets.all(8),
//           borderRadius: const BorderRadius.all(Radius.circular(20)),
//         ),
//       ],
//     )
//         );
//   }
// }
