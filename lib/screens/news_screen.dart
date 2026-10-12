import 'package:flutter/material.dart';

class NewsScreen extends StatelessWidget {
  const NewsScreen({super.key});

  final List<Map<String, String>> news = const [
    {
      'title': 'Новая групповая тренировка',
      'date': '22 сентября 2026',
      'description':
      'В нашем клубе появилась новая программа групповых тренировок. Записывайтесь через расписание и тренируйтесь вместе с нами.',
    },
    {
      'title': 'Специальное предложение',
      'date': '20 сентября 2026',
      'description':
      'Для новых участников клуба действует специальное предложение на абонементы.',
    },
    {
      'title': 'Тренируйся вместе с нами',
      'date': '18 сентября 2026',
      'description':
      'Выбирайте подходящую тренировку, записывайтесь и достигайте своих целей вместе с Fitness Club.',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Новости',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: news.length,
        itemBuilder: (context, index) {
          final item = news[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NewsDetailScreen(
                    title: item['title']!,
                    date: item['date']!,
                    description: item['description']!,
                  ),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
              ),
              clipBehavior: Clip.antiAlias,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  // Место для фотографии
                  Container(
                    height: 170,
                    width: double.infinity,
                    color: const Color(0xFF1B4332),
                    child: const Icon(
                      Icons.fitness_center,
                      color: Colors.white,
                      size: 55,
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.all(18),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item['date']!,
                          style: TextStyle(
                            color: Colors.grey.shade500,
                            fontSize: 12,
                          ),
                        ),

                        const SizedBox(height: 7),

                        Text(
                          item['title']!,
                          style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          item['description']!,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                            height: 1.4,
                          ),
                        ),

                        const SizedBox(height: 12),

                        const Row(
                          children: [
                            Text(
                              'Подробнее',
                              style: TextStyle(
                                color: Color(0xFF1B4332),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(width: 5),
                            Icon(
                              Icons.arrow_forward,
                              size: 17,
                              color: Color(0xFF1B4332),
                            ),
                          ],
                        ),
                      ],
                    ),
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

class NewsDetailScreen extends StatelessWidget {
  final String title;
  final String date;
  final String description;

  const NewsDetailScreen({
    super.key,
    required this.title,
    required this.date,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
        title: const Text(
          'Новость',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Container(
              height: 220,
              width: double.infinity,
              decoration: BoxDecoration(
                color: const Color(0xFF1B4332),
                borderRadius: BorderRadius.circular(22),
              ),
              child: const Icon(
                Icons.fitness_center,
                color: Colors.white,
                size: 70,
              ),
            ),

            const SizedBox(height: 20),

            Text(
              date,
              style: TextStyle(
                color: Colors.grey.shade500,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              title,
              style: const TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 18),

            Text(
              description,
              style: const TextStyle(
                fontSize: 16,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}