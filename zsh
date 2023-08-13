# If you come from bash you might have to change your $PATH.
# export PATH=$HOME/bin:/usr/local/bin:$PATH
# Path to your oh-my-zsh installation.
export ZSH="/Users/bytedance/.oh-my-zsh"
# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME See https://github.com/ohmyzsh/ohmyzsh/wiki/Themes ZSH_THEME="Dracula"
ZSH_THEME="Dracula"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in $ZSH/themes/
# If set to an empty array, this variable will have no effect.
# ZSH_THEME_RANDOM_CANDIDATES=( "robbyrussell" "agnoster" )

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
# DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to automatically update without prompting.
# DISABLE_UPDATE_PROMPT="true"

# Uncomment the following line to change how often to auto-update (in days).
# export UPDATE_ZSH_DAYS=13

# Uncomment the following line if pasting URLs and other text is messed up.
# DISABLE_MAGIC_FUNCTIONS="true"

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
# DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
# ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
# Caution: this setting can cause issues with multiline prompts (zsh 5.7.1 and newer seem to work)
# See https://github.com/ohmyzsh/ohmyzsh/issues/5765
# COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

# Which plugins would you like to load?
# Standard plugins can be found in $ZSH/plugins/
# Custom plugins may be added to $ZSH_CUSTOM/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(git zsh-autosuggestions kubectl)

source $ZSH/oh-my-zsh.sh

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
alias dev="ssh gaohao.wherever@10.37.153.131"
#alias ebpf="ssh gaohao.wherever@10.37.153.131"
alias kinit="kinit gaohao.wherever@BYTEDANCE.COM"
#alias relay="ssh relay.byted.org"
alias uml="java -DPLANTUML_LIMIT_SIZE=16384 -jar /Users/bytedance/Documents/doc/plantuml/plantuml.jar "
alias rl="source ~/.zshrc"
alias vim="nvim"
alias vi="nvim"


# go configuration
export GOPATH=/Users/bytedance/go
export GOROOT=/usr/local/Cellar/go@1.18/1.18.10/libexec
export GO111MODULE=on
export GOPROXY="https://go-mod-proxy.byted.org,https://goproxy.cn,https://proxy.golang.org,direct"
export GOPRIVATE="*.byted.org,*.everphoto.cn,git.smartisan.com"
export GOSUMDB="sum.golang.google.cn"

export PATH="/Applications/calibre.app/Contents/MacOS/:$PATH"
export PATH="/Users/bytedance/Documents/code/git/code2ebook:$PATH"
export PATH="/usr/local/opt/openjdk/bin:$PATH"
export PATH="/Users/bytedance/go/bin:$PATH"
export PATH="/usr/local/bin/:$PATH"
export PATH="/Users/bytedance/Documents/guitar/lilypond/bin:$PATH"
export PATH="/usr/local/opt/go@1.18/bin:$PATH"
export PATH="/Applications/GoLand.app/Contents/MacOS:$PATH"
export PATH="$GOPATH/bin:$PATH"

export ENVIRONMENT=offline
export K3D_CLUSTER_NAME=local
export LOGPATH="$HOME/Documents/code/git/log"
source "$HOME/.cargo/env"

export PYTHONPATH=/usr/local/lib/python3.9/site-packages/

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

# move downloaded file in 10 mini to current dir or $1
function mvDownloadFile {
    target=.
    if [[ -n $1 ]];then
        target=$1
    fi
    find /Users/bytedance/Downloads -type f -mtime -10m -exec mv {} $target \;
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
defaults write org.vim.MacVim MMNativeFullScreen 0

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
