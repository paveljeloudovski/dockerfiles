FROM centos:7

# ##############################################################################
# Setup base packages
RUN yum update -y;\
    yum install -y unzip bash openssh-server java-1.8.0-openjdk-headless openssl ;\
    mkdir -p /root/.ssh ;\
    mkdir -p /etc/ssh

# Setup SSH
RUN chown root:root -R /root; \
    chmod go-rwX -R /root/.ssh


# Setup Cron
RUN yum install -y cronie ;\
    mkdir -p /etc/cron.d/

# Setup docker-in-sidekick (docker containers run along-side the agent)
RUN yum install -y yum-utils device-mapper-persistent-data lvm2 ;\
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo ;\
    yum makecache fast ;\
    yum install -y docker-ce

RUN export PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/android-sdk/tools/bin/
RUN export JAVA_HOME=/usr/lib/jvm/jre-openjdk

# ##############################################################################
# Setup Dev Tools
RUN yum install -y epel-release

# Install centos development tools group
RUN yum group install -y "Development Tools"

# ========== General Tools
RUN yum install -y git xz curl bash zip gcc-c++ make wget lsof lftp

# ========== Maven
RUN yum install -y add maven

# ========== Ruby
RUN yum install -y ruby ruby-devel rubygems libffi-devel ;\
    gem install bundler ;\
    gem install compass

# ========== Python
RUN yum install -y python python36 python36-tools python2-setuptools python2-pip python36-devel python-devel ;\
    pip2.7 install --upgrade pip ;\
    pip2.7 install virtualenv
RUN curl "https://bootstrap.pypa.io/get-pip.py" -o "get-pip.py"; python3.6 get-pip.py; rm get-pip.py
RUN pip3 install virtualenv

# ========== Node JS
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.8/install.sh | bash
RUN curl --silent --location https://rpm.nodesource.com/setup_8.x | bash -
RUN yum install -y nodejs
RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo ;\
    yum install -y yarn
RUN yarn -v
RUN node -v

RUN npm install -g bower ;\
    npm install -g grunt-cli ;\
    npm install -g gulp ;\
    npm install -g compass

# ========== Docker, Rancher, AWS
RUN pip3 install docker-compose
RUN pip3 install awscli

# Install bzip2
RUN yum install -y bzip2 libsass libsass-devel

# Fix some node things
RUN npm install node-gyp --global ;\
    npm config set python /usr/bin/python2.7 ;\
    npm config set unsafe-perm true

# add ip route
RUN yum install -y iproute which

# Fix for running bower as root
RUN echo '{ "allow_root": true }' >> /root/.bowerrc

# Install Jquery
RUN wget https://github.com/stedolan/jq/releases/download/jq-1.5/jq-linux64 ;\
    mv /jq-linux64 /usr/local/bin/jq ;\
    chmod +x /usr/local/bin/jq

# Install 32bit support
RUN yum install -y glibc.i686 zlib.i686 libgcc.i686

# ##############################################################################
# Install Azure CLI
RUN rpm --import https://packages.microsoft.com/keys/microsoft.asc
RUN sh -c 'echo -e "[azure-cli]\nname=Azure CLI\nbaseurl=https://packages.microsoft.com/yumrepos/azure-cli\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" > /etc/yum.repos.d/azure-cli.repo'
RUN yum install -y azure-cli

# ##############################################################################
# Install Ansible and Azure Service Fabric CLI
RUN pip3 install -U ansible[azure]; pip3 install -U azure; pip3 install -U sfctl
RUN pip2 install -U ansible[azure]; pip2 install -U azure; pip2 uninstall pyopenssl -y


# ##############################################################################
# Install Inspec
RUN curl -LO https://omnitruck.chef.io/install.sh; bash ./install.sh -P inspec; rm ./install.sh


# ##############################################################################
# Install composer
RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer

CMD /bin/bash +x entrypoint.sh
