docker build . -t aoc-2019
docker run -it -v %~dp0:/aoc -w /aoc aoc-2019 /bin/bash
