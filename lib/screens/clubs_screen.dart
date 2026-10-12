import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class ClubsScreen extends StatelessWidget {
  const ClubsScreen({super.key});

  final List<Map<String, String>> clubs = const [
    {
      'name': 'Fitness Club Aktobe',
      'city': 'Актобе',
      'address': 'проспект Абулхаир-хана, 1',
      'phone': '+7 700 000 00 00',
      'hours': '09:00 – 22:00',
    },
    {
      'name': 'Fitness Club Almaty',
      'city': 'Алматы',
      'address': 'ул. Абая, 50',
      'phone': '+7 700 111 11 11',
      'hours': '08:00 – 23:00',
    },
    {
      'name': 'Fitness Club Astana',
      'city': 'Астана',
      'address': 'ул. Кенесары, 20',
      'phone': '+7 700 222 22 22',
      'hours': '08:00 – 23:00',
    },
  ];

  Future<void> callClub(String phone) async {
    final uri = Uri(
      scheme: 'tel',
      path: phone,
    );

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text(
          'Клубы',
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
        itemCount: clubs.length,
        itemBuilder: (context, index) {
          final club = clubs[index];

          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 55,
                      height: 55,
                      decoration: BoxDecoration(
                        color: const Color(0xFFE8F0EC),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: const Icon(
                        Icons.fitness_center,
                        color: Color(0xFF1B4332),
                        size: 28,
                      ),
                    ),

                    const SizedBox(width: 14),

                    Expanded(
                      child: Column(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Text(
                            club['name']!,
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            club['city']!,
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 18),

                _ClubInfo(
                  icon: Icons.location_on_outlined,
                  text: club['address']!,
                ),

                const SizedBox(height: 10),

                _ClubInfo(
                  icon: Icons.access_time_outlined,
                  text: club['hours']!,
                ),

                const SizedBox(height: 10),

                _ClubInfo(
                  icon: Icons.phone_outlined,
                  text: club['phone']!,
                ),

                const SizedBox(height: 18),

                SizedBox(
                  width: double.infinity,
                  height: 48,
                  child: OutlinedButton.icon(
                    onPressed: () {
                      callClub(club['phone']!);
                    },
                    icon: const Icon(
                      Icons.phone,
                      size: 19,
                    ),
                    label: const Text(
                      'Позвонить в клуб',
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
              ],
            ),
          );
        },
      ),
    );
  }
}

class _ClubInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const _ClubInfo({
    required this.icon,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 20,
          color: const Color(0xFF1B4332),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}