import 'package:flutter/material.dart';

class BasketballQuiz{
  var questions = [
    "กีฬาบาสเกตบอลเกิดขึ้นครั้งแรกที่ใด", "คะแนนที่ได้จากการยิงลูกโทษแต่ละลูกมีค่ากี่คะแนน",
    "การแข่งขัน จะประกอบด้วย 4 ช่วงเวลา ช่วงละกี่นาที", "กีฬาบาสเกตบอล ดัดแหลงมาจากกีฬาอะไร"
  ];

  var choices = [
    ["ญี่ปุ่น", "เกาหลีใต้", "อังกฤษ", "สหรัฐอเมริกา"],
    ["1 คะแนน", "2 คะแนน", "3 คะแนน", "4 คะแนน"],
    ["5 นาที", "10 นาที", "13 นาที", "15 นาที"],
    ["ฟุตบอล-แชร์บอล", "อเมริกันฟุตบอล-เบสบอล", "แชร์บอล-เบสบอล", "แชร์บอล-แฮนด์บอล"]
  ];

  var correctAnswers = [
    "สหรัฐอเมริกา", "1 คะแนน", "10 นาที", "อเมริกันฟุตบอล-เบสบอล"
  ];
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
                      style: TextStyle(
                          fontSize: 22.0
                      ),),
                    Text("Score: $finalScore",
                      style: TextStyle(
                          fontSize: 22.0
                      ),)
                  ],
                ),
              ),
              Padding(padding: EdgeInsets.all(20.0)),

              Text (quiz.questions[questionNumber],
                style: TextStyle(
                  fontSize: 20.0,
                ),textAlign: TextAlign.center,),

              Padding(padding: EdgeInsets.all(10.0)),

              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  MaterialButton(
                    minWidth: 60.0,
                    color: Colors.green,
                    onPressed: (){
                      if(quiz.choices[questionNumber][0] == quiz.correctAnswers[questionNumber]){
                        debugPrint("Correct!!");
                        finalScore++;
                      }
                      else{
                        debugPrint("Wrong...");
                      }
                      updateQuestion();
                    },
                    child: Text(quiz.choices[questionNumber][0],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),),
                  ),
                  SizedBox(height: 10.0),
                  MaterialButton(
                    minWidth: 60.0,
                    color: Colors.green,
                    onPressed: (){
                      if(quiz.choices[questionNumber][1] == quiz.correctAnswers[questionNumber]){
                        debugPrint("Correct!!");
                        finalScore++;
                      }
                      else{
                        debugPrint("Wrong...");
                      }
                      updateQuestion();
                    },
                    child: Text(quiz.choices[questionNumber][1],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),),
                  ),
                  SizedBox(height: 10.0),
                  MaterialButton(
                    minWidth: 60.0,
                    color: Colors.green,
                    onPressed: (){
                      if(quiz.choices[questionNumber][2] == quiz.correctAnswers[questionNumber]){
                        debugPrint("Correct!!");
                        finalScore++;
                      }
                      else{
                        debugPrint("Wrong...");
                      }
                      updateQuestion();
                    },
                    child: Text(quiz.choices[questionNumber][2],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),),
                  ),
                  SizedBox(height: 10.0),
                  MaterialButton(
                    minWidth: 60.0,
                    color: Colors.green,
                    onPressed: (){
                      if(quiz.choices[questionNumber][3] == quiz.correctAnswers[questionNumber]){
                        debugPrint("Correct!!");
                        finalScore++;
                      }
                      else{
                        debugPrint("Wrong...");
                      }
                      updateQuestion();
                    },
                    child: Text(quiz.choices[questionNumber][3],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Colors.white
                      ),),
                  )
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
                  child: Text("To main menu",
                    style: TextStyle(
                        fontSize: 18.0,
                        color: Colors.white
                    ),),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void resetQuiz(){
    setState(() {
      Navigator.pop(context);
      finalScore = 0;
      questionNumber = 0;
    });
  }

  void updateQuestion(){
    setState(() {
      if (questionNumber == quiz.questions.length - 1){
        var tempScore = finalScore;
        Navigator.push(context, MaterialPageRoute(builder: (context)=> Summary(score: tempScore)));
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
  Widget build(BuildContext context){
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text("Final Score: $score",
                style: TextStyle(
                    fontSize: 25.0
                ),),

              Padding(padding: EdgeInsets.all(10.0)),

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
      ),
    );
  }
}
