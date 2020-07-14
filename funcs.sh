#!bash
#version 1.1.1

MY_PATH="${HOME}/.git-script"
#list cmds
gls(){
  cat "$MY_PATH" | grep '^g\w*(' | sed 's/(.*$//' > /tmp/_gmlist.cmds
  cat "$MY_PATH" | grep '^g\w*(' -B 1 | grep '^#' | sed 's/^#/	--/'> /tmp/_gmlist.oneline
  paste /tmp/_gmlist.cmds /tmp/_gmlist.oneline
}

#update
gupdate(){
  remote_version=$(curl https://raw.githubusercontent.com/OuyangQianba/git-scripts/master/funcs.sh | grep '#version' | head -n 1)
  echo "Remote version:${remote_version}"
  local_version=$(grep '#version' "${MY_PATH}" | head -n 1)
  echo "Local version:${local_version}"
  if [ "$local_version" != "$remote_version" ];then
    echo 'update'
    curl "https:/raw.githubusercontent.com/OuyangQianba/git-scripts/master/install.sh" | sh
  fi
}
#show version
gversion(){
  local_version=$(grep '#version' "${MY_PATH}"| head -n 1)
  echo $local_version
}

#help
ghelp(){
  #ghelp
  #ghelp Command : ghelp
  #ghelp Usage: ghelp [command]
  #ghelp
  #ghelp Example: ghelp gcmt
  #ghelp
  cmd=ghelp
  if [ "$#" -gt 0 ];then
    cmd=$1
  fi
  help=$(grep -e "#\s*${cmd}" "$MY_PATH" | sed "s: *# *${cmd}::g")
  if [ $(echo -n $help | wc -l) -gt  0 ];then
    echo "$help"
  else
    echo "No help info"
  fi
}


#gm commit 
gcmt(){
 #gcmt
 #gcmt Command: gcmt - git commit
 #gcmt Usage: gcmt [word word ...  | " string " ]
 #gcmt
 #gcmt Example: gcmt Initial commit
 #gcmt 
 echo $@ | xargs -I _ git commit -m '_'
}

#Introducing new features
gmfeat(){
  gcmt ":sparkles: [feat] $@"
}

#Fixing a bug
gmfix(){
  gcmt ":bug: [fix] $@"
}

#Moving or renaming files
gmtruck(){
  gcmt ":truck: [rename] $@"
}

#Updating code due to code review changes
gmreview(){
  gcmt ":ok_hand: [review] $@"
}

#Adding logs
gmloga(){
  gcmt ":loud_sound: [+log] $@"
}

#Removing logs
gmlogr(){
  gcmt ":mute: [-log] $@"
}

#Improving performance
gmper(){
  gcmt ":zap: [performance] $@"
}

#Refactoring code
gmrefactor(){
  gcmt ":recycle: [refactor] $@"
}

#Add/Update tests
gmtest() {
  gcmt ":white_check_mark: [test] $@"
}

#Improve UX
gmux(){
  gcmt ":children_crossing: [ux] $@"
}

#
gmversion() {
  gcmt ":bookmark: [version] $@"
}

#style
gmstyle(){
 gcmt ":lipstick: [feat] $@"
}

#
gmchore(){
  gcmt ":tada: [chore] $@"
}

#Writing docs
gmdoc(){
  gcmt ":memo: [docs] $@"
}

#git branch list local only
gblsl(){
  # 列出本地分支
  git branch -r | grep -v -e '->' | sed 's:[ ]*origin/::g' > /tmp/__gitbranch.remote
  git branch | sed 's:[* ]*::' > /tmp/__gitbranch.local
  grep -F -v -f /tmp/__gitbranch.remote /tmp/__gitbranch.local
}

#remove local branch
gbdell(){
  gblsl | column
  for i in $(gblsl);do
    echo "Would you want to delete ${i}? "
    echo -n "(Y)es / (N)o / (A)ll / (E)xit :" 
    while read -r yes_no;do
      case "$yes_no" in
        Y|y) 
          git branch -D "${i}"
          break
        ;;
        N|n) break ;;
        A|a) 
          git branch -D $(gblsl | tr '\n' ' ')
        return;;
        E|e)
          return;;
        *);;
      esac
    done
  done
}
#git un commit
guncmt () {
  local hash
  hash=$(git log --oneline | head  -n 2 | tail -n 1 | awk '{print $1}')
  git reset "$hash"
}
