FROM elmiko/whirlwind-caravan-base

ADD . /opt/whirlwind

CMD /opt/whirlwind/start_whirlwind_caravan.sh
