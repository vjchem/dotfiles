autoload colors && colors
# cheers, @ehrenmurdick
# http://github.com/ehrenmurdick/config/blob/master/zsh/prompt.zsh

git_branch() {
  echo $(/usr/bin/git symbolic-ref HEAD 2>/dev/null | awk -F/ {'print $NF'})
}

git_dirty() {
  st=$(/usr/bin/git status 2>/dev/null | tail -n 1)
  if [[ $st == "" ]]
  then
    echo ""
  else
    if [[ $st == "nothing to commit, working directory clean" ]]
    then
      echo "on %{$fg[green]%}$(git_prompt_info)%{$reset_color%}"
    else
      echo "on %{$fg[red]%}$(git_prompt_info)%{$reset_color%}"
    fi
  fi
}

git_prompt_info () {
 ref=$(/usr/bin/git symbolic-ref HEAD 2>/dev/null) || return
# echo "(%{\e[0;33m%}${ref#refs/heads/}%{\e[0m%})"
 echo "${ref#refs/heads/}"
}

unpushed () {
  /usr/bin/git cherry -v @{upstream} 2>/dev/null
}

need_push () {
  if [[ $(unpushed) == "" ]]
  then
    echo " "
  else
    echo " with %{$fg[magenta]%}unpushed%{$reset_color%} "
  fi
}

#rb_prompt(){
# if $(which rbenv &> /dev/null)
# then
#   echo "%{$fg[yellow]%}$(rbenv version | awk '{print $1}')%{$reset_color%}"
# else
#   echo "%m"
# fi
#}

# This keeps the number of todos always available the right hand side of my
# command line. I filter it to only count those tagged as "+next", so it's more
# of a motivation to clear out the list.
todo(){
  if $(which todo.sh &> /dev/null)
  then
    num=$(echo $(todo.sh ls +next | wc -l))
    let todos=num-2
    if [ $todos != 0 ]
    then
      echo "$todos"
    else
      echo ""
    fi
  else
    echo ""
  fi
}

directory_name(){
  echo "%{$fg[cyan]%}%1/%\/%{$reset_color%}"
}

# modified version of what virtualenv uses to work with this setup
add_venv_info () {
    if [ -z "$VIRTUAL_ENV_DISABLE_PROMPT" ] ; then
        _OLD_VIRTUAL_PS1="$PS1"
        if [ "x" != x ] ; then
            # PS1="$PS1"
            echo ""
        else
            if [ "`basename \"$VIRTUAL_ENV\"`" = "__" ] ; then
                # special case for Aspen magic directories
                # see http://www.zetadev.com/software/aspen/
                echo "[`basename \`dirname \"$VIRTUAL_ENV\"\``]"
                # PS1="[`basename \`dirname \"$VIRTUAL_ENV\"\``] $PS1"
            elif [ "$VIRTUAL_ENV" != "" ]; then
                echo "%{$fg[yellow]%}(`basename \"$VIRTUAL_ENV\"`)%{$reset_color%} "
                # PS1="(`basename \"$VIRTUAL_ENV\"`)$PS1"
            fi
        fi
        echo ""
        # export PS1
    fi
}
PROMPT_COMMAND="$PROMPT_COMMAND add_venv_info"

set_prompt () {
  export PROMPT=$'\n$(add_venv_info)%m in $(directory_name) $(git_dirty)$(need_push)\n› '
  export RPROMPT=$'%{$fg_bold[green]%}%~%{$reset_color%}'
}

precmd() {
  title "zsh" "%m" "%55<...<%~"
  set_prompt
}

