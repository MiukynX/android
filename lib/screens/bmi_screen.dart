import 'package:flutter/material.dart';

class BmiScreen extends StatefulWidget {
  const BmiScreen({super.key});

  @override
  State<BmiScreen> createState() => _BmiScreenState();
}

class _BmiScreenState extends State<BmiScreen> {
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final targetWeightController = TextEditingController();

  double? bmi;
  String category = '';

  void calculateBmi() {
    final height = double.tryParse(heightController.text);
    final weight = double.tryParse(weightController.text);

    if (height == null || weight == null || height <= 0 || weight <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Введите корректный рост и вес'),
        ),
      );
      return;
    }

    final heightInMeters = height / 100;
    final result = weight / (heightInMeters * heightInMeters);

    String resultCategory;

    if (result < 18.5) {
      resultCategory = 'Недостаточный вес';
    } else if (result < 25) {
      resultCategory = 'Нормальный вес';
    } else if (result < 30) {
      resultCategory = 'Избыточный вес';
    } else {
      resultCategory = 'Ожирение';
    }

    setState(() {
      bmi = result;
      category = resultCategory;
    });
  }

  @override
  void dispose() {
    heightController.dispose();
    weightController.dispose();
    targetWeightController.dispose();
    super.dispose();
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
          'Мой ИМТ',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Рассчитайте свой ИМТ',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 8),

            Text(
              'Введите свои параметры, чтобы узнать индекс массы тела.',
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 14,
              ),
            ),

            const SizedBox(height: 25),

            _InputField(
              controller: heightController,
              label: 'Рост',
              hint: 'Например, 175',
              suffix: 'см',
              icon: Icons.height,
            ),

            const SizedBox(height: 15),

            _InputField(
              controller: weightController,
              label: 'Текущий вес',
              hint: 'Например, 70',
              suffix: 'кг',
              icon: Icons.monitor_weight_outlined,
            ),

            const SizedBox(height: 15),

            _InputField(
              controller: targetWeightController,
              label: 'Желаемый вес',
              hint: 'Например, 65',
              suffix: 'кг',
              icon: Icons.flag_outlined,
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton.icon(
                onPressed: calculateBmi,
                icon: const Icon(Icons.calculate_outlined),
                label: const Text(
                  'Рассчитать ИМТ',
                  style: TextStyle(
                    fontSize: 16,
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

            if (bmi != null) ...[
              const SizedBox(height: 30),

              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(22),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(22),
                ),
                child: Column(
                  children: [
                    const Text(
                      'Ваш ИМТ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 10),

                    Text(
                      bmi!.toStringAsFixed(1),
                      style: const TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1B4332),
                      ),
                    ),

                    const SizedBox(height: 5),

                    Text(
                      category,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                    const SizedBox(height: 20),

                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0EC),
                        borderRadius: BorderRadius.circular(14),
                      ),
                      child: const Text(
                        'ИМТ является ориентировочным показателем. '
                            'Для точной оценки состояния здоровья обратитесь '
                            'к специалисту.',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Color(0xFF1B4332),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              if (targetWeightController.text.isNotEmpty)
                _buildTargetProgress(),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildTargetProgress() {
    final weight = double.tryParse(weightController.text);
    final target = double.tryParse(targetWeightController.text);

    if (weight == null || target == null || weight <= 0 || target <= 0) {
      return const SizedBox.shrink();
    }

    final difference = (weight - target).abs();

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Цель',
            style: TextStyle(
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 10),

          Text(
            'До желаемого веса: ${difference.toStringAsFixed(1)} кг',
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
            ),
          ),

          const SizedBox(height: 15),

          const LinearProgressIndicator(
            value: 0.4,
            minHeight: 9,
            backgroundColor: Color(0xFFE8F0EC),
            color: Color(0xFF1B4332),
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final String suffix;
  final IconData icon;

  const _InputField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.suffix,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        suffixText: suffix,
        prefixIcon: Icon(
          icon,
          color: const Color(0xFF1B4332),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}