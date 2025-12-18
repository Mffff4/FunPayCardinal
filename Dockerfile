# Use an official Python runtime as a parent image
FROM python:3.11-slim

# Set the working directory in the container
WORKDIR /usr/src/app

# Create a non-root user
RUN useradd -m cardinal

# Install gosu to safely drop privileges
RUN apt-get update && apt-get install -y --no-install-recommends gosu && rm -rf /var/lib/apt/lists/*

# Install dependencies
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copy the entrypoint script and make it executable
COPY entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

# Copy the rest of the application
COPY . .

# Ensure the app directory is owned by cardinal for files copied into the image
RUN chown -R cardinal:cardinal /usr/src/app

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]

# CMD is now just the command to run, the entrypoint will handle user switching
CMD ["python", "main.py"]

