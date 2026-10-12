import 'package:flutter/material.dart';
import 'workout_data.dart';

class MyWorkoutsScreen extends StatefulWidget {
  const MyWorkoutsScreen({super.key});

  @override
  State<MyWorkoutsScreen> createState() => _MyWorkoutsScreenState();
}

class _MyWorkoutsScreenState extends State<MyWorkoutsScreen> {
  @override
  void initState() {
    super.initState();

    loadMyWorkouts().then((_) {
      if (mounted) {
        setState(() {});
      }
    });
  }
  String formatDate(String date) {
    final parts = date.split('.');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);

    const months = [
      '',
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];

    return '$day ${months[month]}';
  }
  List<Map<String, String>> get workouts => myWorkouts;

  void cancelWorkout(int index) {
    final workoutName = workouts[index]['title'];

    setState(() {
      workouts.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('$workoutName отменена'),
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
          'Мои тренировки',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),

      body: workouts.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        itemCount: workouts.length,
        itemBuilder: (context, index) {
          final workout = workouts[index];

          return _WorkoutCard(
            workout: workout,
            onCancel: () {
              cancelWorkout(index);
            },
          );
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 90,
              height: 90,
              decoration: BoxDecoration(
                color: const Color(0xFFE8F0EC),
                borderRadius: BorderRadius.circular(25),
              ),
              child: const Icon(
                Icons.fitness_center,
                size: 45,
                color: Color(0xFF1B4332),
              ),
            ),

            const SizedBox(height: 25),

            const Text(
              'У вас пока нет тренировок',
              style: TextStyle(
                fontSize: 21,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            Text(
              'Выберите занятие в расписании,\nчтобы добавить его сюда.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  String formatDate(String date) {
    final parts = date.split('.');
    final day = int.parse(parts[0]);
    final month = int.parse(parts[1]);

    const months = [
      '',
      'января',
      'февраля',
      'марта',
      'апреля',
      'мая',
      'июня',
      'июля',
      'августа',
      'сентября',
      'октября',
      'ноября',
      'декабря',
    ];

    return '$day ${months[month]}';
  }
  final Map<String, String> workout;
  final VoidCallback onCancel;

  const _WorkoutCard({
    required this.workout,
    required this.onCancel,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 7,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFE8F0EC),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  formatDate(workout['date']!),
                  style: const TextStyle(
                    color: Color(0xFF1B4332),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),

              Text(
                workout['time']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Text(
            workout['title']!,
            style: const TextStyle(
              fontSize: 21,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Row(
            children: [
              Icon(
                Icons.person_outline,
                size: 18,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 7),
              Text(
                workout['trainer']!,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 7),

          Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                size: 18,
                color: Colors.grey.shade600,
              ),
              const SizedBox(width: 7),
              Text(
                workout['room']!,
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          SizedBox(
            width: double.infinity,
            height: 45,
            child: OutlinedButton(
              onPressed: onCancel,
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red.shade700,
                side: BorderSide(
                  color: Colors.red.shade200,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: const Text(
                'Отменить запись',
              ),
            ),
          ),
        ],
      ),
    );
  }
}