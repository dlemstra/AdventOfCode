docker build . -t aoc-2021
docker run -it -v %~dp0:/aoc -w /aoc aoc-2021 /bin/bash
