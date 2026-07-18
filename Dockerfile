# ── Quiz Bot — Dockerfile for Northflank ──────────────────────────────
FROM python:3.11-slim

# Prevents Python buffering stdout — keeps logs live in Northflank's log viewer
ENV PYTHONUNBUFFERED=1

WORKDIR /app

# Install deps first (better layer caching)
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the rest of the bot's source
COPY . .

# Default SQLite path if no volume is mounted (ephemeral — see guide for persistence)
ENV SQLITE_PATH=/data/quiz_bot.db

# No inbound port needed — this is a long-running polling worker, not a web server
CMD ["python", "main.py"]
