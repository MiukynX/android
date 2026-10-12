import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final birthController = TextEditingController();
  final cardController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool hidePassword = true;
  bool isLoading = false;

  final supabase = Supabase.instance.client;

  @override
  void dispose() {
    nameController.dispose();
    phoneController.dispose();
    emailController.dispose();
    birthController.dispose();
    cardController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    super.dispose();
  }

  Future<void> selectBirthDate() async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime(2005),
      firstDate: DateTime(1940),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      birthController.text =
          '${date.day.toString().padLeft(2, '0')}.'
          '${date.month.toString().padLeft(2, '0')}.'
          '${date.year}';
    }
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Пароли не совпадают'),
        ),
      );
      return;
    }

    setState(() {
      isLoading = true;
    });

    try {
      // 1. Создаём пользователя в Supabase Auth
      final authResponse = await supabase.auth.signUp(
  email: emailController.text.trim(),
  password: passwordController.text,
  data: {
    'full_name': nameController.text.trim(),
    'phone': phoneController.text.trim(),
    'birth_date': _convertBirthDate(),
    'card_number': cardController.text.trim(),
  },
      );

      final user = authResponse.user;

      if (user == null) {
        throw Exception('Не удалось создать пользователя');
      }

      // 2. Создаём профиль в PostgreSQL
     

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Регистрация прошла успешно!'),
        ),
      );

      await Future.delayed(
        const Duration(milliseconds: 800),
      );

      if (!mounted) return;

      Navigator.pop(context);
    } on AuthException catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(error.message),
        ),
      );
    } catch (error) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Ошибка регистрации: $error',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  String? _convertBirthDate() {
    if (birthController.text.trim().isEmpty) {
      return null;
    }

    final parts = birthController.text.split('.');

    if (parts.length != 3) {
      return null;
    }

    return '${parts[2]}-${parts[1]}-${parts[0]}';
  }

  Widget buildField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    bool obscureText = false,
    bool readOnly = false,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        obscureText: obscureText,
        readOnly: readOnly,
        onTap: onTap,
        validator: (value) {
          if (value == null || value.trim().isEmpty) {
            return 'Заполните поле';
          }

          if (obscureText && value.length < 6) {
            return 'Минимум 6 символов';
          }

          return null;
        },
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
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text('Регистрация'),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F6),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Создать аккаунт',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                'Заполните данные для регистрации в фитнес-клубе',
                style: TextStyle(
                  color: Colors.grey.shade600,
                ),
              ),

              const SizedBox(height: 30),

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
                icon: Icons.calendar_today_outlined,
                readOnly: true,
                onTap: selectBirthDate,
              ),

              buildField(
                label: 'Номер клубной карты',
                controller: cardController,
                icon: Icons.credit_card_outlined,
                keyboardType: TextInputType.number,
              ),

              buildField(
                label: 'Пароль',
                controller: passwordController,
                icon: Icons.lock_outline,
                obscureText: hidePassword,
              ),

              buildField(
                label: 'Подтвердите пароль',
                controller: confirmController,
                icon: Icons.lock_reset_outlined,
                obscureText: hidePassword,
              ),

              Row(
                children: [
                  Checkbox(
                    value: !hidePassword,
                    onChanged: (value) {
                      setState(() {
                        hidePassword = !(value ?? false);
                      });
                    },
                    activeColor: const Color(0xFF1B4332),
                  ),
                  const Text('Показать пароли'),
                ],
              ),

              const SizedBox(height: 20),

              SizedBox(
                width: double.infinity,
                height: 54,
                child: FilledButton(
                  onPressed: isLoading ? null : register,
                  style: FilledButton.styleFrom(
                    backgroundColor: const Color(0xFF1B4332),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  child: isLoading
                      ? const SizedBox(
                          width: 24,
                          height: 24,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                      : const Text(
                          'Зарегистрироваться',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                ),
              ),

              const SizedBox(height: 20),

              Center(
                child: TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    'Уже есть аккаунт? Войти',
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