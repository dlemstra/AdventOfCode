docker build . -t aoc-2015
docker run -it -v %~dp0:/aoc -w /aoc aoc-2015 /bin/bash
