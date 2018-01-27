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
 echo $@ | xargs -I _ gm commit -m '_'
}
#Introducing new features
gmfeat(){
gcmt ":sparkles: [feat] $@"
}
#Fixing a bug
gmfix(){
gcmt ":bug: [fixed] $@"
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
gmlog+(){
gcmt ":loud_sound: [+log] $@"
}
#Removing logs
gmlog-(){
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
