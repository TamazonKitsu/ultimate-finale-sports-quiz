import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:finalprojectsportsquiz/screens/main_screen.dart';

class VolleyballQuiz {
  static final originalQuestions = [
    {"question": "วอลเลย์บอลมีผู้เล่นฝั่งละกี่คนในสนาม", "choices": ["4 คน", "6 คน", "8 คน", "10 คน"], "correctAnswer": "6 คน"},
    {"question": "ลูกวอลเลย์บอลต้องสัมผัสพื้นฝั่งตรงข้ามกี่ครั้งก่อน", "choices": ["1 ครั้ง", "2 ครั้ง", "3 ครั้ง", "4 ครั้ง"], "correctAnswer": "3 ครั้ง"},
    {"question": "ผู้เล่นสามารถตีลูกวอลเลย์บอลได้กี่ครั้งติดต่อกัน", "choices": ["1 ครั้ง", "2 ครั้ง", "3 ครั้ง", "4 ครั้ง"], "correctAnswer": "1 ครั้ง"},
    {"question": "ตาข่ายกั้นเขตแดนในสนามวอลเลย์บอลมีความสูงเท่าไหร่", "choices": ["1 เมตร", "1.5 เมตร", "2 เมตร", "2.5 เมตร"], "correctAnswer": "2 เมตร"},
    {"question": "ผู้เล่นสามารถเสิร์ฟลูกวอลเลย์บอลได้จากที่ไหน", "choices": ["เส้นหลังเขตแดน", "เส้นกลางสนาม", "เส้นหน้าเขตแดน", "ตรงไหนก็ได้ในสนาม"], "correctAnswer": "เส้นหลังเขตแดน"},
    {"question": "ผู้เล่นสามารถจับลูกวอลเลย์บอลไว้กับตัวได้นานแค่ไหน", "choices": ["3 วินาที", "5 วินาที", "8 วินาที", "10 วินาที"], "correctAnswer": "5 วินาที"},
    {"question": "ทีมใดเป็นผู้ชนะเมื่อได้คะแนนครบ", "choices": ["15 คะแนน", "20 คะแนน", "25 คะแนน", "30 คะแนน"], "correctAnswer": "25 คะแนน"},
    {"question": "ทีมใดเป็นผู้เสิร์ฟก่อนในเกม", "choices": ["ทีมเยือน", "ทีมเจ้าบ้าน", "ทีมที่ชนะในเกมก่อนหน้า", "ทีมที่แพ้ในเกมก่อนหน้า"], "correctAnswer": "ทีมที่ชนะในเกมก่อนหน้า"},
    {"question": "ท่าไหนที่ใช้ในการรับลูกเสิร์ฟ", "choices": ["ท่าตบ", "ท่ารับ", "ท่าเสิร์ฟ", "ท่าบล็อก"], "correctAnswer": "ท่ารับ"},
    {"question": "ท่าไหนที่ใช้ในการตีลูกวอลเลย์บอล", "choices": ["ท่าตบ", "ท่ารับ", "ท่าเสิร์ฟ", "ท่าบล็อก"], "correctAnswer": "ท่าตบ"},
    {"question": "อะไรคือจุดประสงค์หลักของการบล็อกในวอลเลย์บอล", "choices": ["ส่งลูกให้เพื่อนร่วมทีม", "ป้องกันไม่ให้ลูกวอลเลย์บอลข้ามตาข่าย", "ทำคะแนน", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "ผู้เล่นสามารถสัมผัสลูกวอลเลย์บอลได้กี่ครั้งติดต่อกันภายในหนึ่งแรลลี่", "choices": ["1 ครั้ง", "2 ครั้ง", "3 ครั้ง", "4 ครั้ง"], "correctAnswer": "3 ครั้ง"},
    {"question": "อะไรคือกฎ 3 เมตรในวอลเลย์บอล", "choices": ["ผู้เล่นต้องอยู่ห่างจากตาข่าย 3 เมตร", "ผู้เล่นสามารถตีลูกวอลเลย์บอลได้ 3 ครั้ง", "ผู้เล่นสามารถเสิร์ฟลูกวอลเลย์บอลจาก 3 เส้น", "ผู้เล่นต้องอยู่ภายในพื้นที่ 3 เมตร"], "correctAnswer": "ผู้เล่นต้องอยู่ห่างจากตาข่าย 3 เมตร"},
    {"question": "อะไรคือท่าที่ใช้ในการเสิร์ฟลูกวอลเลย์บอล", "choices": ["ท่าตบ", "ท่ารับ", "ท่าเสิร์ฟ", "ท่าบล็อก"], "correctAnswer": "ท่าเสิร์ฟ"},
    {"question": "อะไรคือท่าที่ใช้ในการรับลูกตบ", "choices": ["ท่าตบ", "ท่ารับ", "ท่าเสิร์ฟ", "ท่าบล็อก"], "correctAnswer": "ท่าบล็อก"},
    {"question": "ผู้เล่นสามารถหมุนเปลี่ยนตัวได้กี่ครั้ง", "choices": ["6 ครั้ง", "12 ครั้ง", "18 ครั้ง", "ไม่มีจำกัด"], "correctAnswer": "12 ครั้ง"},
    {"question": "อะไรคือคะแนนพิเศษในวอลเลย์บอล", "choices": ["เอซ", "บล็อก", "เซ็ต", "ทั้งหมดข้างต้น"], "correctAnswer": "เอซ"},
    {"question": "อะไรคืออุปกรณ์ที่ใช้ในการเล่นวอลเลย์บอล", "choices": ["ลูกวอลเลย์บอล", "ตาข่าย", "สนาม", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "อะไรคือประโยชน์ของการเล่นวอลเลย์บอล", "choices": ["ฝึกความคล่องตัว", "ฝึกการทำงานเป็นทีม", "ฝึกความอดทน", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "วอลเลย์บอลเป็นกีฬาที่ได้รับความนิยมในประเทศไทยหรือไม่", "choices": ["ใช่", "ไม่", "ไม่แน่ใจ", "ขึ้นอยู่กับบุคคล"], "correctAnswer": "ใช่"},
    {"question": "อะไรคือชื่อทีมวอลเลย์บอลหญิงทีมชาติไทย", "choices": ["วอลเลย์บอลสาวไทย", "วอลเลย์บอลไทย", "วอลเลย์บอลทีมชาติไทย", "วอลเลย์บอลดาราไทย"], "correctAnswer": "วอลเลย์บอลทีมชาติไทย"},
    {"question": "อะไรคือชื่อผู้ฝึกสอนวอลเลย์บอลหญิงทีมชาติไทย", "choices": ["ดนัย ศรีวัชรเมธากุล", "ชำนาญ ดอกไม้", "อาทิราศ์ ศรีสุข", "ยอดชาย  บุญเลิศ"], "correctAnswer": "ดนัย ศรีวัชรเมธากุล"},
    {"question": "วอลเลย์บอลมีกี่ประเภทหลัก", "choices": ["1 ประเภท", "2 ประเภท", "3 ประเภท", "4 ประเภท"], "correctAnswer": "3 ประเภท"},
    {"question": "วอลเลย์บอลชายหาดมีกี่คนในทีม", "choices": ["2 คน", "4 คน", "6 คน", "8 คน"], "correctAnswer": "2 คน"},
    {"question": "อะไรคือความแตกต่างระหว่างวอลเลย์บอลในร่มและวอลเลย์บอลชายหาด", "choices": ["จำนวนผู้เล่น", "สนาม", "ลูกวอลเลย์บอล", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "อะไรคือทักษะพื้นฐานที่สำคัญที่สุดในการเล่นวอลเลย์บอล", "choices": ["การตบ", "การรับ", "การเสิร์ฟ", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "อะไรคือกลยุทธ์ที่ใช้ในการเล่นวอลเลย์บอล", "choices": ["การโจมตี", "การป้องกัน", "การทำงานเป็นทีม", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "อะไรคือข้อควรระวังในการเล่นวอลเลย์บอล", "choices": ["การบาดเจ็บ", "การปวดกล้ามเนื้อ", "การเหนื่อยล้า", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "อะไรคือมารยาทในการเล่นวอลเลย์บอล", "choices": ["การเคารพผู้ตัดสิน", "การเคารพคู่แข่ง", "การเล่นอย่างมีน้ำใจนักกีฬา", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
    {"question": "อะไรคือประโยชน์ของการดูวอลเลย์บอล", "choices": ["ความสนุกสนาน", "ความตื่นเต้น", "การผ่อนคลาย", "ทั้งหมดข้างต้น"], "correctAnswer": "ทั้งหมดข้างต้น"},
  ];

  late final List<Map<String, dynamic>> questions;

  VolleyballQuiz() {
    questions = List.from(VolleyballQuiz.originalQuestions);
    questions.shuffle(Random());
  }
}

var finalScore = 0;
var questionNumber = 0;
var quiz = VolleyballQuiz();

class Quiz3 extends StatefulWidget {
  const Quiz3({super.key});

  @override
  State<Quiz3> createState() => _Quiz3State();
}

class _Quiz3State extends State<Quiz3> {
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
    final imageAssetPathJpg = "assets/images/volleyball/$imageCode.jpg";
    final imageAssetPathPng = "assets/images/volleyball/$imageCode.png";

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
      quiz = VolleyballQuiz();
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
