FROM php:7.4-fpm-alpine

ADD https://github.com/mlocati/docker-php-extension-installer/releases/latest/download/install-php-extensions /usr/local/bin/

RUN chmod +x /usr/local/bin/install-php-extensions && sync && \
    install-php-extensions exif gd mysqli pdo_mysql opcache bcmath pdo shmop sockets sysvmsg sysvshm sysvsem xsl zip pcntl gettext calendar FFI

#RUN apk --update-cache add ca-certificates &&  echo "https://dl.bintray.com/php-alpine/v3.11/php-7.4" >> /etc/apk/repositories
#RUN apk add --update-cache \
#    php-bz2 \
#    php-json \
#    php-calendar \
#    php-exif \
#    php-gettext \
#    php-mysqli \
#    php-pcntl \
#    php-shmop \
#    php-sockets \
#    php-sysvmsg \
#    php-sysvsem \
#    php-xsl \
#    php-zip \
#    php-sysvshm 
    
# Install packages and remove default server definition
#RUN docker-php-ext-install -j5 pdo pdo_mysql opcache bcmath 
#RUN apk add --no-cache libpng libpng-dev && docker-php-ext-install gd && apk del libpng-dev

#RUN apk add --update  \
#  --repository http://dl-cdn.alpinelinux.org/alpine/edge/main \
#  --repository http://dl-cdn.alpinelinux.org/alpine/edge/community \
#        libfreetype6-dev \
#        libjpeg62-turbo-dev \
#        libpng-dev \
#    && docker-php-ext-configure gd --with-freetype --with-jpeg \
#    && docker-php-ext-install -j$(nproc) gd

#RUN mkdir /var/www/

#WORKDIR /var/www/

# Expose port 9000 and start php-fpm server
EXPOSE 9000
CMD ["php-fpm"]
 


