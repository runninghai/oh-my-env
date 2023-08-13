# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=($plugins git zsh-autosuggestions kubectl)
# User configuration
# export MANPATH="/usr/local/man:$MANPATH"

# You may need to manually set your language environment
# export LANG=en_US.UTF-8

# Preferred editor for local and remote sessions
# if [[ -n $SSH_CONNECTION ]]; then
#   export EDITOR='vim'
# else
#   export EDITOR='mvim'
# fi

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"
#alias code=/Users/bytedance/Documents/code/git
alias tnew="tmux new -s"
alias rl="source ~/.zshrc"
alias vim="nvim"
alias vi="nvim"

export LOGPATH="$HOME/Documents/code/git/log"
source "$HOME/.cargo/env"

[ -f /usr/local/etc/profile.d/autojump.sh ] && . /usr/local/etc/profile.d/autojump.sh

bindkey -v
bindkey "^R"      history-incremental-search-backward 

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

export PLANTUML_PATH=/Users/bytedance/Documents/doc/plantuml/
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

# screencapture cronjob
function screencaptureLog {
    store=/Users/bytedance/cronjob/screencapture/pic

    # clean old pics
    cd $store
    find . -type f -mtime +7 -exec rm -f {} \;

    prefix=$(date +"%h-%M_%y.%m.%d")
    screencapture -D 1 ${store}/${prefix}_1.jpg
    screencapture -D 2 ${store}/${prefix}_2.jpg
    screencapture -D 3 ${store}/${prefix}_3.jpg
}

function addDailyLog {
    year=$(date +"%Y")
    month=$(date +"%m")
    today=$(date +"%d")
    log=$LOGPATH/log/$year/$month/$today
    mkdir -p $log/images

    touch $log/README.md
}

function dailyLog {
    year=$(date +"%Y")
    month=$(date +"%m")
    today=$(date +"%d")
    log=log/$year/$month/$today
    echo $log
}

function killQuick {
    pid=`ps axu|grep QuickTime|grep -v grep|awk '{print $2}'`
    if [ ! -z "$pid" ];then
        kill $pid
    fi
    sleep 1
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

function codeStatistic {
    sum=0
    gtype=$1
    suffi=$2
    for file in *;do
        if [[ -f $file ]]; then
            if [[ "$file" == *"$suffi"."$gtype" ]];then
                res=$(wc -l < $file)
                printf "%-10s %-10s\n" "$res" "$file"
                sum=$((sum + res)) 
            fi
        fi
        if [[ -d $file ]]; then
            pushd $file > /dev/null
            find . -name "*$suffi.$gtype" -exec wc -l {}  \;|awk -v file="$file" '{sum = sum + $1}END{printf("%-10s %-10s\n",sum,file)}'
            popd > /dev/null
        fi
    done
    echo $sum
}
