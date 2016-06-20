FROM elmiko/openshift-spark

ADD . /opt/whirlwind

RUN yum install -y epel-release && yum install -y python-pip && pip install -r /opt/whirlwind/requirements.txt

CMD /opt/whirlwind/start_whirlwind_caravan.sh
