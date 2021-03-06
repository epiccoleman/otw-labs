function run(){ bash ./levels/level${1} }
function edit(){ vim ./levels/level${1} }

function make(){
    local level_number=${1}
    local level_password=${2}
    if [[ -z "$level_number" ]]; then
        read "level_number?enter level number: "
    fi
    if [[ -z "$level_password" ]]; then
         read "level_password?enter level start password: "
    fi

    local level_file="./levels/level${level_number}"

    if [[ -f $level_file ]]; then
        echo "Level already exists, not creating"
        return
    fi

    echo '#!/usr/bin/env bash' > $level_file
    echo "LEVEL_NO=$level_number" >> $level_file
    echo "PASSWORD=$level_password" >> $level_file

    #append content of level-script-template to level_file
    <./levels/level-script-template >> $level_file
}

function bandoc(){
    local level=$1
    local actual_level=$(( $level + 1 ))
    figlet "Bandit $level -> $actual_level"
    curl -s https://overthewire.org/wargames/bandit/bandit${actual_level}.html | htmlq "#content" | lynx -stdin -dump | less -FX
}
