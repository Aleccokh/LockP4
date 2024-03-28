import 'dart:math';
import 'package:flutter/material.dart';

enum QuizLevel { addition, multiplicationDivision, algebra }

class MathQuizPage extends StatefulWidget {
  const MathQuizPage({Key? key}) : super(key: key);

  @override
  _MathQuizPageState createState() => _MathQuizPageState();
}

class _MathQuizPageState extends State<MathQuizPage> {
  late QuizLevel quizLevel; // Variable pour le niveau

  @override
  void initState() {
    super.initState();
    quizLevel = QuizLevel.addition; // Par défaut, le niveau est l'addition
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Quiz'),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            DropdownButton<QuizLevel>(
              value: quizLevel,
              onChanged: (QuizLevel? value) {
                setState(() {
                  quizLevel = value!;
                });
              },
              items: [
                DropdownMenuItem(
                  value: QuizLevel.addition,
                  child: Text('Eazy'),
                ),
                DropdownMenuItem(
                  value: QuizLevel.multiplicationDivision,
                  child: Text('Medium'),
                ),
                DropdownMenuItem(
                  value: QuizLevel.algebra,
                  child: Text('Hard'),
                ),
              ],
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                // Naviguer vers la page du quiz avec les calculs appropriés
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => QuizPage(quizLevel: quizLevel),
                  ),
                );
              },
              child: Text('Confirmer'),
            ),
          ],
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  final QuizLevel quizLevel;

  const QuizPage({Key? key, required this.quizLevel}) : super(key: key);

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  late int num1;
  late int num2;
  late int answer;
  late int userAnswer;
  late String operatorSymbol;
  bool isCorrect = false;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final Random random = Random();
    num1 = random.nextInt(10);
    num2 = random.nextInt(10);
    if (widget.quizLevel == QuizLevel.addition) {
      if (random.nextBool()) {
        // Si random.nextBool() est vrai, effectuez une soustraction
        answer = num1 - num2;
        operatorSymbol = "-";
      } else {
        // Sinon, effectuez une addition
        answer = num1 + num2;
        operatorSymbol = "+";
      }
    } else if (widget.quizLevel == QuizLevel.multiplicationDivision) {
      if (random.nextBool()) {
        answer = num1 * num2;
        operatorSymbol = 'x'; // Pour la multiplication
      } else {
        num2 = (random.nextInt(3) + 1) * 2; // Choisit un diviseur de 0.25, 0.5, 0.75, ou 1
        num1 = num2 * (random.nextInt(39) + 1); // Génère un numérateur correspondant
        answer = num1 ~/ num2;
        operatorSymbol = ':'; // Pour la division
      }
    } else if (widget.quizLevel == QuizLevel.algebra) {
      if (random.nextBool()) {
        num1= random.nextInt(10);
        num2 = random.nextInt(10);
        answer = num1 - num2;
        operatorSymbol = "+"; // Pour l'équation
      } else {
        num1= random.nextInt(10);
        num2 = random.nextInt(10);
        answer = num2 - num1;
        operatorSymbol = "-"; // Pour l'équation
      }
    }
    isCorrect = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Math Quiz'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              widget.quizLevel == QuizLevel.algebra
                  ? 'What is ${num2} ${operatorSymbol} x = ${num1}?'
                  : 'What is ${num1} ${operatorSymbol} ${num2}?',
              style: const TextStyle(fontSize: 24.0),
            ),
            const SizedBox(height: 20.0),
            TextField(
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  userAnswer = int.tryParse(value) ?? 0;
                });
              },
            ),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                if (userAnswer == answer) {
                  setState(() {
                    isCorrect = true;
                  });
                }
              },
              child: const Text('Check Answer'),
            ),
            const SizedBox(height: 20.0),
            isCorrect
                ? const Text(
              'Correct!',
              style: TextStyle(color: Colors.green, fontSize: 24.0),
            )
                : const SizedBox(),
            const SizedBox(height: 20.0),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  generateQuestion();
                });
              },
              child: const Text('Reset'),
            ),
          ],
        ),
      ),
    );
  }
}
