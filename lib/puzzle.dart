import 'package:flutter/material.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:word_puzzle/GRID_PAGE.dart';
import 'package:word_puzzle/complete_puzzle.dart';
import 'package:word_puzzle/data_list.dart';
import 'package:word_puzzle/main.dart';

class Puzzle extends StatefulWidget {
  int index;

  Puzzle(this.index);

  @override
  State<Puzzle> createState() => _PuzzleState();
}

class _PuzzleState extends State<Puzzle> {
  List ans_keyword = [];

  List user_answer = [];
  int ans_counter = 0;
  List isbutton_pressed = [];
  List isclear = [];

  Widget Wrong_ansDialog() {
    return AlertDialog(
      elevation: 0,
      backgroundColor: Colors.black54,
      title: Text(
        "Incorrect",
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 35, color: Colors.white),
      ),
      content: SizedBox(
        height: 300,
        width: 300,
        child: Column(children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: Colors.red,
                size: 120,
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                  child: Text(
                softWrap: true,
                "Remove Some letters and try again",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 20, color: Colors.white54),
              )),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          NeumorphicButton(
            style: NeumorphicStyle(
                boxShape: NeumorphicBoxShape.stadium(),
                shadowDarkColor: Colors.grey,
                shadowLightColor: Colors.white,
                color: Colors.black38),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Padding(
              padding: const EdgeInsets.only(left: 50, right: 50),
              child: Text("OK",
                  style: TextStyle(fontSize: 15, color: Colors.white)),
            ),
          )
        ]),
      ),
    );
  }

  @override
  void initState() {
    Data.other_character.shuffle();
    user_answer = List.filled(Data.answer[widget.index].toString().length, "");
    ans_keyword =
        List.filled(Data.answer[widget.index].toString().length * 2, "");
    isbutton_pressed = List.filled(ans_keyword.length, false);
    for (int i = 0; i < Data.answer[widget.index].toString().length; i++) {
      ans_keyword[i] = Data.answer[widget.index].toString()[i];
    }
    for (int i = Data.answer[widget.index].toString().length;
        i < ans_keyword.length;
        i++) {
      ans_keyword[i] = Data.other_character[i];
    }
    ans_keyword.shuffle();
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
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            height: 200,
            width: 200,
            child: Image.asset(
              "${Data.puzzle_image[widget.index]}",
            ),
          ),
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Wrap(
                    alignment: WrapAlignment.center,
                    children: List.generate(
                        Data.answer[widget.index].toString().length,
                        (index) => Container(
                              margin: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.black,
                                  borderRadius: BorderRadius.circular(5),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 2,
                                        offset: Offset(3, 3))
                                  ]),
                              height: 40,
                              width: 40,
                              alignment: Alignment.center,
                              child: Text("${user_answer[index]}",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20)),
                            ))),
              ),
            ],
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ElevatedButton(
                    style: ButtonStyle(
                        shape: MaterialStatePropertyAll(StadiumBorder()),
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.green)),
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) {
                          return AlertDialog(
                            title: Text("Hint",
                                style: TextStyle(fontSize: 30),
                                textAlign: TextAlign.center),
                            content: Text("Enter ${Data.answer[widget.index]}",
                                style: TextStyle(fontSize: 20),
                                textAlign: TextAlign.center),
                            actions: [
                              TextButton(
                                  onPressed: () {
                                    Navigator.pop(context);
                                  },
                                  child: Text(
                                    "OK",
                                    style: TextStyle(fontSize: 20),
                                  ))
                            ],
                          );
                        },
                      );
                    },
                    child: Row(
                      children: [
                        Icon(Icons.info, color: Colors.white, size: 40),
                        SizedBox(
                          width: 10,
                        ),
                        Text(
                          "Use Hint",
                          style: TextStyle(color: Colors.white, fontSize: 25),
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: IconButton(
                      splashRadius: 0.1,
                      onPressed: () {
                        user_answer = List.filled(user_answer.length, "");
                        isbutton_pressed =
                            List.filled(ans_keyword.length, false);
                        isclear = [];
                        ans_counter = 0;
                        setState(() {});
                      },
                      icon: Icon(
                        Icons.cancel,
                        size: 50,
                        color: Colors.red,
                      )),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 20),
                  child: IconButton(
                      splashRadius: 0.1,
                      onPressed: () {
                        if (ans_counter > 0) {
                          user_answer[ans_counter - 1] = "";
                          isbutton_pressed[isclear[ans_counter - 1]] = false;
                          isclear.removeAt(ans_counter - 1);
                          setState(() {
                            ans_counter--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.backspace,
                        size: 50,
                        color: Colors.red,
                      )),
                ),
              ]),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(10),
              itemCount: ans_keyword.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisSpacing: 10, mainAxisSpacing: 10, crossAxisCount: 7),
              itemBuilder: (context, index) {
                return Visibility(
                  visible: isbutton_pressed[index],
                  child: Text(""),
                  replacement: InkWell(
                    onTap: () {
                      if (ans_counter <= user_answer.length - 1) {
                        user_answer[ans_counter] = ans_keyword[index];
                        isbutton_pressed[index] = true;
                        isclear.add(index);
                        if (ans_counter == user_answer.length - 1) {
                          String ans = user_answer.join("");
                          if (ans == Data.answer[widget.index]) {
                            Start_Page.prefs!.setBool("lvl${widget.index}clear", true);
                            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
                              return Complete_lvl(widget.index);
                            },), (route) => true);
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Wrong_ansDialog();
                              },
                            );
                          }
                        }
                        setState(() {
                          ans_counter++;
                        });
                      }
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.grey,
                          borderRadius: BorderRadius.circular(5),
                          boxShadow: const [
                            BoxShadow(
                              color: Colors.black,
                              offset: Offset(3, 3),
                              blurRadius: 2,
                            ),
                          ]),
                      height: 60,
                      width: 60,
                      alignment: Alignment.center,
                      child: Text("${ans_keyword[index]}",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 30,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      )),
    );
  }
}
