#!/bin/sh

cd $(dirname $0)

set -ex

if [ -z $SKIP_COMMON ]; then
    source /common.sh
fi

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

if [ -n "$WHIRLWIND_CARAVAN_MODEL" ]; then
    MODEL_OPTION="--model ${WHIRLWIND_CARAVAN_MODEL}"
else
    MODEL_OPTION="--model /opt/whirlwind/model.json"
fi

/opt/spark/bin/spark-submit /opt/whirlwind/whirlwind_caravan.py \
    --mongo $WHIRLWIND_CARAVAN_MONGO_URL \
    --rest $WHIRLWIND_CARAVAN_REST_URL \
    $SPARK_MASTER_OPTION $SOCKET_OPTION $MODEL_OPTION
