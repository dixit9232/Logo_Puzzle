
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:word_puzzle/complete_puzzle.dart';
import 'package:word_puzzle/data_list.dart';
import 'package:word_puzzle/main.dart';
import 'package:word_puzzle/puzzle.dart';

class Grid_logo extends StatefulWidget {
  const Grid_logo({super.key});

  @override
  State<Grid_logo> createState() => _Grid_logoState();
}

class _Grid_logoState extends State<Grid_logo> {
  @override
  get_Data() async {
    Start_Page.prefs = await SharedPreferences.getInstance();
    for (int i = 0; i < Start_Page.islvl_completed.length; i++) {
      Start_Page.islvl_completed[i] = Start_Page.prefs!.getBool("lvl${i}clear")??false;
    }
    setState(() {});
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
        child: Column(
          children: [
            Row(
              children: [
                IconButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                        builder: (context) {
                          return Start_Page();
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
                    child: Text("Puzzle",
                        style: TextStyle(fontSize: 25, color: Colors.black)),
                  ),
                ),
              ],
            ),
            Expanded(
              child: GridView.builder(
                itemCount: Data.puzzle_image.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    mainAxisSpacing: 30,
                    crossAxisSpacing: 30),
                itemBuilder: (context, index) {
                  return InkWell(
                      onTap: () {
                        (Start_Page.islvl_completed[index])?Navigator.pushAndRemoveUntil(
                            context, MaterialPageRoute(builder: (context) {
                              return Complete_lvl(index);
                            },), (route) => false):Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) {
                            return Puzzle(index);
                          },
                        ), (route) => true);
                      },
                      child: SizedBox(
                        height: 100,
                        width: 100,
                        child: (Start_Page.islvl_completed[index])
                            ? Stack(
                          children: [
                            Image.asset("${Data.ans_image[index]}",
                                color: Colors.white54.withOpacity(0.7),
                                colorBlendMode: BlendMode.lighten),
                            Positioned(width: 50,top: 60,child: Image.asset("assets/bg/tick.png"))
                          ],
                        )
                            : Image.asset("${Data.puzzle_image[index]}"),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
