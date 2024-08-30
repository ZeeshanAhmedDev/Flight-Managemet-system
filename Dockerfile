# Use a base image with necessary tools
FROM debian:bullseye-slim AS build

# Install required packages
RUN apt-get update && apt-get install -y \
    git \
    wget \
    unzip \
    xz-utils \
    curl \
    libglu1-mesa

# Install Flutter (specify the stable channel with Dart SDK 3.x)
RUN git clone https://github.com/flutter/flutter.git -b stable --depth 1 /flutter
ENV PATH="/flutter/bin:/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Set the directory as safe for Git
RUN git config --global --add safe.directory /flutter

# Create a non-root user to avoid root warnings and fix ownership
RUN useradd -ms /bin/bash flutteruser \
    && chown -R flutteruser:flutteruser /flutter

# Switch to the non-root user
USER flutteruser
WORKDIR /app

# Copy the application code
COPY --chown=flutteruser:flutteruser . .

# Adjust file permissions before running flutter pub get
RUN chown -R flutteruser:flutteruser /app

# Get the Flutter dependencies
RUN flutter pub get

# Build the Flutter web application
RUN flutter build web --release

# Use a lightweight web server to serve the Flutter web app
FROM nginx:alpine
COPY --from=build /app/build/web /usr/share/nginx/html

# Expose port 80 to serve the application
EXPOSE 80

# Start Nginx
CMD ["nginx", "-g", "daemon off;"]