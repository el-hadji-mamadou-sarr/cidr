from python:3.11-slim

RUN useradd -m appuser
USER appuser

WORKDIR /app
COPY . .
EXPOSE 8000

CMD ["python", "app.py"]