#!bash
MY_PATH=$0
#list cmds
gls(){
cat "$MY_PATH" | grep '^g\w*(' | sed 's/(.*$//' > /tmp/_gmlist.cmds
cat "$MY_PATH" | grep '^g\w*(' -B 1 | grep '^#' | sed 's/^#/	--/'> /tmp/_gmlist.oneline
paste /tmp/_gmlist.cmds /tmp/_gmlist.oneline
}
#gm commit 
gcmt(){
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
#
gmchore(){
gcmt ":tada: [chore] $@"
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