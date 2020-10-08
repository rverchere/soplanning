FROM php:7.4-apache as builder

LABEL app="SO Planning"
LABEL maintener="Rémi VERCHERE <remi@verchere.fr>"
LABEL major_version="1"
LABEL minor_version="47"

# update debian packages
RUN apt update

# Install PDO MySQL driver
RUN docker-php-ext-install mysql mysqli pdo pdo_mysql

# Install LDAP driver
RUN apt-get install -y libldap-dev
RUN docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/
RUN docker-php-ext-install ldap

# Enable Apache mod_rewrite
RUN a2enmod rewrite

RUN apt clean

FROM builder

COPY . /var/www/html/