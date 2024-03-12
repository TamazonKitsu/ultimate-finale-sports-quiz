import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class BasketballQuiz {
  static final originalQuestions = [
    {"question": "กีฬาบาสเกตบอลเกิดขึ้นครั้งแรกที่ใด", "choices": ["ญี่ปุ่น", "เกาหลีใต้", "อังกฤษ", "สหรัฐอเมริกา"], "correctAnswer": "สหรัฐอเมริกา"},
    {"question": "คะแนนที่ได้จากการยิงลูกโทษแต่ละลูกมีค่ากี่คะแนน", "choices": ["1 คะแนน", "2 คะแนน", "3 คะแนน", "4 คะแนน"], "correctAnswer": "1 คะแนน"},
    {"question": "การแข่งขัน จะประกอบด้วย 4 ช่วงเวลา ช่วงละกี่นาที", "choices": ["5 นาที", "10 นาที", "13 นาที", "15 นาที"], "correctAnswer": "10 นาที"},
    {"question": "กีฬาบาสเกตบอล ดัดแปลงมาจากกีฬาอะไร", "choices": ["ฟุตบอล-แชร์บอล", "อเมริกันฟุตบอล-เบสบอล", "แชร์บอล-เบสบอล", "แชร์บอล-แฮนด์บอล"], "correctAnswer": "อเมริกันฟุตบอล-เบสบอล"},
    {"question": "คะแนนที่ได้จากการยิงในเขตครึ่งวงกลม แต่ละลูกมีค่าเท่ากับเท่าใด", "choices": ["1 คะแนน", "2 คะแนน", "3 คะแนน", "4 คะแนน"], "correctAnswer": "2 คะแนน"},
    {"question": "คะแนนที่ได้จากการยิงนอกเขตครึ่งวงกลม ไกลสุด แต่ละลูกมีค่าเท่ากับเท่าใด", "choices": ["1 คะแนน", "2 คะแนน", "3 คะแนน", "4 คะแนน"], "correctAnswer": "3 คะแนน"},
    {"question": "League อาชีพของบาสเกตบอลชื่อว่าอะไร", "choices": ["MBA", "FIBA", "NBA", "ABN"], "correctAnswer": "NBA"},
    {"question": "Black Mamba เป็นฉายาของใคร", "choices": ["ฮาคีม โอลาจูวอน", "โคบี้ ไบรอันท์", "เลบรอน เจมส์", "แมจิก จอห์นสัน"], "correctAnswer": "โคบี้ ไบรอันท์"},
    {"question": "The Goat เป็นฉายาของใคร", "choices": ["แมจิก จอห์นสัน", "เลบรอน เจมส์", "ไมเคิล จอร์แดน", "โคบี้ ไบรอันท์"], "correctAnswer": "ไมเคิล จอร์แดน"},
    {"question": "The King เป็นฉายาของใคร", "choices": ["ฮาคีม โอลาจูวอน", "โคบี้ ไบรอันท์", "เลบรอน เจมส์", "แมจิก จอห์นสัน"], "correctAnswer": "เลบรอน เจมส์"},
  ];

  late final List<Map<String, dynamic>> questions;

  BasketballQuiz() {
    questions = List.from(BasketballQuiz.originalQuestions);
    questions.shuffle(Random());
  }
}

var finalScore = 0;
var questionNumber = 0;
var quiz = BasketballQuiz();

class Quiz2 extends StatefulWidget {
  const Quiz2({super.key});

  @override
  State<Quiz2> createState() => _Quiz2State();
}

class _Quiz2State extends State<Quiz2> {
  String? selectedChoice;

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          alignment: Alignment.topCenter,
          margin: EdgeInsets.all(10.0),
          child: Column(
            children: <Widget>[
              Padding(padding: EdgeInsets.all(20.0)),
              Container(
                alignment: Alignment.centerRight,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text("Question ${questionNumber + 1} of ${quiz.questions.length}",
                        style: TextStyle(fontSize: 22.0)),
                    Text("Score: $finalScore", style: TextStyle(fontSize: 22.0)),
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),

              FutureBuilder<Widget>(
                future: _buildImage(quiz.questions[questionNumber]["question"] as String),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return snapshot.data!; // Display the loaded image widget
                  } else if (snapshot.hasError) {
                    return Text("Error: ${snapshot.error}"); // Handle errors
                  }
                  // Display a placeholder widget while loading
                  return CircularProgressIndicator();
                },
              ),
              Padding(padding: EdgeInsets.all(10.0)),

              Text(
                quiz.questions[questionNumber]["question"] as String,
                style: TextStyle(fontSize: 20.0),
              ),

              Padding(padding: EdgeInsets.all(20.0)),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < quiz.questions[questionNumber]["choices"].length; i++)
                    MaterialButton(
                      minWidth: 60.0,
                      color: Colors.green,
                      onPressed: () {
                        setState(() {
                          selectedChoice = quiz.questions[questionNumber]["choices"][i];
                          final String selectedChoiceValue = selectedChoice!;

                          if (selectedChoiceValue == quiz.questions[questionNumber]["correctAnswer"]) {
                            debugPrint("Correct!!");
                            finalScore++;
                          } else {
                            debugPrint("Wrong...");
                          }
                          updateQuestion();
                        });
                      },
                      child: Text(
                        quiz.questions[questionNumber]["choices"][i],
                        style: TextStyle(fontSize: 20.0, color: Colors.white),
                      ),
                    ),
                ],
              ),

              Padding(padding: EdgeInsets.all(10.0)),
              SizedBox(height: 50.0),

              Container(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Colors.red,
                  minWidth: 240.0,
                  height: 45.0,
                  onPressed: resetQuiz,
                  child: Text(
                    "To main menu",
                    style: TextStyle(fontSize: 18.0, color: Colors.white),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<Widget> _buildImage(String question) async {
    final path = "assets/question_image_mapping.json";
    print("Loading image data from: $path");
    final mapData = jsonDecode(await rootBundle.loadString(path));
    final imageCode = mapData[question];
    final imageAssetPath = "assets/images/basketball/$imageCode.jpg";
    return Image.asset(
      imageAssetPath,
      width: 300.0,
      height: 250.0,
    );
  }

  void resetQuiz(){
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
      quiz = BasketballQuiz();
    });
  }

  void updateQuestion(){
    setState(() {
      if (questionNumber == quiz.questions.length - 1){
        var tempScore = finalScore;
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return Summary(score: tempScore);
          },
        );
        finalScore = 0;
        questionNumber = 0;
      }
      else{
        questionNumber++;
      }
    });
  }
}

class Summary extends StatelessWidget{
  final int score;
  Summary({Key, key, required this.score}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.topCenter,
        child: Column(
          children: <Widget>[
            Text("Final Score: $score",
              style: TextStyle(
                  fontSize: 25.0
              ),),

            SizedBox(height: 30.0),

            MaterialButton(
              color: Colors.red,
              onPressed: (){
                Navigator.pop(context);
                finalScore = 0;
                questionNumber = 0;
              },
              child: Text("Reset Quiz",
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white
                ),),
            )
          ],
        ),
      ),
    );
  }
}
