#!/bin/bash
set -e

cargo build
if [ $? -eq 0 ]; then
    cargo run
fi