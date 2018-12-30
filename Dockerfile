FROM centos/systemd:1
MAINTAINER adam@chabin.eu
COPY nginx/nginx.repo /etc/yum.repos.d/nginx.repo
RUN yum install -y https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm
RUN yum install -y mariadb php-fpm mc php-xmlrpc php-cli php-mysql php-mbstring php-soap php-bcmath php-gd php-intl php-common php-pdo php-xml nginx
RUN echo "short_open_tag = On" >> /etc/php.ini; echo "memory_limit = 384M" >> /etc/php.ini; echo "date.timezone = Europe/Warsaw" >> /etc/php.ini; echo "expose_php = Off" >> /etc/php.ini
RUN systemctl enable nginx.service; systemctl enable php-fpm.service
COPY nginx/bw.conf /etc/nginx/conf.d/bw.conf
COPY mysql/* /tmp/

VOLUME ["/www"]
VOLUME ["/var/log/nginx/"]

EXPOSE 80
CMD ["/usr/sbin/init"]
