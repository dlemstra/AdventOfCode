docker build . -t aoc-2016
docker run -it -v %~dp0:/aoc -w /aoc aoc-2016 /bin/bash
