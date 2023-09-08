system=$(uname -s)
release=$(lsb_release -a 2>/dev/null |awk '{if(NR==1){print $3}}')
version=$(lsb_release -a 2>/dev/null | grep Release|awk '{print $2}')
installBasePath=$CODEPATH/git/oh-my-env/deps
if [[ "$system" = "Linux" ]];then
    if [[ "$release" != "Ubuntu" ]];then
        echo "not support yet"
        return
    fi
    if [[ "$version" != "22.04" ]];then
        echo "not support yet"
        return
    fi
    installpath=$installBasePath/ubuntu
elif [[ "$system" = "Darwin" ]];then
    installpath=$installBasePath/macos
fi

for file in $installBasePath/both/*
do
    if [ -f "$file" ]; then
        source $file
    fi
done

for file in $installpath/*
do
    if [ -f "$file" ]; then
        source $file
    fi
done

# vim: set filetype=bash
