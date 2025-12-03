# Base image: nginx + php-fpm
FROM richarvey/nginx-php-fpm:latest AS base

# Workdir matches webroot layout used by this image
WORKDIR /var/www/html

# Install Composer
RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
    && php composer-setup.php --install-dir=/usr/local/bin --filename=composer \
    && php -r "unlink('composer-setup.php');"

# Keep app directory as a volume (useful for dev)
VOLUME /var/www/html

# ----------------- DEV STAGE -----------------
FROM base AS dev
ENV APP_ENV=dev

# You could add dev-only tools here (xdebug, etc.) later

# ----------------- PROD STAGE -----------------
FROM base AS prod
ARG APP_ENV=prod
ENV APP_ENV=${APP_ENV}

# In a real prod image you’d COPY the code in
# For now we leave this minimal so you can use volumes in dev
