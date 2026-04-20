#!/bin/bash
	PORT=${PORT:-3000}
BASE_URL="http://localhost:${PORT}"

echo "Running smoke test against ${BASE_URL}..."

# Test 1: Health endpoint returns 200
HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" "${BASE_URL}/health")
if [ "$HTTP_CODE" -ne 200 ]; then
  echo "FAIL: Health endpoint returned HTTP $HTTP_CODE (expected 200)"
  exit 1
fi

# Test 2: Health endpoint body is {status:"ok"}
BODY=$(curl -s "${BASE_URL}/health")
if [ "$BODY" != '{status:ok}' ]; then
  echo "FAIL: Health endpoint returned $BODY (expected {\"status\":\"ok\"})"
  exit 1
fi

echo "PASS: Health endpoint OK (HTTP 200, body: $BODY)"
exit 0

