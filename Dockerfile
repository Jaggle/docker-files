FROM centos

ADD init.sh /

RUN echo "==> Install dependencies..." && \
    yum -y install epel-release && \
    rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm && \
    yum -y install php70w && \
    yum -y install nginx && \
    yum -y install php70w-gd && \
    yum -y install php70w-fpm && \
    yum -y install php70w-mbstring && \
    yum -y install php70w-mysqlnd && \
    yum -y install openssh-server && \
    echo "==> Clean up..." && \
    yum clean all && \
    rm -rf /var/cache/yum && \
    echo "==> Setup..." && \
    echo '123456' | passwd root --stdin && \
    chmod 755 /init.sh && \
    ssh-keygen -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -t dsa -f /etc/ssh/ssh_host_dsa_key && \
    sed -i 's/^#*Host.*$//g' /etc/ssh/sshd_config && \
    echo 'HostKey /etc/ssh/ssh_host_rsa_key' >> /etc/ssh/sshd_config && \
    echo 'HostKey /etc/ssh/ssh_host_dsa_key' >> /etc/ssh/sshd_config

ADD nginx_default.conf /etc/nginx/conf.d/default.conf
ADD nginx.conf /etc/nginx/nginx.conf

ENTRYPOINT /init.sh && /usr/sbin/sshd -D
