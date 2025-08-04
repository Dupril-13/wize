import 'package:flutter/material.dart';
import '../end.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int currentQuestionIndex = 0;
  int score = 0;
  bool? isCorrect;
  bool showFeedback = false;

  final List<Map<String, dynamic>> questions = [
    {
      'question': 'Quel est le best prof de Mercy Innovation Lab ?',
      'choices': ['NKADA', 'SERGIO', 'THIERRY', 'KEN'],
      'correctAnswer': 'SERGIO',
    },
    {
      'question': 'Combien font 2 + 2 ?',
      'choices': ['3', '4', '5', '6'],
      'correctAnswer': '4',
    },
    {
      'question': 'Quel est le plus grand océan ?',
      'choices': ['Atlantique', 'Indien', 'Pacifique', 'Arctique'],
      'correctAnswer': 'Pacifique',
    },
    {
      'question': 'Combien de continents y a-t-il sur Terre ?',
      'choices': ['5', '6', '7', '8'],
      'correctAnswer': '7',
    },
    {
      'question': 'Quel est le plus grand pays du monde ?',
      'choices': ['Russie', 'Canada', 'Chine', 'États-Unis'],
      'correctAnswer': 'Russie',
    },
  ];

  // Fonction pour vérifier la réponse du user.
  void checkAnswer(String selectedAnswer) {
    setState(() {
      // Vérif de la rep
      isCorrect = selectedAnswer == questions[currentQuestionIndex]['correctAnswer'];
      if (isCorrect!) score++;
      showFeedback = true;
    });

    Future.delayed(const Duration(seconds: 1), () {
      setState(() {
        showFeedback = false;
        currentQuestionIndex++;
        if (currentQuestionIndex >= questions.length) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => EndPage(score: score, total: questions.length),
            ),
          );
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    // Récupère la question actuelle.
    final currentQuestion = questions[currentQuestionIndex];
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Quiz',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
            ),
            backgroundColor: Colors.green,
            centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: Column(
            children: [
              const SizedBox(height: 20),
              // Affichage la question actuel
              Text(
                currentQuestion['question'],
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              // Affichage des reponses
              ...currentQuestion['choices'].map<Widget>((choice) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(

                      padding: const EdgeInsets.symmetric(horizontal: 150, vertical: 15),
                      backgroundColor: showFeedback
                          // Change la couleur du bouton en f° de la rep
                          ? (choice == currentQuestion['correctAnswer']
                          ? Colors.green
                          : (choice == isCorrect ? Colors.red : null))
                          : null,
                    ),
                    onPressed: showFeedback ? null : () => checkAnswer(choice),
                    child: Text(choice),
                  ),
                );
              }).toList(),

              if (showFeedback)
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: Text(
                    isCorrect! ? 'Bonne réponse !' : 'Mauvaise réponse !',
                    style: TextStyle(
                      color: isCorrect! ? Colors.green : Colors.red,
                      fontSize: 16,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}