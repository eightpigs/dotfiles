# cd "$(i3-msg -t get_tree | jq -r '.nodes | .[].nodes | .[].nodes | .[].nodes | .[].nodes | .[] | select( .focused==true) | [.name]' 2>&1 | sed -e '2!d;s/^.*://g;s/"$//g' | sed -e "s|^~|${HOME}|g")" || cd ~
cd $(i3-msg -t get_tree | jq -r '.nodes | .[].nodes | .[].nodes | .[].nodes | .[].nodes | .[] | .nodes | .[] | .nodes | .[] | select(.focused) | .name' | awk -F: '{print $2}')
