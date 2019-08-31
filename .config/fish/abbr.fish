# fish abbr
abbr --add l='ls'
abbr --add ll='ls -al' #'ls -lt'
# List only directories
abbr --add lsd='ls -l | grep "^d"'
abbr --add free='free -h'
abbr --add cd..='cd ..'
abbr --add ..='cd ..'
abbr --add ...='cd ../..'
abbr --add ps='ps ax -eo user,pid,priority,args'
# abbr --add pingg='ping -c 5 8.8.8.8'
# abbr --add toro='chromium --proxy-server="socks://localhost:9050" --incognito check.torproject.org'
abbr --add sx1='sudo systemctl stop dhcpcd@enp3s0.service ;and sudo systemctl start dhcpcd@enp3s0.service'
