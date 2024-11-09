#!/usr/bin/env bash

#* LAZY HACK BECAUSE I KEEP PASTING FULL CLONE COMMANDS AFTER ALREADY TYPING git clone.
git() { if [ "$#" -gt 1 ] && [[ "$2" == "git" ]]; then shift; shift; echo "git $*"; fi; /usr/bin/git "$@"; };


#* RUN aws configure sso AND EXPORT SSO CREDENTIALS AS BOTH ENV VARS AND TO STANDARD ~/.aws/credentials FILE
awsconf() {
    export AWS_PROFILE="${AWS_PROFILE:-default}";
    region="${AWS_REGION:-ap-southeast-2}";

    aws configure sso --profile "$AWS_PROFILE" --region "$region";

    eval "$(aws configure export-credentials --profile "$AWS_PROFILE" --format "env")";

    {
		echo "[$AWS_PROFILE]"
		echo "aws_access_key_id=$AWS_ACCESS_KEY_ID";
    	echo "aws_secret_access_key=$AWS_SECRET_ACCESS_KEY";
    	echo "aws_session_token=$AWS_SESSION_TOKEN";
	} > ~/.aws/credentials
}


#* LAUNCH A PROGRAM AND DETACH IT FROM CURRENT TTY
launch() { "$@" </dev/null &>/dev/null & disown %%; }


#* SHORTCUT FOR SOURCING RC FILE
#shellcheck disable=SC1090
.() { if [[ "$#" -gt 0 ]]; then source "$@"; else source "$HOME/.${SHELL##*/}rc"; fi }
