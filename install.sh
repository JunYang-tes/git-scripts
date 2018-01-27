#!sh
FILE_PATH=~/.git-script
if [ -f ${FILE_PATH} ];then
  echo 'git-script is already exists, press enter to override it'
  read -r
fi
install(){
  curl https://raw.githubusercontent.com/OuyangQianba/git-scripts/master/funcs.sh > ~/.git-script
  rc=".bash_profile"
  rcs=".bash_profile .bashrc .zshrc"
  for i in ${rcs}
  do
    if [ -f "${HOME}/${i}" ]
    then
      rc=${i}
      echo $rc
      break;
    fi
  done
  echo "RC:${rc}"
  echo ". ~/.git-script" >> "$HOME/$rc"
  echo "Git script installed. Reopen terminal or using . ~/.git-script to load script"
  echo "Using gls to show all commands"
}

install