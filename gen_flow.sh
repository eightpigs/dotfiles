#/bin/bash
# https://graphviz.org/download/

# MacOS
# brew install graphviz

# Debian
# sudo apt install graphviz

sudo cpan Graph:Easy
graph-easy --input=flow.graph --svg > flow.svg
