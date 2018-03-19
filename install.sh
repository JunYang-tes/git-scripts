#!sh
WRITE_RC=0
FILE_PATH=~/.git-script
if [ -f ${FILE_PATH} ];then
  WRITE_RC=1
fi
install(){
  curl https://raw.githubusercontent.com/OuyangQianba/git-scripts/master/funcs.sh > ~/.git-script
  if [ ${WRITE_RC} -eq 0 ];then
    rc=".bash_profile"
    rcs=".bash_profile .bashrc .zshrc"
    for i in ${rcs}
    do
      if [ -f "${HOME}/${i}" ]
      then
        rc=${i}
        echo "RC:${rc}"
        echo ". ~/.git-script" >> "$HOME/$rc"
      fi
    done
  fi
  echo "Git script installed. Reopen terminal or using . ~/.git-script to load script"
  echo "Using gls to show all commands"
}

install