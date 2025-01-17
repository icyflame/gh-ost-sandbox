FROM mysql:5.7-debian

# https://dev.mysql.com/doc/mysql-apt-repo-quick-guide/en/#repo-qg-apt-repo-manual-setup
RUN gpg --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys A8D3785C && \
    rm /etc/apt/keyrings/mysql.gpg && \
    gpg --output /etc/apt/keyrings/mysql.gpg --export A8D3785C

RUN apt-get update && \
    apt-get install -y --no-install-recommends --no-install-suggests \
    vim netcat-openbsd less locales-all procps

ADD https://github.com/github/gh-ost/releases/download/v1.1.6/gh-ost-binary-linux-amd64-20231207144046.tar.gz /tmp/gh-ost.tar.gz
RUN mkdir -p /tmp/gh-ost && \
    tar zxvf /tmp/gh-ost.tar.gz -C /tmp/gh-ost && \
    mv /tmp/gh-ost/gh-ost /usr/local/bin/

ADD https://github.com/ichirin2501/mysql_random_data_load/releases/download/patch-01/mysql_random_data_load_patch_01_linux_amd64.tar.gz /tmp/mysql_random_data_load.tar.gz
RUN mkdir -p /tmp/mysql_random_data_load && \
    tar zxvf /tmp/mysql_random_data_load.tar.gz -C /tmp/mysql_random_data_load && \
    mv /tmp/mysql_random_data_load/mysql_random_data_load /usr/local/bin

HEALTHCHECK --interval=5s --timeout=3s CMD test -e /tmp/OK
