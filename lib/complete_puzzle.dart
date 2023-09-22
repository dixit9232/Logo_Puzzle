import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:word_puzzle/GRID_PAGE.dart';
import 'package:word_puzzle/data_list.dart';
import 'package:word_puzzle/puzzle.dart';

class Complete_lvl extends StatefulWidget {
  int index;

  Complete_lvl(this.index);

  @override
  State<Complete_lvl> createState() => _Complete_lvlState();
}

class _Complete_lvlState extends State<Complete_lvl> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Row(
            children: [
              IconButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return Grid_logo();
                      },
                    ), (route) => true);
                  },
                  icon: Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 30,
                  )),
              Expanded(
                child: Center(
                  child: Text(
                      "Logo ${widget.index + 1}/${Data.puzzle_image.length}",
                      style: TextStyle(fontSize: 25, color: Colors.black)),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset("${Data.ans_image[widget.index]}"),
          ),
          SizedBox(
            height: 30,
          ),
          Text("${Data.answer[widget.index]}",
              style: TextStyle(fontSize: 35, color: Colors.black)),
          SizedBox(
            height: 150,
          ),
          Container(
            height: MediaQuery.of(context).size.height * 0.2,
            width: MediaQuery.of(context).size.width * 0.90,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                boxShadow: [
                  BoxShadow(
                      color: Colors.black, offset: Offset(4, 4), blurRadius: 3)
                ],
                gradient: LinearGradient(
                    colors: [Colors.green, Colors.green, Colors.black],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  "PERFECT!",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                Text(
                  "Level Completed!!",
                  style: TextStyle(fontSize: 30, color: Colors.white),
                ),
                NeumorphicButton(
                  style: NeumorphicStyle(
                      boxShape: NeumorphicBoxShape.stadium(),
                      shadowDarkColor: Colors.white,
                      shadowLightColor: Colors.white,
                      color: Colors.black),
                  onPressed: () {
                    widget.index++;
                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                      builder: (context) {
                        return Puzzle(widget.index);
                      },
                    ), (route) => true);
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 50, right: 50),
                    child: Text("NEXT",
                        style: TextStyle(fontSize: 25, color: Colors.white)),
                  ),
                )
              ],
            ),
          )
        ],
      )),
    );
  }
}
