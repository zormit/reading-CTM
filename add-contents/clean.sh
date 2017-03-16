grep -v '^\.' raw.txt |
grep -v '^\c 2001' |
grep -v '^CONTENTS' |
grep -v '^Copyright' |
sed 's/ \.//g' |
grep -v '^[iv]\{1,\}$' |
grep -v  '^[0-9]\{1,\}$' |
# with this positive match I proably don't need the previous negative greps:
grep -E '^[0-9A-Z][0-9]?(\.[0-9]*)* [A-Za-z“]' |
less
