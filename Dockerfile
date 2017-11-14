FROM debian:stretch

LABEL maintainer "d.h.bowes@herts.ac.uk"

RUN apt-get update && \  
    apt-get -qy install apache2 php libapache2-mod-php php-mcrypt\
      php-cli octave nodejs dos2unix\
      git python3 build-essential openjdk-8-jre openjdk-8-jdk python3-pip\
      fp-compiler pylint acl sudo  groovy

RUN pylint --reports=no --generate-rcfile > /etc/pylintrc

# Manually set up the apache environment variables
ENV APACHE_RUN_USER www-data
ENV APACHE_RUN_GROUP www-data
ENV APACHE_LOG_DIR /var/log/apache2
ENV APACHE_LOCK_DIR /var/lock/apache2
ENV APACHE_PID_FILE /var/run/apache2.pid


RUN cd /var/www/html && sudo git clone -b  comqdhb https://github.com/comqdhb/jobe.git && apache2ctl start  && cd jobe && sudo ./install

#RUN chmod o-r /var/www/html/jobe && chmod o-r /var/www/html && chmod o-r /home/jobe 


# Expose apache.
EXPOSE 80

COPY rootpassword /root/
RUN cat /root/rootpassword | chpasswd && rm /root/rootpassword

#WORKDIR /home/jobe/  

CMD ["apachectl", "-D", "FOREGROUND"]

#ENTRYPOINT ["apachectl"] 
