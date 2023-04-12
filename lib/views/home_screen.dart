import 'dart:developer';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, dynamic>> questionList = [
    {
      "QNo": "1",
      "Q": "What is flutter ?",
      "Option1": "A Jojo reference",
      "Option2": "Cross platform Framework for developing application",
      "Option3": "A pokemon",
      "Option4": "An Anime",
      "CorrectAns": 2,
    },
    {
      "QNo": "2",
      "Q": "What programming language does Flutter use?",
      "Option1": "Java",
      "Option2": "Swift",
      "Option3": "C++",
      "Option4": "Dart",
      "CorrectAns": 4
    },
    {
      "QNo": "3",
      "Q": "What is a StatefulWidget in Flutter?",
      "Option1": "A type of widget that can contain other widgets",
      "Option2": "A widget that cannot be modified after it is created",
      "Option3": "A widget that can change its state during runtime",
      "Option4": "A widget that can be moved or resized by the user",
      "CorrectAns": 3
    },
    {
      "QNo": "4",
      "Q": "What is the widget tree in Flutter?",
      "Option1":
          "A data structure that represents a visual hierarchy of widgets",
      "Option2": "A virtual machine that runs Flutter code",
      "Option3": "A tool for debugging Flutter apps",
      "Option4": "A type of widget that can contain other widgets",
      "CorrectAns": 1
    },
    {
      "QNo": "5",
      "Q": "What is the syntax for a class in Dart?",
      "Option1": "class MyClass { }",
      "Option2": "function MyClass() { }",
      "Option3": "MyClass => { }",
      "Option4": "MyClass = { }",
      "CorrectAns": 1
    },
  ];
  int sIndex = 0;
  int qIndex = 0;
  int correctAnsCount = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          toolbarHeight: 100,
          flexibleSpace: ClipPath(
            clipper: CustomClipPath(),
            child: Container(
              height: 150,
              width: MediaQuery.of(context).size.width,
              color: Colors.orange,
              child: Center(
                child: ZoomIn(
                  child: Text(
                    "Quiz app",
                    style: customTextStyle(color: Colors.white),
                  ),
                ),
              ),
            ),
          ),
        ),
        body: Card(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(12),
                width: MediaQuery.of(context).size.width,
                child: Text(
                  "Q${questionList[qIndex]['QNo'].toString()}  ${questionList[qIndex]['Q'].toString()}",
                  style: customTextStyle(color: Colors.white),
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.orange,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              SlideInLeft(
                child: customOptionTiles(
                    selectedIndex: 1,
                    options: questionList[qIndex]['Option1'],
                    optionColor: sIndex == 1
                        ? Colors.greenAccent.shade100
                        : Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              SlideInLeft(
                delay: Duration(milliseconds: 600),
                child: customOptionTiles(
                    selectedIndex: 2,
                    options: questionList[qIndex]['Option2'],
                    optionColor: sIndex == 2
                        ? Colors.greenAccent.shade100
                        : Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              SlideInRight(
                child: customOptionTiles(
                    selectedIndex: 3,
                    options: questionList[qIndex]['Option3'],
                    optionColor: sIndex == 3
                        ? Colors.greenAccent.shade100
                        : Colors.white),
              ),
              SizedBox(
                height: 10,
              ),
              SlideInRight(
                delay: Duration(milliseconds: 800),
                child: customOptionTiles(
                    selectedIndex: 4,
                    options: questionList[qIndex]['Option4'],
                    optionColor: sIndex == 4
                        ? Colors.greenAccent.shade100
                        : Colors.white),
              ),
              SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  var correctAns = questionList[qIndex]['CorrectAns'];
                  if (sIndex == correctAns) {
                    correctAnsCount += 1;
                  }
                  if (qIndex < 4) {
                    qIndex++;

                    sIndex = 0;
                    setState(() {});
                  } else {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title: Text("You Got"),
                        content: Text("$correctAnsCount / 5 "),
                        actions: [
                          TextButton(
                              onPressed: () {
                                qIndex = 0;
                                sIndex = 0;
                                correctAnsCount = 0;
                                Navigator.pop(context);
                                setState(() {});
                              },
                              child: Text("Okey"))
                        ],
                      ),
                    );
                  }
                  log("correct ans : $correctAnsCount;");
                  log("Qindex : $qIndex");
                },
                child: SlideInUp(
                  child: Container(
                    width: 100,
                    height: 60,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Center(
                      child: Text(
                        "Next",
                        style: customTextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ));
  }

  Container customOptionTiles(
      {required String options,
      required Color optionColor,
      required int selectedIndex}) {
    return Container(
      height: 65,
      decoration: BoxDecoration(
          color: optionColor,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(width: 0.7, color: Colors.black45)),
      child: ListTile(
        title: Text(
          options,
          style: customTextStyle(fontWeight: FontWeight.normal),
        ),
        leading: Icon(
          Icons.circle,
          color: Colors.orange,
          size: 10,
        ),
        onTap: () {
          sIndex = selectedIndex;
          setState(() {});
        },
      ),
    );
  }
}

class CustomClipPath extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    // TODO: implement getClip
    double height = size.height;
    double width = size.width;
    Path path = new Path();
    path.lineTo(0, height - 50);
    path.quadraticBezierTo(width / 2, height, width, height - 50);
    path.lineTo(width, 0);
    path.close();
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    // TODO: implement shouldReclip
    return false;
  }
}

customTextStyle({Color? color, FontWeight? fontWeight = FontWeight.bold}) {
  return TextStyle(color: color, fontSize: 20, fontWeight: fontWeight);
}
