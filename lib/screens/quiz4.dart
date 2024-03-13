import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';

class BaseballQuiz {
  static final originalQuestions = [
    {"question": "(1) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Chicago Cubs", "Boston Red Sox", "San Francisco Giants", "New York Mets"], "correctAnswer": "Boston Red Sox"},
    {"question": "(2) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Chicago Cubs", "Boston Red Sox", "New York Yankees", "New York Mets"], "correctAnswer": "New York Yankees"},
    {"question": "(3) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Los Angeles Dodgers", "Boston Red Sox", "New York Yankees", "New York Mets"], "correctAnswer": "Los Angeles Dodgers"},
    {"question": "(4) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Philadelphia Phillies", "Boston Red Sox", "San Francisco Giants", "Los Angeles Angels"], "correctAnswer": "San Francisco Giants"},
    {"question": "(5) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Chicago Cubs", "Boston Red Sox", "San Francisco Giants", "New York Mets"], "correctAnswer": "New York Mets"},
    {"question": "(6) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Chicago Cubs", "Boston Red Sox", "San Francisco Giants", "New York Mets"], "correctAnswer": "Chicago Cubs"},
    {"question": "(7) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Philadelphia Phillies", "Boston Red Sox", "Los Angeles Angels", "New York Mets"], "correctAnswer": "Los Angeles Angels"},
    {"question": "(8) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Chicago Cubs", "St. Louis Cardinals", "Philadelphia Phillies", "Boston Red Sox"], "correctAnswer": "St. Louis Cardinals"},
    {"question": "(9) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Philadelphia Phillies", "Boston Red Sox", "San Francisco Giants", "New York Mets"], "correctAnswer": "Philadelphia Phillies"},
    {"question": "(10) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Houston Astros", "Philadelphia Phillies", "St. Louis Cardinals", "Los Angeles Dodgers"], "correctAnswer": "Houston Astros"},
    {"question": "(11) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Washington Nationals", "Toronto Blue Jays", "Houston Astros", "Texas Rangers"], "correctAnswer": "Texas Rangers"},
    {"question": "(12) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Chicago Cubs", "Atlanta Braves", "Texas Rangers", "Toronto Blue Jays"], "correctAnswer": "Atlanta Braves"},
    {"question": "(13) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Washington Nationals", "Toronto Blue Jays", "Atlanta Braves", "Texas Rangers"], "correctAnswer": "Washington Nationals"},
    {"question": "(14) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Washington Nationals", "Toronto Blue Jays", "Atlanta Braves", "Texas Rangers"], "correctAnswer": "Toronto Blue Jays"},
    {"question": "(15) สัญลักษณ์ทีมเบสบอลนี้คือทีมอะไร", "choices": ["Washington Nationals", "Toronto Blue Jays", "Atlanta Braves", "Chicago White Sox"], "correctAnswer": "Chicago White Sox"},
    {"question": "(11) คนในรูปนี้คือใคร", "choices": ["มูกี้ เบตส์", "ไมค์ เทราท์", "เฟอร์นันโด ทาติส จูเนียร์", "โนแลน อาเรนาโด้"], "correctAnswer": "ไมค์ เทราท์"},
    {"question": "(12) คนในรูปนี้คือใคร", "choices": ["มูกี้ เบตส์", "ไมค์ เทราท์", "เฟอร์นันโด ทาติส จูเนียร์", "โนแลน อาเรนาโด้"], "correctAnswer": "มูกี้ เบตส์"},
    {"question": "(13) คนในรูปนี้คือใคร", "choices": ["มูกี้ เบตส์", "ไมค์ เทราท์", "เฟอร์นันโด ทาติส จูเนียร์", "โนแลน อาเรนาโด้"], "correctAnswer": "เฟอร์นันโด ทาติส จูเนียร์"},
    {"question": "(14) คนในรูปนี้คือใคร", "choices": ["มูกี้ เบตส์", "ไมค์ เทราท์", "เฟอร์นันโด ทาติส จูเนียร์", "โนแลน อาเรนาโด้"], "correctAnswer": "โนแลน อาเรนาโด้"},
    {"question": "(15) คนในรูปนี้คือใคร", "choices": ["ไบรซ์ ฮาร์เปอร์", "ไมค์ เทราท์", "เฟอร์นันโด ทาติส จูเนียร์", "โนแลน อาเรนาโด้"], "correctAnswer": "ไบรซ์ ฮาร์เปอร์"},
    {"question": "(16) คนในรูปนี้คือใคร", "choices": ["ไบรซ์ ฮาร์เปอร์", "เดวิด ไพรซ์", "เฟอร์นันโด ทาติส จูเนียร์", "โชเฮ โอตานิ์"], "correctAnswer": "โชเฮ โอตานิ"},
    {"question": "(17) คนในรูปนี้คือใคร", "choices": ["ไบรซ์ ฮาร์เปอร์", "เดวิด ไพรซ์", "เฟอร์นันโด ทาติส จูเนียร์", "โชเฮ โอตานิ์"], "correctAnswer": "เดวิด ไพรซ์"},
    {"question": "(18) คนในรูปนี้คือใคร", "choices": ["ไบรซ์ ฮาร์เปอร์", "เดวิด ไพรซ์", "เคลย์ตัน เคอร์ชอว์", "โชเฮ โอตานิ์"], "correctAnswer": "เคลย์ตัน เคอร์ชอว์"},
    {"question": "(19) คนในรูปนี้คือใคร", "choices": ["แมนนี มาชาโด", "เดวิด ไพรซ์", "เฟอร์นันโด ทาติส จูเนียร์", "โชเฮ โอตานิ์"], "correctAnswer": "แมนนี มาชาโด"},
    {"question": "(20) คนในรูปนี้คือใคร", "choices": ["แมนนี มาชาโด", "เดวิด ไพรซ์", "เฟอร์นันโด ทาติส จูเนียร์", "มิเกล แคเบอรา"], "correctAnswer": "มิเกล แคเบอรา"},
    {"question": "(21) คนในรูปนี้คือใคร", "choices": ["แมนนี มาชาโด", "เดวิด ไพรซ์", "โยเอนิส เซสเปเดส", "มิเกล แคเบอรา"], "correctAnswer": "โยเอนิส เซสเปเดส"},
    {"question": "(22) คนในรูปนี้คือใคร", "choices": ["แมนนี มาชาโด", "จัสติน เวอร์แลนเดอร์", "โยเอนิส เซสเปเดส์", "มิเกล แคเบอรา"], "correctAnswer": "จัสติน เวอร์แลนเดอร์"},
    {"question": "(23) คนในรูปนี้คือใคร", "choices": ["อัลเบิร์ต ปูโจลส์", "จัสติน เวอร์แลนเดอร์", "โยเอนิส เซสเปเดส์", "มิเกล แคเบอรา"], "correctAnswer": "อัลเบิร์ต ปูโจลส์"},
    {"question": "(24) คนในรูปนี้คือใคร", "choices": ["อัลเบิร์ต ปูโจลส์", "จัสติน เวอร์แลนเดอร์", "เจียนคาร์โล สแตนตัน", "มิเกล แคเบอรา"], "correctAnswer": "เจียนคาร์โล สแตนตัน"},
    {"question": "(25) คนในรูปนี้คือใคร", "choices": ["อัลเบิร์ต ปูโจลส์", "จัสติน เวอร์แลนเดอร์", "เจียนคาร์โล สแตนตัน", "เทรเวอร์ บาวเออร์"], "correctAnswer": "เทรเวอร์ บาวเออร์"},
  ];

  late final List<Map<String, dynamic>> questions;

  BaseballQuiz() {
    questions = List.from(BaseballQuiz.originalQuestions);
    questions.shuffle(Random());
  }
}

var finalScore = 0;
var questionNumber = 0;
var quiz = BaseballQuiz();

class Quiz4 extends StatefulWidget {
  const Quiz4({super.key});

  @override
  State<Quiz4> createState() => _Quiz4State();
}

class _Quiz4State extends State<Quiz4> {
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
    final imageAssetPathJpg = "assets/images/baseball/$imageCode.jpg";
    final imageAssetPathPng = "assets/images/baseball/$imageCode.png";

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
      quiz = BaseballQuiz();
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
