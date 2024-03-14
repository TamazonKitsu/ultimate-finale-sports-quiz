import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';

class AmericanfootballQuiz {
  static final originalQuestions = [
    {"question": "ทีมใดที่ชนะ Super Bowl LVIII ในปี 2024", "choices": ["Kansas City Chiefs", "Philadelphia Eagles", "Cincinnati Bengals", "Los Angeles Rams"], "correctAnswer": "Kansas City Chiefs"},
    {"question": "ผู้เล่นคนใดได้รับรางวัล Super Bowl LVII MVP", "choices": ["Patrick Mahomes", "Jalen Hurts", "Joe Burrow", "Matthew Stafford"], "correctAnswer": "Jalen Hurts"},
    {"question": "ทีมใดที่มีผู้เล่นมากที่สุดใน Pro Bowl 2024", "choices": ["Buffalo Bills", "Philadelphia Eagles", "Kansas City Chiefs", "Dallas Cowboys"], "correctAnswer": "Kansas City Chiefs"},
    {"question": "สนามกีฬาใดมีผู้เข้าชมมากที่สุดใน NFL 2023", "choices": ["AT&T Stadium", "MetLife Stadium", "SoFi Stadium", "Allegiant Stadium"], "correctAnswer": "AT&T Stadium"},
    {"question": "ผู้เล่นคนใดทำลายสถิติ NFL สำหรับระยะการส่งบอลมากที่สุดในฤดูกาลเดียว", "choices": ["Peyton Manning", "Tom Brady", "Patrick Mahomes", "Drew Brees"], "correctAnswer": "Patrick Mahomes"},
    {"question": "ทีมใดคว้าแชมป์ NFC West ในปี 2023", "choices": ["San Francisco 49ers", "Los Angeles Rams", "Arizona Cardinals", "Seattle Seahawks"], "correctAnswer": "Los Angeles Rams"},
    {"question": "ทีมใดคว้าแชมป์ AFC East ในปี 2023", "choices": ["Buffalo Bills", "New England Patriots", "Miami Dolphins", "New York Jets"], "correctAnswer": "Buffalo Bills"},
    {"question": "ผู้เล่นคนใดได้รับรางวัล NFL MVP ในปี 2023", "choices": ["Patrick Mahomes", "Justin Jefferson", "Aaron Donald", "Cooper Kupp"], "correctAnswer": "Patrick Mahomes"},
    {"question": "ทีมใดคว้าแชมป์ Super Bowl มากที่สุด", "choices": ["New England Patriots", "Pittsburgh Steelers", "Dallas Cowboys", "Green Bay Packers"], "correctAnswer": "New England Patriots"},
    {"question": "ผู้เล่นคนใดทำ Touchdown มากที่สุดในประวัติศาสตร์ NFL", "choices": ["Jerry Rice", "Tom Brady", "Peyton Manning", "Emmitt Smith"], "correctAnswer": "Jerry Rice"},
    {"question": "อุปกรณ์ป้องกันใดที่สำคัญที่สุดสำหรับผู้เล่นอเมริกันฟุตบอล", "choices": ["แผ่นรองไหล่", "กางเกงขายาว", "หมวกกันน็อค", "รองเท้า"], "correctAnswer": "หมวกกันน็อค"},
    {"question": "อเมริกันฟุตบอลมีกี่คนในทีม", "choices": ["11 คน", "12 คน", "13 คน", "14 คน"], "correctAnswer": "11 คน"},
    {"question": "อะไรคือชื่อของลีกอเมริกันฟุตบอลอาชีพหลักในอเมริกา", "choices": ["AFL", "CFL", "USFL", "NFL"], "correctAnswer": "NFL"},
    {"question": "อะไรคือชื่อของเกม Super Bowl ครั้งแรก", "choices": ["Super Bowl I", "Super Bowl II", "Super Bowl II", "Super Bowl IV"], "correctAnswer": "Super Bowl I"},
    {"question": "ทีมใดที่ชนะ Super Bowl ครั้งแรก", "choices": ["Pittsburgh Steelers", "Green Bay Packers", "Kansas City Chiefs", "New England Patriots"], "correctAnswer": "Green Bay Packers"},
    {"question": "อะไรคือชื่อของรางวัลผู้เล่นทรงคุณค่า (MVP) ของ Super Bowl", "choices": ["Pete Rozelle Trophy", "Lamar Hunt Trophy", "Vince Lombardi Trophy", "Bart Starr Award"], "correctAnswer": "Vince Lombardi Trophy"},
    {"question": "อะไรคือชื่อของรางวัลผู้เล่นทรงคุณค่า (MVP) ของ NFL", "choices": ["Pete Rozelle Trophy", "Lamar Hunt Trophy", "Vince Lombardi Trophy", "Bart Starr Award"], "correctAnswer": "Bart Starr Award"},
    {"question": "กี่ควอเตอร์มีในเกมอเมริกันฟุตบอล", "choices": ["1", "2", "3", "4"], "correctAnswer": "4"},
    {"question": "อะไรคือชื่อของเส้นที่แบ่งสนามออกเป็นสองส่วน", "choices": ["Hash marks", "Goal line", "Line of scrimmage", "50-yard line"], "correctAnswer": "Line of scrimmage"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบส่งบอล", "choices": ["Running back", "Quarterback", "Wide receiver", "Defensive tackle"], "correctAnswer": "Quarterback"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบวิ่งกับบอล", "choices": ["Quarterback", "Wide receiver", "Defensive tackle", "Running back"], "correctAnswer": "Running back"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบรับบอล", "choices": ["Running back", "Quarterback", "Wide receiver", "Defensive tackle"], "correctAnswer": "Wide receiver"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบป้องกันฝ่ายตรงข้าม", "choices": ["Quarterback", "Wide receiver", "Defensive tackle", "Running back"], "correctAnswer": "Defensive tackle"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบเตะลูก", "choices": ["Kicker", "Wide receiver", "Defensive tackle", "Running back"], "correctAnswer": "Kicker"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบรับลูกเตะ", "choices": ["Running back", "Quarterback", "Punt returner", "Defensive tackle"], "correctAnswer": "Punt returner"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบบล็อกผู้เล่นฝ่ายตรงข้าม", "choices": ["Running back", "Quarterback", "Wide receiver", "Offensive lineman"], "correctAnswer": "Offensive lineman"},
    {"question": "อะไรคือชื่อของผู้เล่นที่รับผิดชอบรุกไล่ Quarterback ฝ่ายตรงข้าม", "choices": ["Defensive end", "Wide receiver", "Defensive tackle", "Running back"], "correctAnswer": "Defensive end"},
    {"question": "อะไรคือชื่อของคะแนนที่ได้จากการวิ่งเข้าเขตปลายสุดของสนาม", "choices": ["Touchdown", "Field goal", "Safety", "Extra point"], "correctAnswer": "Touchdown"},
    {"question": "อะไรคือชื่อของคะแนนที่ได้จากการเตะลูกบอลผ่านเสาประตู", "choices": ["Touchdown", "Field goal", "Safety", "Extra point"], "correctAnswer": "Field goal"},
    {"question": "รูปแบบของลูกบอลที่ใช้ในอเมริกันฟุตบอลและฟุตบอลต่างกันอย่างไร", "choices": ["อเมริกัน-ทรงกลม ฟุตบอล-ทรงรี", "อเมริกัน-ทรงรีปลายแหลม ฟุตบอล-ทรงกลม", "อเมริกัน-ทรงรี ฟุตบอล-ทรงแปดเหลี่ยม", "อเมริกันฟ-ทรงแปดเหลี่ยม ฟุตบอล-ทรงกลม"], "correctAnswer": "อเมริกัน-ทรงรีปลายแหลม ฟุตบอล-ทรงกลม"},
  ];

  late final List<Map<String, dynamic>> questions;

  AmericanfootballQuiz() {
    questions = List.from(AmericanfootballQuiz.originalQuestions);
    questions.shuffle(Random());
  }
}

var finalScore = 0;
var questionNumber = 0;
var quiz = AmericanfootballQuiz();

class Quiz5 extends StatefulWidget {
  const Quiz5({super.key});

  @override
  State<Quiz5> createState() => _Quiz5State();
}

class _Quiz5State extends State<Quiz5> {
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
    final imageAssetPathJpg = "assets/images/americanfootball/$imageCode.jpg";
    final imageAssetPathPng = "assets/images/americanfootball/$imageCode.png";

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
      quiz = AmericanfootballQuiz();
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
