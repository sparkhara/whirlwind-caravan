#!/bin/sh

set -ex

source /common.sh

if [ -z $WHIRLWIND_CARAVAN_MONGO_URL ]; then
    echo "WHIRLWIND_CARAVAN_MONGO_URL not provided"
    exit 1
fi

if [ -z $WHIRLWIND_CARAVAN_REST_URL ]; then
    echo "WHIRLWIND_CARAVAN_REST_URL not provided"
    exit 1
fi

if [ -n "$WHIRLWIND_CARAVAN_SPARK_MASTER" ]; then
    SPARK_MASTER_OPTION="--master ${WHIRLWIND_CARAVAN_SPARK_MASTER}"
fi

if [ -n "$WHIRLWIND_CARAVAN_SOCKET" ]; then
    SOCKET_OPTION="--socket ${WHIRLWIND_CARAVAN_SOCKET}"
fi

/opt/spark/bin/spark-submit /opt/whirlwind/whirlwind_caravan.py \
    --mongo $WHIRLWIND_CARAVAN_MONGO_URL \
    --rest $WHIRLWIND_CARAVAN_REST_URL \
    $SPARK_MASTER_OPTION $SOCKET_OPTION
