import 'package:flutter/material.dart';

class FootballQuiz{
  var questions = [
    "นักฟุตบอลที่ได้ถ้วยแชมป์มากที่สุดในโลก", "ฉายาไข่มุกดำเป็นฉายาของใคร",
    "สุกกรโลกันต์เป็นฉายาของใคร", "Angel Dimaria ใส่เบอร์อะไรให้แมนยู"
  ];

  var choices = [
    ["Cristiano Ronaldo", "Lionel Messi", "Kaká", "Dani Alves"],
    ["Pual Pogba", "Didier Drogba", "Samuel Eto", "Pele"],
    ["David Backham", "Eden Hazed", "Wayne Roony", "Anotony"],
    ["7", "8", "9", "10"]
  ];

  var correctAnswers = [
    "Lionel Messi", "Pele", "Wayne Roony", "7"
  ];
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
