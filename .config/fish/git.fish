# Git stuff

# alias gma='git commit -am'
# alias gb='git branch'
# alias gra='git remote add'
# alias grr='git remote rm'

function g
   if not test -z (echo $argv)
      git $argv
   else
      git status -sb
   end
end

function ga
   if test "$argv"
      # command echo git add "$argv"
      git add "$argv"
   else
      git add --all
   end
end

function gps
   if test "$argv"
      git commit -m "$argv"
      #git push
   else
      git push
   end
end

# abbr --add ginit='git config --global user.email raingart@users.noreply.github.com'
abbr --add gs='git status'
abbr --add gaf='git add -f'
# abbr --add gps='git push'
# abbr --add gpl='git pull'
abbr --add gd='git diff'
abbr --add gdc='git diff --cached'
abbr --add gdt='git difftool'
abbr --add grm='git rm -r --cached'
abbr --add grmf='git rm -rf'
# abbr --add gcl='git clone --recursive'
abbr --add gco='git checkout'
# abbr --add gcm='git commit -m'
# abbr --add gcv='git commit --verbose'
alias gl="git log \
            --graph \
            --abbrev-commit \
            --date=relative \
	    --pretty=format:'%Cred%h%Creset %an: %s - %Creset %C(yellow)%d%Creset %Cgreen(%cr)%Creset'"

function gcl
   if test "$argv[1]"
      git clone --recursive "$argv[1]"
      # set -l myarray string split / "$argv"
      # echo myarray | selectArr 2 | string replace -r '.git' ''
      set -l dir (string split / "$argv[1]" | sed -n 2p | sed 's/\.git//')
      cd "./$dir"
   end

   # function selectArr
     # read --local --array --null arr
     # echo $arr[$argv]
   # end
end

function gf2
   # git add --all
   git add .
   if not test -z (echo $argv)
      git commit -m "$argv"
   else
      git commit -m "current"
   end
   git push origin gh-pages
end

function gf
   # git add -u
   git add --all
   if test "$argv"
      git commit -m "$argv"
      # git commit -m "$*"
   else
      git commit -m "current"
   end
   git push
   # git push all --all
end

function gitignore
   if test "$argv"
      echo -e "$argv" >> .gitignore
   else
      touch .gitignore
   end
   cat .gitignore
end

function g_ignore_file
   if test "$argv[1]"
      git update-index --assume-unchanged "$argv[1]"
   else
      echo "empty file patch"
   end
end


function greset
   if test "$argv"
      git checkout master
      # git reset --hard HEAD~2
      git reset --hard "$argv" #commit
      git push -f origin master
      echo "ready. Apply changes and pull it."
   else
      echo "empty hash"
   end
end

# alias gt='git tag'
# abbr --add gb='git branch'
# alias gbranch='git rev-parse --abbrev-ref HEAD' #get current branch name

# alias gbi='git bisect'
# alias gbg='git bisect good'
# alias gbb='git bisect bad'
# alias gm='git merge'
# alias gmt='git mergetool'
# alias gpr='git pull --rebase'
# alias gup='git stash ;and git pull --rebase ;and git stash apply'
# alias gr='git rebase'
# alias gri='git rebase -i'
# alias gst='git stash'
# alias gsta='git stash apply'
# alias gunstage='git reset HEAD'


# abbr --add vim nvim
# abbr --add gp 'git push origin HEAD'

# abbr --add gc 'git commit --verbose'
# abbr --add gcm 'git commit -m'
# abbr --add gca 'git commit -a'
# abbr --add gcam 'git commit -am'
