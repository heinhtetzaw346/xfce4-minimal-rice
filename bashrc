#dependency variables
export VAULT_ADDR="http://172.20.204.44:8200"

#shortcut variables
export VM=/media/fureasu/DATA/VirtualMachines
export docker=/media/fureasu/DATA/DevOps/YamlObjects/docker
export k8s=/media/fureasu/DATA/DevOps/YamlObjects/kubernetes
export Download=/media/fureasu/DATA/Download
export DevOps=/media/fureasu/DATA/DevOps
export DATA=/media/fureasu/DATA
export Media=/media/fureasu/DATA/Media
export Programming=/media/fureasu/DATA/Programming
export OSImages=/media/fureasu/DATA/OSImages 
export MMR=/media/fureasu/DATA/MMR 

#prompt decoration section
#colors
C0="\[\e[0m\]"    #colorless(white)
C1="\[\e[1;31m\]" #red
C2="\[\e[1;32m\]" #green
C3="\[\e[1;33m\]" #yellow
C4="\[\e[1;34m\]" #blue
C5="\[\e[1;35m\]" #violet
C6="\[\e[1;36m\]" #cyan
C7="\[\e[1;37m\]" #gray

#short pwd
short_pwd() { pwd | sed -e "s|$HOME|~|" -e 's|\(/.\)[^/]*/|\1/|g'; }
#kubectl context
kubectl_context() { 
    output=$(kubectl config get-contexts | grep '*' | awk -F ' ' '{ print $2 }')
    if [ "$output" = "" ]; then
        output="none"
    fi
    output="⚓ $output"
    echo "$output"
}

default_prompt="$C0[$C5🐧 \u@\h:$C6\$(short_pwd)$C0]$C3$C1\$(__git_ps1)$C0\n\$ "
#default prompt
export PS1="$default_prompt"
export PS2="-> "

#prompt with kubectl context
show-kctx() {
    export PS1="$C3(\$(kubectl_context)) $default_prompt"
}

#prompt without kubectl context
hide-kctx() {
    export PS1="$default_prompt"
}

#required system variables#
export GTK_THEME=Catppuccin-Dark
export BAT_THEME=ansi
export PATH=/home/fureasu/.scripts:/media/fureasu/DATA/Programs/Godot:/home/fureasu/.vsdbg:$PATH
export MANPAGER="vim +MANPAGER --not-a-term -"

#alias#
alias godot='Godot_v4.4.1-stable_linux.x86_64'
alias k='kubectl'
alias setterm='export TERM=xterm-256color'
alias ssh='TERM=xterm-256color ssh'

#kubectl auto-complete#
source <(kubectl completion bash)
complete -o default -F __start_kubectl k

complete -C /usr/local/bin/terraform terraform
