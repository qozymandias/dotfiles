#!/bin/bash

# get current branch in git repo
function parse_git_branch() {
    BRANCH=$(git branch 2>/dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/\1/')
    if [ ! "${BRANCH}" == "" ]; then
        STAT=$(parse_git_dirty)
        echo "[${BRANCH}${STAT}]"
    else
        echo ""
    fi
}

# get current status of git repo
function parse_git_dirty {
    status=$(git status 2>&1 | tee)
    dirty=$(
        echo -n "${status}" 2>/dev/null | grep "modified:" &>/dev/null
        echo "$?"
    )
    untracked=$(
        echo -n "${status}" 2>/dev/null | grep "Untracked files" &>/dev/null
        echo "$?"
    )
    ahead=$(
        echo -n "${status}" 2>/dev/null | grep "Your branch is ahead of" &>/dev/null
        echo "$?"
    )
    newfile=$(
        echo -n "${status}" 2>/dev/null | grep "new file:" &>/dev/null
        echo "$?"
    )
    renamed=$(
        echo -n "${status}" 2>/dev/null | grep "renamed:" &>/dev/null
        echo "$?"
    )
    deleted=$(
        echo -n "${status}" 2>/dev/null | grep "deleted:" &>/dev/null
        echo "$?"
    )
    bits=''
    if [ "${renamed}" == "0" ]; then
        bits=">${bits}"
    fi
    if [ "${ahead}" == "0" ]; then
        bits="*${bits}"
    fi
    if [ "${newfile}" == "0" ]; then
        bits="+${bits}"
    fi
    if [ "${untracked}" == "0" ]; then
        bits="?${bits}"
    fi
    if [ "${deleted}" == "0" ]; then
        bits="x${bits}"
    fi
    if [ "${dirty}" == "0" ]; then
        bits="!${bits}"
    fi
    if [ ! "${bits}" == "" ]; then
        echo " ${bits}"
    else
        echo ""
    fi
}

function nonzero_return() {
    RETVAL=$?
    [ $RETVAL -ne 0 ] && echo "$RETVAL"
}

function force_push_to_different_origin() {
    local_branch=$1
    remote_branch=$2
    git push --force-with-lease origin "$local_branch":"$remote_branch"
}

function tcpdump_rest_requests() {
    port=$1
    tcpdump -i lo -A -s 0 "tcp port $port and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)" -w capture.pcap
}

gtm() {
    gt | grep 'M ' | awk '{print $2}'
}

convert_into_ascii() {
    filename=$1
    iconv -f UTF-8 -t ASCII//TRANSLIT//IGNORE "$filename" >out.md
    [ -s out.md ] && mv out.md "$filename"
}

format_md() {
    filename=$1
    convert_into_ascii "$filename" &&
        pandoc "$filename" -o out.md -f markdown -t markdown+fenced_code_blocks --wrap=auto --columns=130 &&
        mv out.md "$filename"
}

# Function for logging into AWS account "PROFILE_NAME", opens pop-up for login.
aws_login() {
    PROFILE_NAME="IDVerse---Play---Oscar-Downing/AdministratorAccess"
    aws sso login --profile "$PROFILE_NAME"
    aws sts get-caller-identity --profile "$PROFILE_NAME"
    aws s3 ls --profile "$PROFILE_NAME"
}

# Function for exporting AWS credentials, should be run everytime you open a new shell for local-idv.
aws_export_credentials() {
    #PROFILE_NAME="IDVerse---Play---Oscar-Downing/AdministratorAccess"
    # PROFILE_NAME="IDVerse-Platform---Dev2/Devs-IDKS"
    PROFILE_NAME=$1
    eval $(aws configure export-credentials --profile "$PROFILE_NAME" --format env)
    export AWS_DEFAULT_REGION=$(aws configure get region --profile "$PROFILE_NAME")
}

devpilot() {
    prompt=""

    if [ -f $HOME/.copilot/prompt.md ]; then
        prompt="$prompt\n# GLOBAL RULES\n$(cat $HOME/.copilot/prompt.md)\n"
    fi

    if [ -f AGENTS.md ]; then
        prompt="$prompt\n# AGENT RULES\n$(cat AGENTS.md)\n"
    fi

    gh copilot \
        -i "$prompt" \
        --available-tools='view,grep,glob' \
        --allow-tool='view' \
        --allow-tool='grep' \
        --allow-tool='glob' \
        --allow-tool='shell(git:status|git:diff|git:log|git:blame|cargo:metadata|cargo:tree|cargo:locate-project)' \
        --allow-tool='shell(cat|less|head|tail|wc|stat|file|grep|rg|fd|find|du)' \
        --deny-tool="shell(git:push|git:commit|git:reset|git:rebase|git:clean|rm|mv|cp|chmod|chown|curl|wget|bash)"
}

update_rust_version() {
    rustup override set $(cat ~/.rust-toolchain)
}

# TODO:
# cargo run --release -- dependents idkit-events --github-token <github-token> --gitlab-token <gitlab-token>

# TODO: make this into function
# alias synczkp='rsync -avz --exclude "auto_submit_workspace/" --exclude "workplace/" --exclude "server_storage/" --exclude ".git/" --exclude "target/" --exclude "node_modules/" -e "ssh -i ~/.ssh/id_ed25519" ~/dev/zkp/restservice/zkp/ oscar@138.217.142.94:~/fresh/restservice/zkp'

# TODO: cargo macro expander function
#
# argo expand -p idkit_models_core --all-features
