MY_PATH=$0
#list cmds
gitlist(){
cat $MY_PATH | grep '^git\w*(' | sed 's/(.*$//' > /tmp/_gitlist.cmds
cat $MY_PATH | grep '^git\w*(' -B 1 | grep '^#' | sed 's/^#/	--/'> /tmp/_gitlist.oneline
paste /tmp/_gitlist.cmds /tmp/_gitlist.oneline
}
#git commit 
gitcmt(){
 echo $@ | xargs -I _ git commit -m '_'
}
#Introducing new features
gitfeat(){
gitcmt ":sparkles: [feat] $@"
}
#Fixing a bug
gitfix(){
gitcmt ":bug: [fixed] $@"
}
#Moving or renaming files
gittruck(){
gitcmt ":truck: [rename] $@"
}
#Updating code due to code review changes
gitreview(){
gitcmt ":ok_hand: [review] $@"
}
#Adding logs
gitlog+(){
gitcmt ":loud_sound: [+log] $@"
}
#Removing logs
gitlog-(){
gitcmt ":mute: [-log] $@"
}

#Improving performance
gitper(){
gitcmt ":zap: [performance] $@"
}
#Refactoring code
gitrefactor(){
gitcmt ":recycle: [refactor] $@"
}
#
gitchore(){
gitcmt ":tada: [chore] $@"
}
