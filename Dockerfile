FROM wordpress 
#COPY ./uploads.ini /usr/local/etc/php/conf.d/uploads.ini 
RUN apt-get update 
RUN apt-get upgrade -y 
RUN apt-get install -y --no-install-recommends supervisor && apt-get install openssh-server -y && echo "root:Docker!" | chpasswd 
RUN mkdir -p /var/log/supervisor /run/sshd 

#Copying the required configuration for SSH
COPY sshd_config /etc/ssh/ 

#Copying our custom supervisord.conf file in the folder where Supervisor reads custom config files
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf 
EXPOSE 80 2222

#Our entrypoint would be just run supervisord command, this will take the supervisord.conf file and execute the commands contained there
ENTRYPOINT ["/usr/bin/supervisord"]
