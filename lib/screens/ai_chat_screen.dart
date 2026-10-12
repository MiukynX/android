
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AiChatScreen extends StatefulWidget {
  const AiChatScreen({super.key});

  @override
  State<AiChatScreen> createState() => _AiChatScreenState();
}

class _AiChatScreenState extends State<AiChatScreen> {
  final TextEditingController messageController =
  TextEditingController();
  final ScrollController scrollController = ScrollController();

  final List<Map<String, String>> messages = [
    {
      'sender': 'ai',
      'text':
      'Привет! 👋 Я твой AI Fitness Assistant. '
          'Могу помочь с тренировками, питанием и прогрессом.',
    },
  ];

  bool isLoading = false;

  Future<void> sendMessage() async {
    final text = messageController.text.trim();

    if (text.isEmpty || isLoading) return;

    setState(() {
      messages.add({
        'sender': 'user',
        'text': text,
      });
      isLoading = true;
    });

    messageController.clear();
    scrollToBottom();

    try {
      final response = await http
          .post(
        Uri.parse('http://localhost:3000/chat'),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'message': text,
        }),
      )
          .timeout(const Duration(seconds: 60));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200) {
        if (mounted) {
          setState(() {
            messages.add({
              'sender': 'ai',
              'text': data['reply']?.toString() ??
                  'ИИ вернул пустой ответ.',
            });
          });
        }
      } else {
        throw Exception(
          data['error']?.toString() ??
              'Ошибка сервера: ${response.statusCode}',
        );
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          messages.add({
            'sender': 'ai',
            'text':
            'Не удалось получить ответ 😕\n'
                'Проверь, запущен ли сервер и доступен ли API.\n'
                'Подробности: $e',
          });
        });
      }
    } finally {
      if (mounted) {
        setState(() {
          isLoading = false;
        });
        scrollToBottom();
      }
    }
  }

  void scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.animateTo(
          scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    messageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7F6),
      appBar: AppBar(
        title: const Text(
          'AI Fitness Assistant',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFFF5F7F6),
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: scrollController,
              padding: const EdgeInsets.all(16),
              itemCount: messages.length + (isLoading ? 1 : 0),
              itemBuilder: (context, index) {
                if (isLoading && index == messages.length) {
                  return const Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.all(12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text('ИИ думает...'),
                        ],
                      ),
                    ),
                  );
                }

                final message = messages[index];
                final isUser = message['sender'] == 'user';

                return Align(
                  alignment: isUser
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    constraints: const BoxConstraints(
                      maxWidth: 320,
                    ),
                    margin: const EdgeInsets.only(bottom: 12),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: isUser
                          ? const Color(0xFF1B4332)
                          : Colors.white,
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: Text(
                      message['text']!,
                      style: TextStyle(
                        color: isUser
                            ? Colors.white
                            : Colors.black87,
                        fontSize: 15,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
            color: Colors.white,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: messageController,
                    textInputAction: TextInputAction.send,
                    onSubmitted: (_) => sendMessage(),
                    decoration: InputDecoration(
                      hintText: 'Напишите вопрос...',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(16),
                        borderSide: BorderSide.none,
                      ),
                      filled: true,
                      fillColor: const Color(0xFFF5F7F6),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFF1B4332),
                  child: IconButton(
                    onPressed: isLoading ? null : sendMessage,
                    icon: const Icon(
                      Icons.send,
                      color: Colors.white,
                    ),
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
