import 'package:flutter/material.dart';
import 'workout_data.dart';

class BookTrainerScreen extends StatefulWidget {
  final String trainerName;

  const BookTrainerScreen({
    super.key,
    required this.trainerName,
  });

  @override
  State<BookTrainerScreen> createState() => _BookTrainerScreenState();
}

class _BookTrainerScreenState extends State<BookTrainerScreen> {
  DateTime? selectedDate;
  String? selectedTime;

  final List<String> times = [
    '10:00',
    '12:00',
    '15:00',
    '17:00',
    '19:00',
  ];

  Future<void> selectDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 30),
      ),
    );

    if (date != null) {
      setState(() {
        selectedDate = date;
      });
    }
  }

  void confirmBooking() {
    if (selectedDate == null || selectedTime == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Выберите дату и время',
          ),
        ),
      );
      return;
    }

    final date =
        '${selectedDate!.day}.${selectedDate!.month}';

    myWorkouts.add({
      'date': date,
      'time': selectedTime!,
      'title': 'Персональная тренировка',
      'trainer': widget.trainerName,
      'room': 'Тренажёрный зал',
    });

    saveMyWorkouts();

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          'Тренировка успешно забронирована!',
        ),
      ),
    );

    Future.delayed(
      const Duration(milliseconds: 700),
          () {
        if (!mounted) return;
        Navigator.pop(context);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text(
          'Запись к тренеру',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Тренер',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 13,
              ),
            ),

            const SizedBox(height: 5),

            Text(
              widget.trainerName,
              style: const TextStyle(
                fontSize: 23,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Выберите дату',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            SizedBox(
              width: double.infinity,
              height: 52,
              child: OutlinedButton.icon(
                onPressed: selectDate,
                icon: const Icon(
                  Icons.calendar_month,
                ),
                label: Text(
                  selectedDate == null
                      ? 'Выбрать дату'
                      : '${selectedDate!.day}.${selectedDate!.month}.${selectedDate!.year}',
                ),
                style: OutlinedButton.styleFrom(
                  foregroundColor:
                  const Color(0xFF1B4332),
                  side: const BorderSide(
                    color: Color(0xFF1B4332),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 30),

            const Text(
              'Выберите время',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 12),

            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: times.map((time) {
                final isSelected =
                    selectedTime == time;

                return ChoiceChip(
                  label: Text(time),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      selectedTime =
                      selected ? time : null;
                    });
                  },
                  selectedColor:
                  const Color(0xFF1B4332),
                  labelStyle: TextStyle(
                    color: isSelected
                        ? Colors.white
                        : Colors.black,
                    fontWeight: FontWeight.w600,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 35),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                onPressed: confirmBooking,
                style: FilledButton.styleFrom(
                  backgroundColor:
                  const Color(0xFF1B4332),
                  shape: RoundedRectangleBorder(
                    borderRadius:
                    BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Подтвердить запись',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
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