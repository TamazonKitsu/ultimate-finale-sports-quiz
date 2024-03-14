import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';

class FootballQuiz {
  static final originalQuestions = [
    {"question": "นักฟุตบอลที่ได้ถ้วยแชมป์มากที่สุดในโลก", "choices": ["Cristiano Ronaldo", "Lionel Messi", "Kaká", "Dani Alves"], "correctAnswer": "Lionel Messi"},
    {"question": "ฉายาไข่มุกดำเป็นฉายาของใคร", "choices": ["Pual Pogba", "Didier Drogba", "Samuel Eto", "Pele"], "correctAnswer": "Pele"},
    {"question": "สุกรโลกันต์เป็นฉายาของใคร", "choices": ["David Backham", "Eden Hazed", "Wayne Rooney", "Anotony"], "correctAnswer": "Wayne Rooney"},
    {"question": "Angel Dimaria ใส่เบอร์อะไรให้แมนยู", "choices": ["7", "8", "9", "10"], "correctAnswer": "7"},
    {"question": "นักฟุตบอลคนใดที่ได้รับรางวัลบัลลงดอร์มากที่สุด", "choices": ["คริสเตียโน่ โรนัลโด้", "ลิโอเนล เมสซี", "โยฮัน ครัฟฟ์", "มิเชล พลาตินี"], "correctAnswer": "ลิโอเนล เมสซี"},
    {"question": "นักฟุตบอลคนใดที่ยิงประตูได้มากที่สุดในฟุตบอลโลก", "choices": ["มิโรสลาฟ โคลเซ่", "เปเล่", "โรนัลโด้ (บราซิล)", "คริสเตียโน่ โรนัลโด้"], "correctAnswer": "มิโรสลาฟ โคลเซ่"},
    {"question": "นักฟุตบอลคนใดที่เป็นกัปตันทีมชาติอังกฤษที่อายุน้อยที่สุด", "choices": ["ไมเคิล โอเว่น", "เวย์น รูนี่ย์", "เดวิด เบ็คแฮม", "สตีเวน เจอร์ราร์ด"], "correctAnswer": "ไมเคิล โอเว่น"},
    {"question": "นักฟุตบอลคนใดที่เล่นให้กับสโมสรเดียวตลอดอาชีพค้าแข้ง", "choices": ["คาร์เลส ปูยอล", "เปาโล มัลดินี่", "ไรอัน กิกส์", "ฟรานเชสโก้ ต็อตติ"], "correctAnswer": "ฟรานเชสโก้ ต็อตติ"},
    {"question": "นักฟุตบอลคนใดที่ได้รับรางวัลรองเท้าทองคำมากที่สุด", "choices": ["ลิโอเนล เมสซี", "เกอร์ด มุลเลอร์", "คริสเตียโน่ โรนัลโด้", "ทิเออร์รี่ อองรี"], "correctAnswer": "คริสเตียโน่ โรนัลโด้"},
    {"question": "นักฟุตบอลคนใดที่คว้าแชมป์ยูฟ่าแชมเปียนส์ลีกมากที่สุด", "choices": ["อิเคร์ กาซิยาส", "ฟรานซิสโก้ เกนโต้", "คริสเตียโน่ โรนัลโด้", "เปเป้"], "correctAnswer": "ฟรานซิสโก้ เกนโต้"},
    {"question": "นักฟุตบอลคนใดที่ได้รับรางวัลผู้รักษาประตูยอดเยี่ยมแห่งปีของยูฟ่ามากที่สุด", "choices": ["มานูเอล นอยเออร์", "อิเคร์ กาซิยาส", "จี บุฟฟ่อน", "ปีเตอร์ ชไมเคิ่ล"], "correctAnswer": "มานูเอล นอยเออร์"},
    {"question": "นักฟุตบอลคนใดที่คว้าแชมป์พรีเมียร์ลีกมากที่สุด", "choices": ["เซอร์ อเล็กซ์ เฟอร์กูสัน", "เป๊ป กวาร์ดิโอล่า", "โชเซ่ มูรินโญ่", "อาร์แซน เวนเกอร์"], "correctAnswer": "เซอร์ อเล็กซ์ เฟอร์กูสัน"},
    {"question": "นักฟุตบอลคนใดที่ยิงประตูได้มากที่สุดในพรีเมียร์ลีก", "choices": ["อลัน เชียร์เรอร์", "เวย์น รูนีย์", "เซอร์จิโอ อเกวโร่", "แฮร์รี่ เคน"], "correctAnswer": "อลัน เชียร์เรอร์"},
    {"question": "นักฟุตบอลคนใดที่ได้รับรางวัลนักฟุตบอลยอดเยี่ยมแห่งปีของพีเอฟเอมากที่สุด", "choices": ["Alan Shearer", "Wayne Rooney", "Thierry Henry", "Cristiano Ronaldo"], "correctAnswer": "Thierry Henry"},
    {"question": "นักฟุตบอลคนใดที่เป็นเจ้าของสถิติโลกยิงประตูในนามทีมชาติมากที่สุด", "choices": ["เปเล่ (บราซิล)", "ลิโอเนล เมสซี (อาร์เจนตินา)", "คริสเตียโน่ โรนัลโด้ (โปรตุเกส)", "โรนัลโด้ (บราซิล)"], "correctAnswer": "ลิโอเนล เมสซี (อาร์เจนตินา)"},
    {"question": "นักฟุตบอลคนใดที่ได้รับรางวัล The Best FIFA Men's Player มากที่สุด", "choices": ["ลิโอเนล เมสซี (อาร์เจนตินา)", "โรนัลโด้ (บราซิล)", "โรนัลโด้ (โปรตุเกส)", "โรเบิร์ต เลวานดอฟสกี้ (โปแลนด์)"], "correctAnswer": "ลิโอเนล เมสซี (อาร์เจนตินา)"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์ลาลีกาได้มากที่สุด", "choices": ["แอตเลติโก มาดริด", "เรอัล มาดริด", "อัตเลติกเดบิลบาโอ", "บาร์เซโลนา"], "correctAnswer": "บาร์เซโลนา"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์กัลโช่ เซเรีย อา ได้มากที่สุด", "choices": ["เอซี มิลาน", "อินเตอร์ มิลาน", "ยูเวนตุส", "โรม"], "correctAnswer": "ยูเวนตุส"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์บุนเดสลีกาได้มากที่สุด", "choices": ["โบรุสเซีย ดอร์ทมุนด์", "บาเยิร์น มิวนิค", "โวล์ฟสบวร์ก", "ฮัมบูร์เกอร์ เอสวี"], "correctAnswer": "บาเยิร์น มิวนิค"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์ลีกเอิงได้มากที่สุด", "choices": ["โอลิมปิก ลียง", "โมนาโก", "มาร์กเซย", "ปารีส แซงต์ แชร์กแม็ง"], "correctAnswer": "ปารีส แซงต์ แชร์กแม็ง"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์เอเรดิวิซีได้มากที่สุด", "choices": ["อาแจ็กซ์", "เปแอสเช", "เฟเยนูร์ด", "พีเอสวี ไอนด์โฮเฟ่น"], "correctAnswer": "อาแจ็กซ์"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์พรีเมียร์ลีกสกอตแลนด์ได้มากที่สุด", "choices": ["เรนเจอร์ส", "อาเบอร์ดีน", "เซลติก", "ฮาร์ตส์"], "correctAnswer": "เซลติก"},
    {"question": "ทีมฟุตบอลทีมใดที่คว้าแชมป์ไทยลีกได้มากที่สุด", "choices": ["เมืองทอง ยูไนเต็ด", "สิงห์ เชียงราย ยูไนเต็ด", "เอสซีจี เมืองทอง ยูไนเต็ด", "บุรีรัมย์ ยูไนเต็ด"], "correctAnswer": "บุรีรัมย์ ยูไนเต็ด"},
    {"question": "นักฟุตบอลหญิงคนใดที่ได้รับรางวัล The Best FIFA Women's Player มากที่สุด", "choices": ["อเล็กซ์ มอร์แกน (สหรัฐอเมริกา)", "ลูซี่ บรอนซ์ (อังกฤษ)", "เมแกน ราพิโน (สหรัฐอเมริกา)", "มาร์ธา (บราซิล)"], "correctAnswer": "เมแกน ราพิโน (สหรัฐอเมริกา)"},
    {"question": "สโมสรใดได้แชมป์พรีเมียร์ลีกมากที่สุด", "choices": ["แมนเชสเตอร์ยูไนเต็ด", "ลิเวอร์พูล", "เชลซี", "แมนเชสเตอร์ ซิตี้"], "correctAnswer": "ลิเวอร์พูล"},
    {"question": "ใครคือผู้ทำประตูสูงสุดตลอดกาลของพรีเมียร์ลีก", "choices": ["อลัน เชียร์เรอร์", "เวย์น รูนีย์", "เซร์คิโอ อเกวโร่", "แฮร์รี่ เคน"], "correctAnswer": "อลัน เชียร์เรอร์"},
    {"question": "สโมสรใดมีสถิติไม่แพ้ใครในบ้านยาวนานที่สุดในพรีเมียร์ลีก", "choices": ["แมนเชสเตอร์ ซิตี้", "แมนเชสเตอร์ยูไนเต็ด", "อาร์เซนอล", "ลิเวอร์พูล"], "correctAnswer": "ลิเวอร์พูล"},
    {"question": "ผู้เล่นคนใดได้รับรางวัลนักเตะยอดเยี่ยมแห่งปีของพรีเมียร์ลีกมากที่สุด", "choices": ["คริสเตียโน่ โรนัลโด้", "ทิเออร์รี่ อองรี", "เควิน เดอ บรอยน์", "แกเร็ธ เบล"], "correctAnswer": "ทิเออร์รี่ อองรี"},
    {"question": "ทีมใดที่เคยตกชั้นจากพรีเมียร์ลีกแล้วกลับมาคว้าแชมป์ได้เร็วที่สุด", "choices": ["เลสเตอร์ ซิตี้", "แอสตัน วิลลา", "นิวคาสเซิล ยูไนเต็ด", "สวอนซี ซิตี้"], "correctAnswer": "เลสเตอร์ ซิตี้"},
    {"question": "ผู้เล่นคนใดที่ยิงประตูได้เร็วที่สุดในประวัติศาสตร์พรีเมียร์ลีก", "choices": ["อลัน เชียร์เรอร์", "เท็ดดี้ เชอริงแฮม", "เฟร็ด", "ดไวท์ ยอร์ค"], "correctAnswer": "ดไวท์ ยอร์ค"},
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
    final imageAssetPathJpg = "assets/images/football/$imageCode.jpg";
    final imageAssetPathPng = "assets/images/football/$imageCode.png";

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
