import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FootballQuiz {
  static final originalQuestions = [
    {"question": "นักฟุตบอลที่ได้ถ้วยแชมป์มากที่สุดในโลก", "choices": ["Cristiano Ronaldo", "Lionel Messi", "Kaká", "Dani Alves"], "correctAnswer": "Lionel Messi"},
    {"question": "ฉายาไข่มุกดำเป็นฉายาของใคร", "choices": ["Pual Pogba", "Didier Drogba", "Samuel Eto", "Pele"], "correctAnswer": "Pele"},
    {"question": "สุกรโลกันต์เป็นฉายาของใคร", "choices": ["David Backham", "Eden Hazed", "Wayne Rooney", "Anotony"], "correctAnswer": "Wayne Rooney"},
    {"question": "Angel Dimaria ใส่เบอร์อะไรให้แมนยู", "choices": ["7", "8", "9", "10"], "correctAnswer": "7"},
  ];

    late final List<Map<String, dynamic>> questions;

  FootballQuiz() {
    questions = List.from(FootballQuiz.originalQuestions);
    questions.shuffle(Random());
  }
}

var finalScore = 0;
var questionNumber = 0;
var quiz = FootballQuiz();

class Quiz1 extends StatefulWidget {
  const Quiz1({super.key});

  @override
  State<Quiz1> createState() => _Quiz1State();
}

class _Quiz1State extends State<Quiz1> {
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
    final imageAssetPath = "assets/images/football/$imageCode.jpg";
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
      quiz = FootballQuiz();
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
