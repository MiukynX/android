import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();
  final cardController = TextEditingController();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();

    nameController.text = prefs.getString('name') ?? '';
    phoneController.text = prefs.getString('phone') ?? '';
    emailController.text = prefs.getString('email') ?? '';
    birthController.text = prefs.getString('birthDate') ?? '';
    cardController.text = prefs.getString('cardNumber') ?? '';

    setState(() {});
  }

  Future<void> saveProfile() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(
      'name',
      nameController.text.trim(),
    );

    await prefs.setString(
      'phone',
      phoneController.text.trim(),
    );

    await prefs.setString(
      'email',
      emailController.text.trim(),
    );

    await prefs.setString(
      'birthDate',
      birthController.text.trim(),
    );

    await prefs.setString(
      'cardNumber',
      cardController.text.trim(),
    );

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Профиль успешно обновлён'),
      ),
    );

    await Future.delayed(
      const Duration(milliseconds: 700),
    );

    if (!mounted) return;

    Navigator.pop(context, true);
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextField(
        controller: controller,
        keyboardType: keyboardType,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            icon,
            color: const Color(0xFF1B4332),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(14),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    birthController.dispose();
    cardController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('Редактирование профиля'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            buildField(
              label: 'Имя и фамилия',
              controller: nameController,
              icon: Icons.person_outline,
            ),

            buildField(
              label: 'Номер телефона',
              controller: phoneController,
              icon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
            ),

            buildField(
              label: 'Email',
              controller: emailController,
              icon: Icons.email_outlined,
              keyboardType: TextInputType.emailAddress,
            ),

            buildField(
              label: 'Дата рождения',
              controller: birthController,
              icon: Icons.cake_outlined,
            ),

            buildField(
              label: 'Номер клубной карты',
              controller: cardController,
              icon: Icons.credit_card_outlined,
              keyboardType: TextInputType.number,
            ),

            const SizedBox(height: 10),

            SizedBox(
              width: double.infinity,
              height: 54,
              child: FilledButton(
                onPressed: saveProfile,
                style: FilledButton.styleFrom(
                  backgroundColor: const Color(0xFF1B4332),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                child: const Text(
                  'Сохранить изменения',
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