__start_kkctlctl()
{
    local cur prev words cword split

    COMPREPLY=()

    # Call _init_completion from the bash-completion package
    # to prepare the arguments properly
    if declare -F _init_completion >/dev/null 2>&1; then
        _init_completion -n =: || return
    else
        __kkctlctl_init_completion -n =: || return
    fi

    __kkctlctl_debug
    __kkctlctl_debug "========= starting completion logic =========="
    __kkctlctl_debug "cur is ${cur}, words[*] is ${words[*]}, #words[@] is ${#words[@]}, cword is $cword"

    # The user could have moved the cursor backwards on the command-line.
    # We need to trigger completion from the $cword location, so we need
    # to truncate the command-line ($words) up to the $cword location.
    words=("${words[@]:0:$cword+1}")
    __kkctlctl_debug "Truncated words[*]: ${words[*]},"

    local out directive
    __kkctlctl_get_completion_results
    __kkctlctl_process_completion_results
}

if [[ $(type -t compopt) = "builtin" ]]; then
    complete -o default -F __start_kkctlctl microk8s.kubectl 
else
    complete -o default -o nospace -F __start_kkctlctl microk8s.kkctlctl
fi

# ex: ts=4 sw=4 et filetype=sh