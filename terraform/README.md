# r-password
Password manager

1. Выбор технологического стека
Backend: Python + FastAPI (асинхронный, удобный для API)

База данных: PostgreSQL (надёжность, транзакции)

Аутентификация: JWT + refresh tokens

Шифрование: AES‑256‑GCM (для паролей), bcrypt (для паролей пользователей)

Веб‑интерфейс: Vue.js 3 + Vite (лёгкий, реактивный)

Контейнеризация: Docker + docker‑compose

Прокси/SSL: Nginx (обратный прокси, HTTPS)

Логирование: Structlog + файлы + опционально ELK

2. Архитектура сервиса
[Клиент (Browser)] ↔ HTTPS ↔ [Nginx] ↔ HTTP ↔ [FastAPI] ↔ [PostgreSQL]
                                         ↘
                                   [Redis (сессии/токены)]

3: Этапы:
а. Создаём виртуальную машину в облаке
```
terraform init
terraform plan
terraform apply
```
