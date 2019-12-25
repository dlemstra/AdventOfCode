#!/bin/bash
set -e

cargo build $1
if [ $? -eq 0 ]; then
    cargo run $1
fi