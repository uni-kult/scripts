#!/bin/bash
set -euf -o pipefail

echo $((RANDOM % (65535 - 49152 + 1) + 49152))
