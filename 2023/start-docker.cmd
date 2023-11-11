docker build ../.devcontainer/2023 -t aoc-2023
docker run -it -v %~dp0:/aoc -w /aoc aoc-2023 /bin/bash
