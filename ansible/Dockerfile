FROM fedora:29 

LABEL version="1.0"
LABEL description="An Ansible container"
LABEL maintainer="wej@doit.wisc.edu"

RUN (cd /lib/systemd/system/sysinit.target.wants/; for i in *; do [ $i == systemd-tmpfiles-setup.service ] || rm -f $i; done); \ 
rm -f /lib/systemd/system/multi-user.target.wants/*; \ 
rm -f /etc/systemd/system/*.wants/*; \ 
rm -f /lib/systemd/system/local-fs.target.wants/*; \ 
rm -f /lib/systemd/system/sockets.target.wants/*udev*; \ 
rm -f /lib/systemd/system/sockets.target.wants/*initctl*; \ 
rm -f /lib/systemd/system/basic.target.wants/*; \ 
rm -f /lib/systemd/system/anaconda.target.wants/*; 

RUN dnf update -y
RUN dnf clean all && \ 
	dnf -y --setopt=install_weak_deps=false install \ 
	acl \ 
	asciidoc \ 
	bzip2 \ 
	dbus-python \ 
	file \ 
	findutils \ 
	gcc \ 
	git \ 
	glibc-locale-source \ 
	iproute \ 
	libffi \ 
	libffi-devel \ 
	make \ 
	mariadb-server \ 
	mercurial \ 
	MySQL-python \ 
	openssh-clients \ 
	openssh-server \ 
	openssl-devel \ 
	procps \ 
	python-cryptography \ 
	python-devel \ 
	python-httplib2 \ 
	python-jinja2 \ 
	python-lxml \ 
	python-mock \ 
	python-nose \ 
	python-paramiko \ 
	python-passlib \ 
	python-pip \ 
	python-setuptools \ 
	python-virtualenv \ 
	ansible \
	PyYAML \ 
	rpm-build \ 
	rubygems \ 
	sshpass \
	subversion \ 
	sudo \ 
	tar \ 
	unzip \ 
	which \ 
	yum \ 
	zip \ 
	iputils \ 
	fping \ 
	&& \ 
	dnf clean all

# getcap  /usr/bin/ping
# /usr/bin/ping = cap_net_admin,cap_net_raw+ep
RUN setcap cap_net_raw,cap_net_admin+p /usr/bin/ping
RUN localedef --quiet -c -i en_US -f UTF-8 en_US.UTF-8 
RUN /usr/bin/sed -i -e 's/^\(Defaults\s*requiretty\)/#--- \1/' /etc/sudoers 
#RUN mkdir /etc/ansible/ 
RUN /usr/bin/echo -e '[local]\nlocalhost ansible_connection=local' > /etc/ansible/hosts
COPY hosts.ansible /etc/ansible/hosts
VOLUME /sys/fs/cgroup /run /tmp 
RUN ssh-keygen -q -t dsa -N '' -f /etc/ssh/ssh_host_dsa_key && \ 
	ssh-keygen -q -t rsa -N '' -f /etc/ssh/ssh_host_rsa_key && \ 
	ssh-keygen -q -t rsa -N '' -f /root/.ssh/id_rsa && \ 
	cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys && \ 
	for key in /etc/ssh/ssh_host_*_key.pub; do echo "localhost $(cat ${key})" >> /root/.ssh/known_hosts; done 
RUN pip install coverage junit-xml 
#RUN pip install ansible
#RUN pip install ansible==2.7.8
#RUN git clone https://github.com/networktocode/ntc-ansible --recursive
RUN git clone https://github.com/networktocode/ntc-ansible --recursive
RUN pip install ntc-ansible
RUN /usr/bin/sed -i -e 's/except Exception, e:/except Exception as e:/' /ntc-ansible/filter_plugins/split.py
#RUN dnf reinstall python3-pip
ENV container=docker 
CMD ["/usr/sbin/init"]

