curl -s -X GET "https://go.dev/dl/" \
  | grep -E '\/dl\/.*darwin.*arm64.tar.gz' \
  | head -n 1 \
  | grep -o 'href="[^"]*"' \
  | sed 's/href="//;s/"//' \
  | awk '{print "https://go.dev"$1}' \
  | xargs -I{} curl -s {} \
  | grep -o 'href="[^"]*"' \
  | sed 's/href="//;s/"//' \
  | xargs -I{} curl -s {} --output ~/Downloads/go-latest.tar.gz
