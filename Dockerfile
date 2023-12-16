# Use CentOS as the base image
FROM centos:latest

# Install Apache HTTP Server
RUN cd /etc/yum.repos.d/
RUN sed -i 's/mirrorlist/#mirrorlist/g' /etc/yum.repos.d/CentOS-*
RUN sed -i 's|#baseurl=http://mirror.centos.org|baseurl=http://vault.centos.org|g' /etc/yum.repos.d/CentOS-*

RUN yum -y update && \
    yum -y install httpd && \
    yum clean all

# Copy your HTML file into the container
COPY ./index.html /var/www/html/

# Optionally, you can also copy additional assets like CSS, JS, etc.
# COPY ./assets /var/www/html/assets

# Expose port 80 for Apache
EXPOSE 80

# Start Apache in the foreground
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
