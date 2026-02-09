// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Business Quiz",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF2563EB),
          brightness: Brightness.light,
        ),
        useMaterial3: true,
        fontFamily: 'SF Pro Display',
      ),
      home: const QuizScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class Question {
  final String questionText;
  final List<String> answers;
  final int correctAnswerIndex;

  Question({
    required this.questionText,
    required this.answers,
    required this.correctAnswerIndex,
  });
}

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> with SingleTickerProviderStateMixin {
  // Quiz state variables
  bool quizStarted = false;
  int currentQuestionIndex = 0;
  int score = 0;
  int? selectedAnswerIndex;
  bool isAnswered = false;
  bool quizEnded = false;
  
  // Timer variables
  Timer? _timer;
  int _secondsRemaining = 60;
  
  // Animation controller for page transitions
  late AnimationController _fadeController;
  late Animation<double> _fadeAnimation;

  // Quiz questions
  final List<Question> questions = [
    Question(
      questionText:
          'Why do business use automation?',
      answers: [
        'Reducing manual, repetitive tasks',
        'Increasing costs',
        'Ensuring compliance to government rules',
        'Increasing workload for employees',
      ],
      correctAnswerIndex: 0,
    ),
    Question(
      questionText:
          'What is an example of an AI innovation in businesses?',
      answers: [
        'Holding meetings through online platforms',
        'A chatbot for customer support',
        'Able to remotely accessing data',
        'A word processor',
      ],
      correctAnswerIndex: 1,
    ),
    Question(
      questionText:
          'Why do businesses integrate cloud services?',
      answers: [
        'To print documents faster',
        'To improve customer support',
        'To comply with industry standards',
        'To store and access data through the internet',
      ],
      correctAnswerIndex: 3, // FIXED: Changed from 2 to 3
    ),
    Question(
      questionText:
          'What does RPA stand for in business automation?', // FIXED: Changed "Why does" to "What does"
      answers: [
        'Robotic Process Automation',
        'Remote Process Automation',
        'Repetitive Process Automation',
        'Rapid Process Automation',
      ],
      correctAnswerIndex: 0,
    ),
     Question(
      questionText:
          'What is the primary purpose of a company conducting a SWOT analysis?',
      answers: [
        'To audit its quarterly financial statements',
        'To identify internal Strengths and Weaknesses, and external Opportunities and Threats',
        'To set the annual holiday schedule for employees',
        'To design the company\'s logo and branding materials',
      ],
      correctAnswerIndex: 1,
    ),
  ];

  @override
  void initState() {
    super.initState();
    
    // Initialize fade animation
    _fadeController = AnimationController(
      duration: const Duration(milliseconds: 400),
      vsync: this,
    );
    
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _fadeController, curve: Curves.easeInOut),
    );
    
    _fadeController.forward();
  }

  @override
  void dispose() {
    _timer?.cancel();
    _fadeController.dispose();
    super.dispose();
  }

  void startTimer() {
    _timer?.cancel();
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_secondsRemaining > 0) {
          _secondsRemaining--;
        } else {
          _timer?.cancel();
          quizEnded = true;
        }
      });
    });
  }

  void startQuiz() {
    setState(() {
      quizStarted = true;
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswerIndex = null;
      isAnswered = false;
      quizEnded = false;
      _secondsRemaining = 60;
    });
    _fadeController.forward(from: 0);
    startTimer();
  }

  void selectAnswer(int index) {
    if (!isAnswered) {
      setState(() {
        selectedAnswerIndex = index;
        isAnswered = true;
        
        if (index == questions[currentQuestionIndex].correctAnswerIndex) {
          score++;
        }
      });
    }
  }

  void nextQuestion() {
    _fadeController.forward(from: 0);
    setState(() {
      if (currentQuestionIndex < questions.length - 1) {
        currentQuestionIndex++;
        selectedAnswerIndex = null;
        isAnswered = false;
      } else {
        quizEnded = true;
        _timer?.cancel();
      }
    });
  }

  void restartQuiz() {
    setState(() {
      quizStarted = false;
      currentQuestionIndex = 0;
      score = 0;
      selectedAnswerIndex = null;
      isAnswered = false;
      quizEnded = false;
    });
    _timer?.cancel();
    _fadeController.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: SafeArea(
        child: !quizStarted
            ? buildStartView()
            : quizEnded
                ? buildEndView()
                : buildQuizView(),
      ),
    );
  }

  // Start View
  Widget buildStartView() {
    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: const Color(0xFF2563EB),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF2563EB).withOpacity(0.3),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: const Icon(
                  Icons.quiz_outlined,
                  size: 64,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 40),
              
              // Title
              const Text(
                'Business Quiz',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              // Subtitle
              Text(
                'Let\'s test your knowledge!',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 48),
              
              // Info Cards
              Container(
                padding: const EdgeInsets.all(24),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    _buildInfoRow(Icons.help_outline, 'Questions', '${questions.length}'),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.timer_outlined, 'Time Limit', '60 seconds'),
                    const SizedBox(height: 16),
                    _buildInfoRow(Icons.emoji_events_outlined, 'Passing Score', '70%'),
                  ],
                ),
              ),
              const SizedBox(height: 48),
              
              // Start Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: startQuiz,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Start Quiz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: const Color(0xFFEFF6FF),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(
            icon,
            size: 20,
            color: const Color(0xFF2563EB),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey[700],
            ),
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF0F172A),
          ),
        ),
      ],
    );
  }

  // Quiz View
  Widget buildQuizView() {
    final question = questions[currentQuestionIndex];
    final progress = (currentQuestionIndex + 1) / questions.length;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Column(
        children: [
          // Header
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(
                bottom: BorderSide(color: Color(0xFFE2E8F0)),
              ),
            ),
            child: Column(
              children: [
                // Progress and Timer Row
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    // Progress
                    Text(
                      'Question ${currentQuestionIndex + 1}/${questions.length}',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF64748B),
                      ),
                    ),
                    
                    // Timer
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: _secondsRemaining <= 10
                            ? const Color(0xFFFEE2E2)
                            : const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.timer_outlined,
                            size: 16,
                            color: _secondsRemaining <= 10
                                ? const Color(0xFFEF4444)
                                : const Color(0xFF64748B),
                          ),
                          const SizedBox(width: 6),
                          Text(
                            '$_secondsRemaining s',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: _secondsRemaining <= 10
                                  ? const Color(0xFFEF4444)
                                  : const Color(0xFF64748B),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                
                // Progress Bar
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: const Color(0xFFE2E8F0),
                    valueColor: const AlwaysStoppedAnimation<Color>(Color(0xFF2563EB)),
                    minHeight: 6,
                  ),
                ),
              ],
            ),
          ),

          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Question
                  Text(
                    question.questionText,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF0F172A),
                      height: 1.5,
                      letterSpacing: -0.3,
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Answers
                  ...List.generate(question.answers.length, (index) {
                    final isCorrect = index == question.correctAnswerIndex;
                    final isSelected = selectedAnswerIndex == index;
                    final showCorrect = isAnswered && isCorrect;
                    final showWrong = isAnswered && isSelected && !isCorrect;

                    Color backgroundColor = Colors.white;
                    Color borderColor = const Color(0xFFE2E8F0);
                    Color textColor = const Color(0xFF0F172A);

                    if (showCorrect) {
                      backgroundColor = const Color(0xFFDCFCE7);
                      borderColor = const Color(0xFF22C55E);
                      textColor = const Color(0xFF166534);
                    } else if (showWrong) {
                      backgroundColor = const Color(0xFFFEE2E2);
                      borderColor = const Color(0xFFEF4444);
                      textColor = const Color(0xFF991B1B);
                    } else if (isSelected && !isAnswered) {
                      borderColor = const Color(0xFF2563EB);
                    }

                    return Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: Material(
                        color: backgroundColor,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          onTap: isAnswered ? null : () => selectAnswer(index),
                          borderRadius: BorderRadius.circular(16),
                          child: Container(
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              border: Border.all(color: borderColor, width: 1.5),
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Row(
                              children: [
                                // Letter Circle
                                Container(
                                  width: 32,
                                  height: 32,
                                  decoration: BoxDecoration(
                                    color: showCorrect || showWrong
                                        ? (showCorrect ? const Color(0xFF22C55E) : const Color(0xFFEF4444))
                                        : const Color(0xFFF1F5F9),
                                    shape: BoxShape.circle,
                                  ),
                                  child: Center(
                                    child: Text(
                                      String.fromCharCode(65 + index),
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        fontSize: 14,
                                        color: showCorrect || showWrong
                                            ? Colors.white
                                            : const Color(0xFF64748B),
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                
                                // Answer Text
                                Expanded(
                                  child: Text(
                                    question.answers[index],
                                    style: TextStyle(
                                      fontSize: 15,
                                      height: 1.5,
                                      color: textColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ),
                                
                                // Check/X Icon
                                if (showCorrect)
                                  const Icon(
                                    Icons.check_circle,
                                    color: Color(0xFF22C55E),
                                    size: 24,
                                  ),
                                if (showWrong)
                                  const Icon(
                                    Icons.cancel,
                                    color: Color(0xFFEF4444),
                                    size: 24,
                                  ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  }),

                  // Next Button
                  if (isAnswered) ...[
                    const SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      height: 56,
                      child: ElevatedButton(
                        onPressed: nextQuestion,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF2563EB),
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: Text(
                          currentQuestionIndex < questions.length - 1
                              ? 'Next Question'
                              : 'See Results',
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  // End View
  Widget buildEndView() {
    final percentage = (score / questions.length * 100).round();
    final isPerfect = score == questions.length;
    final isPassing = percentage >= 70;

    return FadeTransition(
      opacity: _fadeAnimation,
      child: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Result Icon
              Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: isPerfect
                      ? const Color(0xFFFEF3C7)
                      : isPassing
                          ? const Color(0xFFDCFCE7)
                          : const Color(0xFFFEE2E2),
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: (isPerfect
                              ? const Color(0xFFF59E0B)
                              : isPassing
                                  ? const Color(0xFF22C55E)
                                  : const Color(0xFFEF4444))
                          .withOpacity(0.2),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Icon(
                  isPerfect
                      ? Icons.emoji_events
                      : isPassing
                          ? Icons.check_circle_outline
                          : Icons.refresh,
                  size: 64,
                  color: isPerfect
                      ? const Color(0xFFF59E0B)
                      : isPassing
                          ? const Color(0xFF22C55E)
                          : const Color(0xFFEF4444),
                ),
              ),
              const SizedBox(height: 32),

              // Result Title
              Text(
                isPerfect
                    ? 'Perfect Score!'
                    : isPassing
                        ? 'Well Done!'
                        : 'Keep Practicing!',
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0F172A),
                  letterSpacing: -0.5,
                ),
              ),
              const SizedBox(height: 8),
              
              Text(
                isPerfect
                    ? 'You answered all questions correctly!'
                    : isPassing
                        ? 'You passed the quiz!'
                        : 'Try again to improve your score',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 40),

              // Score Card
              Container(
                padding: const EdgeInsets.all(32),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(24),
                  border: Border.all(color: const Color(0xFFE2E8F0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.04),
                      blurRadius: 8,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Text(
                      'Your Score',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[600],
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.baseline,
                      textBaseline: TextBaseline.alphabetic,
                      children: [
                        Text(
                          '$score',
                          style: const TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF0F172A),
                            height: 1,
                          ),
                        ),
                        Text(
                          ' / ${questions.length}',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.w600,
                            color: Colors.grey[400],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFF1F5F9),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Text(
                        '$percentage%',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF2563EB),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),

              // Restart Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton.icon(
                  onPressed: restartQuiz,
                  icon: const Icon(Icons.refresh),
                  label: const Text(
                    'Retake Quiz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 0.5,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
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