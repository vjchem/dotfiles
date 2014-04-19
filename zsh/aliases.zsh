alias reload!='. ~/.zshrc'
alias ..="cd .."
alias ...="cd ../.."
alias la="ls -A"
alias ll="ls -lAhF"

# Recursively delete '.DS_Store' files
alias cleanup="find . -name '*.DS_Store' -type f -ls -delete"

# Flush Directory Service cache
alias flush="dscacheutil -flushcache"

# Start a webserver in the current dir, stolen from @stevenmbone
alias servethis="open http://0.0.0.0:8000 && python -m SimpleHTTPServer"

# Hide/show all desktop icons (useful when presenting)
alias hidedesktop"defaults write com.apple.finder CreateDesktop -bool false && killall Finder"
alias showdesktop"defaults write com.apple.finder CreateDesktop -bool true && killall Finder"

# Stuff I never really use but cannot delete because of http://xkcd.com/530/
alias stfu="osascript -e 'set volume output muted true'"
alias pumpitup="osascript -e 'set volume 10'"
alias hax="growlnotify -a 'Activity Monitor' 'System error' -m 'WTF R U DOIN'"

# Some shortcuts to commonly used places
alias desk="cd ~/Desktop/"
alias webdocs="cd /Library/WebServer/Documents/"
alias work="cd ~/Documents/Work/"
alias repos="cd ~/Repos/"

alias sails="nocorrect sails"
alias cinplayer="cd ~/Documents/Work/cinematique/cinematique-player/"

alias vact="source bin/activate"
alias de="deactivate;"

alias cindev="cd ~/Documents/Work/cinematique/cinematique-env"
alias cin="cindev; vact; cd cinematique"
alias cinsass="cin; cd cinematique/static_local/app/css; compass watch ."

alias cinrun="CIN_ENV=jacob node ./bin/app.js"
alias cinqa="cinplayer; grunt update_server_code:app_qa_instance_1.1.1.1:qa:us-east-1"
