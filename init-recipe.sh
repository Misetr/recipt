#!/usr/bin/env bash
set -e

# 1. Инициализируем git
echo "Инициализируем git-репозиторий..."
git init

# 2. Фронтенд: React SPA
echo "Создаём фронтенд (React SPA)..."
npx create-react-app client
cd client

echo "Устанавливаем зависимости фронтенда..."
npm install lodash chart.js axios @mui/material @emotion/react @emotion/styled

echo "Создаём структуры папок..."
mkdir -p src/components src/hooks src/utils

echo "Пишем конфиги ESLint и Prettier..."
cat > .eslintrc.js << 'EOC'
module.exports = {
  extends: ['react-app', 'plugin:prettier/recommended'],
  rules: { /* ваши правила */ },
};
EOC

cat > .prettierrc << 'EOP'
{
  "singleQuote": true,
  "trailingComma": "es5"
}
EOP

cd ..

# 3. Бэкенд: Express API
echo "Создаём бэкенд (Express API)..."
mkdir -p server
cd server

echo "Инициализируем npm и устанавливаем зависимости..."
npm init -y
npm install express mongoose cors dotenv
npm install --save-dev jest supertest nodemon

echo "Создаём структуры папок..."
mkdir -p controllers models routes tests

echo "Пишем шаблоны app.js и index.js..."
cat > app.js << 'EOT'
require('dotenv').config();
const express = require('express');
const mongoose = require('mongoose');
const cors = require('cors');
const app = express();

app.use(cors());
app.use(express.json());

// TODO: добавить модели, контроллеры, роуты

module.exports = app;
EOT

cat > index.js << 'EOT'
const app = require('./app');
const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(\`Server running on port \${PORT}\`));
EOT

cd ..

echo "✔ Структура проекта 'recipt' готова!"
