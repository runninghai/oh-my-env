# plugins config
plugins=($plugins git zsh-autosuggestions kubectl)

source $ZSH/oh-my-zsh.sh

#***********************split lint ***********************
#code below can't be set above

export LOGPATH="$HOME/Documents/code/git/log"

source $CODEPATH/git/oh-my-env/deps/install.sh

# dracula config
export DRACULA_DISPLAY_TIME=1 
export DRACULA_DISPLAY_CONTEXT=1
export DRACULA_DISPLAY_NEW_LINE=1
export EDITOR='nvim'

export NVIM_PLUGIN=$HOME/.local/share/nvim/lazy

# alias
alias tnew="tmux new -s"
alias rl="source ~/.zshrc"
alias vim="nvim"
alias vi="nvim"
alias lg="lazygit"
alias mypc="ssh wherever230@192.168.1.6"
#alias walk="walk --icons"

system=$(uname -s)
if [[ "$system" = "Linux" ]];then
    alias cat="batcat"
elif [[ "$system" = "Darwin" ]];then
    alias cat="bat"
fi

# rust configuration
source "$HOME/.cargo/env"

# autojump
[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh
[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh

bindkey -v
bindkey "^R"      history-incremental-search-backward 

# thefuck configuration
eval $(thefuck --alias)

function generateMobi {
    if [ -d "html_out" ]; then
        rm -rf html_out
    fi
    PROJECT=$(basename "$PWD")
    cpucnt=$(sysctl hw.logicalcpu|awk '{print $2}')
    src2html.pl --tab-width 4 --color --cross-reference --navigator --line-numbers \
        -j $((${cpucnt}*2)) . '$PROJECT'
    ebook-convert html_out/index.html $PROJECT.mobi\
        --output-profile kindle_dx --no-inline-toc \
        --title "$PROJECT" --publisher 'wherever230' \
        --language en --authors 'wherever230'
    mv $PROJECT.mobi ~/Documents/doc/mobi
    rm -rf html_out
    rm src2html.tags
}

function plantuml {
    cat $1 | java -DPLANTUML_LIMIT_SIZE=16384 -jar \
        ${PLANTUML_PATH}/plantuml.jar -pipe \
        | open -a Preview.app -f
}

function genePlantuml {
    project=$(basename $(pwd))
    goplantuml . > $project
    java -DPLANTUML_LIMIT_SIZE=16384 -jar \
        ${PLANTUML_PATH}/plantuml.jar $project
    rm $project
}

function addDailyLog {
    year=$(date +"%Y")
    month=$(date +"%m")
    today=$(date +"%d")
    log=$LOGPATH/log/$year/$month/$today
    mkdir -p $log/images
    if [[ -e $log/README.md ]] then
        return
    fi

    touch $log/README.md
}

function dailyLog {
    year=$(date +"%Y")
    month=$(date +"%m")
    today=$(date +"%d")
    log=log/$year/$month/$today
    echo $log
}

# log funcs
function fetchImage {
    year=$(date +"%Y")
    month=$(date +"%m")
    date=$(date +"%d")
    imagePath=$LOGPATH/log/$year/$month/$date/images

    if [ ! -d $imagePath ]
    then
        mkdir -p $imagePath 
    fi

    if [[ $1 == http* ]]; then
        curl $1 -Lo $imagePath/$2
    else
        if [[ -e $1 ]]; then
            cp $1 $imagePath/
        else
            cp $HOME/Downloads/$1 $imagePath/
        fi
    fi
}

function suggestFetchImage {
  local files
  files=($HOME/Downloads/*.(jpeg|png|jpg|gif)(N:t))
  compadd -U -f -a files 
}
compdef suggestFetchImage fetchImage



function codeStatistic {
    gtype=$1
    suffi=$2
    for file in *;do
        if [[ -f $file ]]; then
            if [[ "$file" == *"$suffi"."$gtype" ]];then
                res=$(wc -l < $file)
                printf "%-10s %-10s\n" "$res" "$file"
            fi
        fi
        if [[ -d $file ]]; then
            pushd $file > /dev/null
            find . -name "*$suffi.$gtype" -exec wc -l {}  \;|awk -v file="$file" 'BEGIN{sum=0}{sum = sum + $1}END{if(sum != 0)printf("%-10s %-10s\n",sum,file)}'
            popd > /dev/null
        fi
    done
}

function neovimUpgrade {
    sudo cp -rf bin/* /usr/local/bin/
    sudo cp -rf man/* /usr/local/man/
    sudo cp -rf lib/* /usr/local/lib/
    sudo cp -rf share/* /usr/local/share/
}


function cleanDownloads {
    DownloadsPath=$HOME/Downloads
    lock=$DownloadsPath/.$(date +"%Y-%m-%d").lock
    if [[ -f "$lock" ]]; then
        return
    fi

    current_timestamp=$(date +%s)
    yesterday_timestamp=$((current_timestamp - 24 * 60 * 60))
    yesterday=$(date -r "$yesterday_timestamp" +"%Y-%m-%d")

    find $DownloadsPath -type f -newermt "$yesterday" ! -newermt "$yesterday + 1 day" -delete
    touch $lock
}

function lk {
  cd "$(walk "$@")"
}

cleanDownloads
addDailyLog

# vim: set filetype=bash :
