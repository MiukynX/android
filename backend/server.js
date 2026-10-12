
require('dotenv').config();

const express = require('express');
const cors = require('cors');
const OpenAI = require('openai');

const app = express();

app.use(cors());
app.use(express.json());

const client = new OpenAI({
  apiKey: process.env.OPENAI_API_KEY,
});

app.get('/', (req, res) => {
  res.json({
    message: 'Fitness AI backend работает!',
  });
});

app.post('/chat', async (req, res) => {
  try {
    const message = String(req.body.message || '').trim();

    if (!message) {
      return res.status(400).json({
        error: 'Напиши сообщение',
      });
    }

    const response = await client.responses.create({
      model: 'gpt-4.1-mini',
      instructions:
        'Ты Fitness AI Assistant. Отвечай на русском языке. ' +
        'Помогай пользователю с тренировками, питанием и фитнесом. ' +
        'Отвечай дружелюбно и понятно. Не ставь медицинские диагнозы.',
      input: message,
    });

    res.json({
      reply: response.output_text,
    });
  } catch (error) {
    console.error(
      'Ошибка AI:',
      error.status || error.message
    );

    res.status(500).json({
      error: 'Не удалось получить ответ AI. Проверь API-ключ и баланс.',
    });
  }
});

const PORT = 3000;

app.listen(PORT, () => {
  console.log(
    `Fitness AI запущен: http://localhost:${PORT}`
  );
});
