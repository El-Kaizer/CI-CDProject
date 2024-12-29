# image Python resmi
FROM python:3.11-slim

# Set working directory di dalam container
WORKDIR /app

# Salin file aplikasi Python ke dalam container
COPY 'Method Numeric Calculator.py'/app/

# Jalankan aplikasi Python
CMD ["python", "Method Numeric Calculator.py"]
