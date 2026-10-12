import 'package:flutter/material.dart';
import 'schedule_screen.dart';
import 'my_workouts_screen.dart';
import 'news_screen.dart';
import 'profile_screen.dart';
import 'achievements_screen.dart';
import 'settings_screen.dart';
import 'trainers_screen.dart';
import 'clubs_screen.dart';
import 'personal_account_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  final PageController newsController = PageController();

  final List<Map<String, String>> news = [
    {
      'title': 'Новая групповая тренировка',
      'subtitle': 'Попробуйте новую программу тренировок',
    },
    {
      'title': 'Скидка на абонементы',
      'subtitle': 'Специальное предложение для новых клиентов',
    },
    {
      'title': 'Тренируйся вместе с нами',
      'subtitle': 'Выбирайте занятия и записывайтесь онлайн',
    },
  ];

  @override
  void dispose() {
    newsController.dispose();
    super.dispose();
  }

  void showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
  void _openMoreMenu() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25),
        ),
      ),
      builder: (context) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 15, 20, 25),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [

                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey.shade300,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),

                const SizedBox(height: 20),

                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    'Еще',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                ListTile(
                  leading: const Icon(
                    Icons.fitness_center,
                    color: Color(0xFF1B4332),
                  ),
                  title: const Text(
                    'Мои тренировки',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const MyWorkoutsScreen(),
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.emoji_events_outlined),
                  title: const Text('Мои достижения'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const AchievementsScreen(),
                      ),
                    );
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text('Личный кабинет'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const PersonalAccountScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.people_outline,
                    color: Color(0xFF1B4332),
                  ),
                  title: const Text('Инструкторы'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const TrainersScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.business_outlined,
                    color: Color(0xFF1B4332),
                  ),
                  title: const Text('Клубы'),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ClubsScreen(),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.notifications_none),
                  title: const Text('Уведомления'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);
                    showMessage('Уведомления добавим позже');
                  },
                ),

                ListTile(
                  leading: const Icon(Icons.settings_outlined),
                  title: const Text('Настройки'),
                  trailing: const Icon(Icons.chevron_right),
                  onTap: () {
                    Navigator.pop(context);

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SettingsScreen(),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),

      // =========================
      // ОСНОВНОЙ ЭКРАН
      // =========================
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              // =========================
              // ВЕРХНЯЯ ПАНЕЛЬ
              // =========================
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 18, 20, 10),
                child: Row(
                  children: [

                    // Карта клуба / штрихкод
                    GestureDetector(
                      onTap: () {
                        showMessage('Карта клуба');
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.qr_code_2,
                          size: 28,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                    ),

                    const Expanded(
                      child: Column(
                        children: [
                          Text(
                            'FITNESS CLUB',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                          ),
                          SizedBox(height: 2),
                          Text(
                            'Ваш фитнес-пространство',
                            style: TextStyle(
                              fontSize: 11,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Телефон клуба
                    GestureDetector(
                      onTap: () {
                        showMessage('Телефон клуба');
                      },
                      child: Container(
                        width: 48,
                        height: 48,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                        ),
                        child: const Icon(
                          Icons.phone_outlined,
                          color: Color(0xFF1B4332),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // =========================
              // ПРИВЕТСТВИЕ
              // =========================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Добрый день! 👋',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Готовы к новой тренировке?',
                      style: TextStyle(
                        fontSize: 15,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 22),

              // =========================
              // НОВОСТИ
              // =========================
              SizedBox(
                height: 190,
                child: PageView.builder(
                  controller: newsController,
                  itemCount: news.length,
                  itemBuilder: (context, index) {
                    final item = news[index];

                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 20),
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(24),
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            Color(0xFF1B4332),
                            Color(0xFF081C15),
                          ],
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.fitness_center,
                            color: Colors.white,
                            size: 32,
                          ),
                          const SizedBox(height: 14),
                          Text(
                            item['title']!,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 21,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Text(
                            item['subtitle']!,
                            style: TextStyle(
                              color: Colors.white.withOpacity(0.75),
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),

              const SizedBox(height: 25),

              // =========================
              // БЫСТРЫЕ ДЕЙСТВИЯ
              // =========================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  'Быстрые действия',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 14),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [

                    Expanded(
                      child: _ActionCard(
                        icon: Icons.calendar_month_outlined,
                        title: 'Расписание',
                        onTap: () {
                          showMessage('Открываем расписание');
                        },
                      ),
                    ),

                    const SizedBox(width: 12),

                    Expanded(
                      child: _ActionCard(
                        icon: Icons.person_outline,
                        title: 'Личный кабинет',
                        onTap: () {
                          showMessage('Открываем личный кабинет');
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  width: double.infinity,
                  height: 58,
                  child: FilledButton.icon(
                    onPressed: () {
                      showMessage('Раздел членства клуба');
                    },
                    icon: const Icon(Icons.card_membership_outlined),
                    label: const Text(
                      'Стать членом клуба',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: FilledButton.styleFrom(
                      backgroundColor: const Color(0xFF1B4332),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 28),

              // =========================
              // БЛИЖАЙШИЕ ТРЕНИРОВКИ
              // =========================
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Ближайшие тренировки',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Все',
                      style: TextStyle(
                        color: Color(0xFF1B4332),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 14),

              _WorkoutCard(
                time: '09:00',
                title: 'Йога',
                trainer: 'Анна',
              ),

              _WorkoutCard(
                time: '12:00',
                title: 'Бокс',
                trainer: 'Абылай Барлык',
              ),

              _WorkoutCard(
                time: '18:00',
                title: 'Растяжка',
                trainer: 'Мария',
              ),
            ],
          ),
        ),
      ),

      // =========================
      // НИЖНЕЕ МЕНЮ
      // =========================
      bottomNavigationBar: NavigationBar(
        selectedIndex: currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            currentIndex = index;
          });

          if (index == 1) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ScheduleScreen(),
              ),
            );
          } else if (index == 2) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewsScreen(),
              ),
            );
          } else if (index == 3) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreen(),
              ),
            );
          } else if (index == 4) {
            _openMoreMenu();
          } else if (index != 0) {
            showMessage(
              'Раздел "${_menuName(index)}" добавим следующим этапом',
            );
          }
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home_outlined),
            selectedIcon: Icon(Icons.home),
            label: 'Главная',
          ),
          NavigationDestination(
            icon: Icon(Icons.calendar_month_outlined),
            selectedIcon: Icon(Icons.calendar_month),
            label: 'Расписание',
          ),
          NavigationDestination(
            icon: Icon(Icons.newspaper_outlined),
            selectedIcon: Icon(Icons.newspaper),
            label: 'Новости',
          ),
          NavigationDestination(
            icon: Icon(Icons.person_outline),
            selectedIcon: Icon(Icons.person),
            label: 'Профиль',
          ),
          NavigationDestination(
            icon: Icon(Icons.more_horiz),
            selectedIcon: Icon(Icons.more_horiz),
            label: 'Еще',
          ),
        ],
      ),
    );
  }

  String _menuName(int index) {
    switch (index) {
      case 1:
        return 'Расписание';
      case 2:
        return 'Новости';
      case 3:
        return 'Профиль';
      case 4:
        return 'Еще';
      default:
        return 'Главная';
    }
  }
}

// ======================================================
// КАРТОЧКА БЫСТРОГО ДЕЙСТВИЯ
// ======================================================

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final VoidCallback onTap;

  const _ActionCard({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 105,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: const Color(0xFF1B4332),
              size: 30,
            ),
            const SizedBox(height: 10),
            Text(
              title,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ======================================================
// КАРТОЧКА ТРЕНИРОВКИ
// ======================================================

class _WorkoutCard extends StatelessWidget {
  final String time;
  final String title;
  final String trainer;

  const _WorkoutCard({
    required this.time,
    required this.title,
    required this.trainer,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
      ),
      child: Row(
        children: [
          Container(
            width: 65,
            height: 55,
            decoration: BoxDecoration(
              color: const Color(0xFFE8F0EC),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Center(
              child: Text(
                time,
                style: const TextStyle(
                  color: Color(0xFF1B4332),
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ),
          ),

          const SizedBox(width: 15),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'Тренер: $trainer',
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
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
    );
  }
}