#!/usr/bin/env bash

WORD_FILE="/usr/share/dict/words"
NUMBER_OF_WORDS=$(wc -l $WORD_FILE | awk '{ print $1 }')
RANDOM_NUMBER=$(shuf -i 0-$NUMBER_OF_WORDS -n 1)
RANDOM_WORD=$(sed "$RANDOM_NUMBER"'q;d' $WORD_FILE)

echo "$RANDOM_WORD" >> banana
git commit -a -m "$RANDOM_WORD"
git push

COMMIT=$(git rev-parse HEAD)
curl -X POST -d api_key=$1 -d sha=$COMMIT -d tags=#docker_tag,#ba-nana,#noooes -d environment=production http://dev.sleuth.io/api/1/deployments/myorg/test-actions/register_deploy
