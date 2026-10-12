import 'package:flutter/material.dart';
import 'book_trainer_screen.dart';

class TrainersScreen extends StatelessWidget {
  const TrainersScreen({super.key});

  final List<Map<String, String>> trainers = const [
    {
      'name': 'Абылай Барлык',
      'specialization': 'Персональный тренер тренажёрного зала',
      'experience': 'Более 4 лет',
      'qualification':
      'Мастер-тренер, сертифицированный тренер',
      'about':
      'Специалист по силовым тренировкам, физической подготовке и реабилитации.',
    },
    {
      'name': 'Анна',
      'specialization': 'Инструктор по йоге',
      'experience': 'Более 3 лет',
      'qualification':
      'Сертифицированный инструктор по йоге',
      'about':
      'Помогает улучшить гибкость, баланс и технику выполнения упражнений.',
    },
    {
      'name': 'Мария',
      'specialization': 'Тренер Aqua Fitness',
      'experience': 'Более 3 лет',
      'qualification':
      'Сертифицированный инструктор Aqua Fitness',
      'about':
      'Проводит групповые занятия в бассейне для разных уровней подготовки.',
    },
    {
      'name': 'Алина',
      'specialization': 'Тренер по растяжке',
      'experience': 'Более 2 лет',
      'qualification':
      'Сертифицированный тренер по стретчингу',
      'about':
      'Специализируется на развитии гибкости и восстановлении после тренировок.',
    },
    {
      'name': 'Диана',
      'specialization': 'Тренер по танцам',
      'experience': 'Более 4 лет',
      'qualification':
      'Профессиональный хореограф',
      'about':
      'Проводит танцевальные тренировки и помогает развивать координацию.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text(
          'Инструкторы',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(20),
        itemCount: trainers.length,
        itemBuilder: (context, index) {
          final trainer = trainers[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TrainerDetailsScreen(
                    trainer: trainer,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 14),
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(18),
              ),
              child: Row(
                children: [
                  Container(
                    width: 65,
                    height: 65,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE8F0EC),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      size: 36,
                      color: Color(0xFF1B4332),
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment:
                      CrossAxisAlignment.start,
                      children: [
                        Text(
                          trainer['name']!,
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          trainer['specialization']!,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          'Опыт: ${trainer['experience']}',
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),

                  const Icon(
                    Icons.chevron_right,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class TrainerDetailsScreen extends StatelessWidget {
  final Map<String, String> trainer;

  const TrainerDetailsScreen({
    super.key,
    required this.trainer,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('Тренер'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Container(
              width: 110,
              height: 110,
              decoration: const BoxDecoration(
                color: Color(0xFF1B4332),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.person,
                color: Colors.white,
                size: 60,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              trainer['name']!,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              trainer['specialization']!,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 15,
                color: Colors.grey.shade600,
              ),
            ),

            const SizedBox(height: 25),

            _InfoCard(
              title: 'Опыт работы',
              value: trainer['experience']!,
              icon: Icons.workspace_premium_outlined,
            ),

            _InfoCard(
              title: 'Квалификация',
              value: trainer['qualification']!,
              icon: Icons.school_outlined,
            ),

            _InfoCard(
              title: 'О тренере',
              value: trainer['about']!,
              icon: Icons.info_outline,
            ),

            const SizedBox(height: 15),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: FilledButton.icon(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BookTrainerScreen(
                        trainerName: trainer['name']!,
                      ),
                    ),
                  );
                },
                icon: const Icon(Icons.calendar_month),
                label: const Text(
                  'Записаться к тренеру',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: const Color(0xFF1B4332),
            size: 28,
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    color: Colors.grey.shade500,
                    fontSize: 12,
                  ),
                ),

                const SizedBox(height: 5),

                Text(
                  value,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}