import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_puzzle/GRID_PAGE.dart';
import 'package:word_puzzle/data_list.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Start_Page(),
  ));
}

class Start_Page extends StatefulWidget {
  const Start_Page({super.key});

  static SharedPreferences? prefs;
  static var islvl_completed=List.filled(Data.puzzle_image.length, false);

  @override
  State<Start_Page> createState() => _Start_PageState();
}

class _Start_PageState extends State<Start_Page> {
  get_Data()
  async {
    Start_Page.prefs=await SharedPreferences.getInstance();
    for(int i=0;i<Start_Page.islvl_completed.length;i++)
      {
        Start_Page.islvl_completed[i]=Start_Page.prefs!.getBool("lvl${i}clear")??false;
      }
    setState(() {

    });
  }
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    get_Data();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Stack(
        children: [
          SizedBox(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(child: Image.asset("assets/bg/top.png")),
                  ],
                ),
                Expanded(
                    child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Image.asset("assets/bg/bottom.png",
                        fit: BoxFit.fill,
                        height: MediaQuery.of(context).size.height * 0.15,
                        width: MediaQuery.of(context).size.width)
                  ],
                ))
              ],
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Text(
                      "LOGO GAME",
                      style: TextStyle(fontSize: 35, color: Colors.black),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Text(
                      "Quiz your brands knowledge",
                      style: TextStyle(color: Colors.black, fontSize: 20),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 100,
              ),
              NeumorphicButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return Grid_logo();
                      },
                    ), (route) => true);
                  },
                  style: NeumorphicStyle(
                    color: Colors.indigo.shade900,
                    shadowDarkColor: Colors.black,
                    depth: 10,
                    intensity: 5,
                    shadowDarkColorEmboss: Colors.black,
                    boxShape: NeumorphicBoxShape.circle(),
                  ),
                  child: Container(
                    height: 200,
                    width: 200,
                    alignment: Alignment.center,
                    child: Text(
                      "Play",
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  ))
            ],
          )
        ],
      )),
    );
  }
}
