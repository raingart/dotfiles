# fish abbr
abbr --add l='ls'
abbr --add ll='ls -al' #'ls -lt'
# List only directories
abbr lsd='ls -l | grep "^d"'
abbr --add free='free -h'
abbr --add cd..='cd ..'
abbr --add ..='cd ..'
abbr --add ...='cd ../..'
abbr --add ps='ps ax -eo user,pid,priority,args'
abbr --add pingg='ping -c 5 8.8.8.8'
abbr --add ed='sudo geany'
abbr --add myip='curl ipinfo.io/ip ;or curl icanhazip.com'
abbr --add toro='chromium --proxy-server="socks://localhost:9050" --incognito check.torproject.org'
