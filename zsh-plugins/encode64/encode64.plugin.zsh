pad64() {
    local data len

    data="${1}"
    len="${#data}"

    case "$((len % 4))" in
        1) echo "Invalid padding." >&2 ; exit 1 ;;
        2) data="${data}==" ;;
        3) data="${data}=" ;;
    esac

    printf '%s' "${data}"
}

encode64() {
    if [[ $# -eq 0 ]]; then
        cat | base64
    else
        printf '%s' $1 | base64
    fi
}

decode64() {
    if [[ $# -eq 0 ]]; then
        cat | tr '_-' '/+' | base64 --decode
    else
        strlen=${#1}
        if [ "$((strlen))" ]
        printf '%s' $(pad64 $1) | tr '_-' '/+' | base64 --decode
    fi
}

alias e64=encode64
alias d64=decode64
