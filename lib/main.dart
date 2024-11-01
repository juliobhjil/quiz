import 'package:flutter/material.dart';



void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Quiz App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const QuizPage(),
    );
  }
}

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, Object>> _questions = [
    {
      'questionText': 'Qual é a capital da França?',
      'answers': [
        {'text': 'Paris', 'score': 1},
        {'text': 'Londres', 'score': 0},
        {'text': 'Berlim', 'score': 0},
        {'text': 'Madri', 'score': 0},
      ],
    },
    {
      'questionText': 'Qual é o maior planeta do sistema solar?',
      'answers': [
        {'text': 'Terra', 'score': 0},
        {'text': 'Marte', 'score': 0},
        {'text': 'Júpiter', 'score': 1},
        {'text': 'Saturno', 'score': 0},
      ],
    },
    {
      'questionText': 'Quantos continentes existem no mundo?',
      'answers': [
        {'text': '5', 'score': 0},
        {'text': '6', 'score': 0},
        {'text': '7', 'score': 1},
        {'text': '8', 'score': 0},
      ],
    },
    {
      'questionText': 'Quem pintou a Mona Lisa?',
      'answers': [
        {'text': 'Vincent van Gogh', 'score': 0},
        {'text': 'Pablo Picasso', 'score': 0},
        {'text': 'Leonardo da Vinci', 'score': 1},
        {'text': 'Claude Monet', 'score': 0},
      ],
    },
  ];

  int _questionIndex = 0;
  int _totalScore = 0;

  void _answerQuestion(int score) {
    _totalScore += score;
    setState(() {
      _questionIndex++;
    });
  }

  void _resetQuiz() {
    setState(() {
      _questionIndex = 0;
      _totalScore = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz App'),
      ),
      body: _questionIndex < _questions.length
          ? Quiz(
              questions: _questions,
              questionIndex: _questionIndex,
              answerQuestion: _answerQuestion,
            )
          : Result(totalScore: _totalScore, resetQuiz: _resetQuiz),
    );
  }
}

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final int questionIndex;
  final Function answerQuestion;

  const Quiz({super.key, 
    required this.questions,
    required this.questionIndex,
    required this.answerQuestion,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          questions[questionIndex]['questionText'] as String,
          style: const TextStyle(fontSize: 24),
        ),
        ...(questions[questionIndex]['answers'] as List<Map<String, Object>>)
            .map((answer) {
          return ElevatedButton(
            onPressed: () => answerQuestion(answer['score']),
            child: Text(answer['text'] as String),
          );
        }),
      ],
    );
  }
}

class Result extends StatelessWidget {
  final int totalScore;
  final VoidCallback resetQuiz;

  const Result({super.key, required this.totalScore, required this.resetQuiz});

  String get resultPhrase {
    return 'Você acertou $totalScore de 4 perguntas!';
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            resultPhrase,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: resetQuiz,
            child: const Text('Refazer o Quiz'),
          ),
        ],
      ),
    );
  }
}
