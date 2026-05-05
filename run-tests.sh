#!/bin/bash
if ! command -v jq &> /dev/null
then
    echo "jq could not be found. Please install it."
    exit 1
fi

JSON_FILE=$1
NODE_INDEX=$2
TESTS=$(jq -r ".containers[$((NODE_INDEX-1))].tests | join(\",\")" $JSON_FILE)

if [ -z "$TESTS" ] || [ "$TESTS" == "null" ]; then
  echo "No tests found for node $NODE_INDEX"
  exit 0
fi

echo "-------------------------------------------------------"
echo "NODE INDEX: $NODE_INDEX"
echo "RUNNING TESTS: $TESTS"
echo "-------------------------------------------------------"

mvn test -Dtest=$TESTS
