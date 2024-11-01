#!/usr/bin/env bash

git() { if [ "$#" -gt 1 ] && [[ "$2" == "git" ]]; then shift; shift; echo "git $*"; fi; /usr/bin/git "$@"; };

awsconf() {
    export AWS_PROFILE="${AWS_PROFILE:-default}";
    region="${AWS_REGION:-ap-southeast-2}";

    aws configure sso --profile "$AWS_PROFILE" --region "$region";

    eval "$(aws configure export-credentials --profile "$AWS_PROFILE" --format "env")";

    echo "[$AWS_PROFILE]" > ~/.aws/credentials;
    echo "aws_access_key_id=$AWS_ACCESS_KEY_ID" >> ~/.aws/credentials;
    echo "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY" >> ~/.aws/credentials;
    echo "aws_session_token=$AWS_SESSION_TOKEN" >> ~/.aws/credentials;
}

