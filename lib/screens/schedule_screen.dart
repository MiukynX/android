import 'package:flutter/material.dart';
import 'workout_data.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  int selectedDay = 0;

  final List<String> days = [
    'ПН',
    'ВТ',
    'СР',
    'ЧТ',
    'ПТ',
    'СБ',
    'ВС',
  ];
  DateTime getStartOfWeek() {
    final today = DateTime.now();
    return today.subtract(
      Duration(days: today.weekday - 1),
    );
  }

  final List<List<Map<String, String>>> weeklyWorkouts = [
    // ПОНЕДЕЛЬНИК
    [
      {
        'time': '09:00',
        'title': 'Йога',
        'trainer': 'Анна',
        'room': 'Зал №1',
      },
      {
        'time': '12:00',
        'title': 'Бокс',
        'trainer': 'Абылай Барлык',
        'room': 'Зал единоборств',
      },
      {
        'time': '18:00',
        'title': 'Растяжка',
        'trainer': 'Алина',
        'room': 'Зал №2',
      },
    ],

    // ВТОРНИК
    [
      {
        'time': '10:30',
        'title': 'Aqua Fitness',
        'trainer': 'Мария',
        'room': 'Бассейн',
      },
      {
        'time': '15:00',
        'title': 'Танцы',
        'trainer': 'Диана',
        'room': 'Танцевальный зал',
      },
      {
        'time': '19:30',
        'title': 'Диско тайм',
        'trainer': 'Елена',
        'room': 'Танцевальный зал',
      },
    ],

    // СРЕДА
    [
      {
        'time': '09:00',
        'title': 'Йога',
        'trainer': 'Анна',
        'room': 'Зал №1',
      },
      {
        'time': '12:00',
        'title': 'Бокс',
        'trainer': 'Абылай Барлык',
        'room': 'Зал единоборств',
      },
    ],

    // ЧЕТВЕРГ
    [
      {
        'time': '10:30',
        'title': 'Aqua Fitness',
        'trainer': 'Мария',
        'room': 'Бассейн',
      },
      {
        'time': '15:00',
        'title': 'Растяжка',
        'trainer': 'Алина',
        'room': 'Зал №2',
      },
    ],

    // ПЯТНИЦА
    [
      {
        'time': '12:00',
        'title': 'Бокс',
        'trainer': 'Абылай Барлык',
        'room': 'Зал единоборств',
      },
      {
        'time': '18:00',
        'title': 'Танцы',
        'trainer': 'Диана',
        'room': 'Танцевальный зал',
      },
    ],

    // СУББОТА
    [
      {
        'time': '09:00',
        'title': 'Йога',
        'trainer': 'Анна',
        'room': 'Зал №1',
      },
      {
        'time': '19:30',
        'title': 'Диско тайм',
        'trainer': 'Елена',
        'room': 'Танцевальный зал',
      },
    ],

    // ВОСКРЕСЕНЬЕ
    [],
  ];

  void addWorkout(Map<String, String> workout) {
    final selectedDate =
        '${getStartOfWeek().add(Duration(days: selectedDay)).day}.${getStartOfWeek().add(Duration(days: selectedDay)).month}';
    final alreadyAdded = myWorkouts.any(
          (item) =>
      item['title'] == workout['title'] &&
          item['time'] == workout['time'] &&
          item['date'] == selectedDate,
    );

    if (alreadyAdded) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${workout['title']} уже добавлена в «Мои тренировки»',
          ),
        ),
      );
      return;
    }

    myWorkouts.add({
      'date': selectedDate,
      'time': workout['time']!,
      'title': workout['title']!,
      'trainer': workout['trainer']!,
      'room': workout['room']!,
    });
    saveMyWorkouts();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          '${workout['title']} добавлена в «Мои тренировки»',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),

      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Расписание',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: Column(
        children: [

          // ДНИ НЕДЕЛИ
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: days.length,
              itemBuilder: (context, index) {
                final isSelected = selectedDay == index;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDay = index;
                    });
                  },
                  child: Container(
                    width: 58,
                    margin: const EdgeInsets.only(
                      right: 10,
                      top: 8,
                      bottom: 8,
                    ),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? const Color(0xFF1B4332)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          days[index],
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.grey.shade600,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          '${getStartOfWeek().add(Duration(days: index)).day}',
                          style: TextStyle(
                            color: isSelected
                                ? Colors.white
                                : Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 5),

          // СПИСОК ТРЕНИРОВОК
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
              itemCount: weeklyWorkouts[selectedDay].length,
              itemBuilder: (context, index) {
                final workout = weeklyWorkouts[selectedDay][index];

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [

                      // ВРЕМЯ
                      Container(
                        width: 65,
                        height: 65,
                        decoration: BoxDecoration(
                          color: const Color(0xFFE8F0EC),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Center(
                          child: Text(
                            workout['time']!,
                            style: const TextStyle(
                              color: Color(0xFF1B4332),
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(width: 15),

                      // ИНФОРМАЦИЯ
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              workout['title']!,
                              style: const TextStyle(
                                fontSize: 17,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              'Тренер: ${workout['trainer']}',
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 13,
                              ),
                            ),
                            const SizedBox(height: 3),
                            Text(
                              workout['room']!,
                              style: TextStyle(
                                color: Colors.grey.shade500,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // КНОПКА ЗАПИСИ
                      IconButton(
                        onPressed: () {
                          addWorkout(workout);
                        },
                        icon: const Icon(
                          Icons.add_circle_outline,
                          color: Color(0xFF1B4332),
                          size: 30,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}