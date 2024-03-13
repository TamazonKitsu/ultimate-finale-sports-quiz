import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';

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
    {"question": "(1) คนในรูปนี้คือใคร", "choices": ["ลาเมโล่ บอลล์", "เควิน การ์เน็ต", "สตีเฟน เคอร์รี", "เจมส์ ฮาร์เด็น"], "correctAnswer": "ลาเมโล่ บอลล์"},
    {"question": "(2) คนในรูปนี้คือใคร", "choices": ["ลาเมโล่ บอลล์", "เควิน การ์เน็ต", "สตีเฟน เคอร์รี", "เจมส์ ฮาร์เด็น"], "correctAnswer": "สตีเฟน เคอร์รี"},
    {"question": "(3) คนในรูปนี้คือใคร", "choices": ["ไมเคิล จอร์แดน", "เควิน การ์เน็ต", "สตีเฟน เคอร์รี", "เจมส์ ฮาร์เด็น"], "correctAnswer": "ไมเคิล จอร์แดน"},
    {"question": "(4) คนในรูปนี้คือใคร", "choices": ["ไมเคิล จอร์แดน", "เลอบรอน เจมส์", "สตีเฟน เคอร์รี", "เจมส์ ฮาร์เด็น"], "correctAnswer": "เลอบรอน เจมส์"},
    {"question": "(5) คนในรูปนี้คือใคร", "choices": ["ไมเคิล จอร์แดน", "เควิน การ์เน็ต", "โคบี้ ไบรอันท์", "เจมส์ ฮาร์เด็น"], "correctAnswer": "โคบี้ ไบรอันท์"},
    {"question": "(6) คนในรูปนี้คือใคร", "choices": ["ทิม ดันแคน", "อัลเลน ไอเวอร์สัน", "เคลย์ ทอมป์สัน", "คริส พอล"], "correctAnswer": "เคลย์ ทอมป์สัน"},
    {"question": "(7) คนในรูปนี้คือใคร", "choices": ["ทิม ดันแคน", "จา มอแรนท์", "เคลย์ ทอมป์สัน", "คริส พอล"], "correctAnswer": "จา มอแรนท์"},
    {"question": "(8) คนในรูปนี้คือใคร", "choices": ["เควิน ดูแรนท์", "ทิม ดันแคน", "เดอมาร์คัส เคาซินส์", "เทรซี แม็คเกรดี"], "correctAnswer": "เควิน ดูแรนท์"},
    {"question": "(9) คนในรูปนี้คือใคร", "choices": ["สตีฟ แนช", "เดรย์มอนด์ กรีน", "เรกจี มิลเลอร์", "ลูก้า ดอนซิช"], "correctAnswer": "ลูก้า ดอนซิช"},
    {"question": "(10) คนในรูปนี้คือใคร", "choices": ["จูเลียส เออร์วิง", "แชคิล โอนีล", "ไซออน วิลเลี่ยมสัน", "เรกจี มิลเลอร์"], "correctAnswer": "ไซออน วิลเลี่ยมสัน"},
    {"question": "Magic เป็นฉายาของใคร", "choices": ["โคบี้ ไบรอันท์", "ไมเคิล จอร์แดน", "เลบรอน เจมส์", "แมจิก จอห์นสัน"], "correctAnswer": "แมจิก จอห์นสัน"},
    {"question": "White Chocolate เป็นฉายาของใคร", "choices": ["เจสัน วิลเลียมส์", "เดนนิส ร็อดแมน", "อัลเลน ไอเวอร์สัน", "ฮาคีม โอลาจูวอน"], "correctAnswer": "เจสัน วิลเลียมส์"},
    {"question": "(1) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Chicago Bulls", "Cleveland Cavaliers", "Detroit Pistons", "Milwaukee Bucks"], "correctAnswer": "Chicago Bulls"},
    {"question": "(2) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Chicago Bulls", "Cleveland Cavaliers", "Detroit Pistons", "Milwaukee Bucks"], "correctAnswer": "Cleveland Cavaliers"},
    {"question": "(3) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Chicago Bulls", "Cleveland Cavaliers", "Detroit Pistons", "Milwaukee Bucks"], "correctAnswer": "Milwaukee Bucks"},
    {"question": "(4) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Atlanta Hawks", "Charlotte Hornets", "Miami Heat", "Orlando Magic"], "correctAnswer": "Miami Heat"},
    {"question": "(5) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Dallas Mavericks", "Houston Rockets", "Memphis Grizzlies", "New Orleans Pelicans"], "correctAnswer": "Houston Rockets"},
    {"question": "(6) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Denver Nuggets", "Oklahoma City Thunder", "Portland Trail Blazers", "Minnesota Timberwolves"], "correctAnswer": "Minnesota Timberwolves"},
    {"question": "(7) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Denver Nuggets", "Oklahoma City Thunder", "Portland Trail Blazers", "Minnesota Timberwolves"], "correctAnswer": "Portland Trail Blazers"},
    {"question": "(8) สัญลักษณ์ทีมบาสนี้คือทีมอะไร", "choices": ["Golden State Warriors", "Los Angeles Lakers", "LA Clippers", "Sacramento Kings"], "correctAnswer": "Golden State Warriors"},
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

              SizedBox(
                height: 200,
                child: FutureBuilder<Widget>(
                  future: _buildImage(quiz.questions[questionNumber]["question"] as String),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return snapshot.data!;
                    } else if (snapshot.hasError) {
                      return Text("Error: ${snapshot.error}");
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
              Padding(padding: EdgeInsets.all(10.0)),

              SizedBox(
                height: 80,
                child: Center(
                  child: Text(
                    quiz.questions[questionNumber]["question"] as String,
                    style: TextStyle(fontSize: 20.0),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              Padding(padding: EdgeInsets.all(10.0)),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  for (int i = 0; i < quiz.questions[questionNumber]["choices"].length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: MaterialButton(
                        minWidth: 260,
                        height: 50,
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
                          style: TextStyle(fontSize: 18.0, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),

              Padding(padding: EdgeInsets.all(10.0)),
              SizedBox(height: 40.0),

              Container(
                alignment: Alignment.bottomCenter,
                child: MaterialButton(
                  color: Colors.red,
                  minWidth: 240.0,
                  height: 45.0,
                  onPressed: resetQuiz,
                  child: Text(
                    "To main menu",
                    style: TextStyle(fontSize: 20.0, color: Colors.white),
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
    final imageAssetPathJpg = "assets/images/basketball/$imageCode.jpg";
    final imageAssetPathPng = "assets/images/basketball/$imageCode.png";

    final jpgExists = await rootBundle.load(imageAssetPathJpg).then((_) => true).catchError((_) => false);
    final pngExists = await rootBundle.load(imageAssetPathPng).then((_) => true).catchError((_) => false);

    if (jpgExists) {
      return Image.asset(
        imageAssetPathJpg,
        width: 300.0,
        height: 250.0,
      );
    } else if (pngExists) {
      return Image.asset(
        imageAssetPathPng,
        width: 300.0,
        height: 250.0,
      );
    } else {
      return Container(
        width: 300.0,
        height: 250.0,
        color: Colors.grey,
        child: Center(
          child: Text(
            "Image Not Found",
            style: TextStyle(
              fontSize: 16.0,
              color: Colors.white,
            ),
          ),
        ),
      );
    }
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

class Summary extends StatelessWidget {
  final int score;
  Summary({Key? key, required this.score}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                "Congratulations!",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),
              Text(
                "You got: $score of 30",
                style: TextStyle(
                  fontSize: 25.0,
                ),
              ),

              SizedBox(height: 30.0),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    color: Colors.red,
                    minWidth: 120.0,
                    height: 45.0,
                    onPressed: () {
                      Navigator.pop(context);
                      finalScore = 0;
                      questionNumber = 0;
                    },
                    child: Text(
                      "Reset Quiz",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20.0),
                  MaterialButton(
                    color: Colors.blue,
                    minWidth: 120.0,
                    height: 45.0,
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => MainScreen()));
                    },
                    child: Text(
                      "Main Menu",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
