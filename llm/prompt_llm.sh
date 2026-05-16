#!/bin/bash

export LLM_SERVICE_URL=$(gcloud run services describe $LLM_SERVICE --region $REGION --format="value(status.url)")
export ID_TOKEN=$(gcloud auth print-identity-token)

if [ "$#" -eq 1 ]; then
    MESSAGE=$1
else
    echo "Usage: $0 \"message\""
    exit 1
fi


curl -X POST "$LLM_SERVICE_URL/api/chat" \
    -H "Authorization: Bearer $ID_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"model\": \"SpeakLeash/bielik-4.5b-v3.0-instruct:Q8_0\",
        \"messages\": [{ \"role\": \"user\", \"content\": \"$MESSAGE\" }],
        \"stream\": false
    }"
