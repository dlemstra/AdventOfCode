docker build ../.devcontainer/2022 -t aoc-2022
docker run -it -v %~dp0:/aoc -w /aoc aoc-2022 /bin/bash
