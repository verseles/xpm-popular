#!/usr/bin/env sh

# Enable immediate output on error. This is a POSIX option.
set -o errexit
# Treat undefined variables as an error. This is a POSIX option.
set -o nounset

# Check if the script is being run with BASH.
if [ -n "$BASH_VERSION" ]; then
    # Enable pipefail only if we're in bash, as it's not POSIX.
    # pipefail makes the exit status of a pipeline the same as the last command to fail.
    set -o pipefail
fi

# Enable debug mode (xtrace) if the TRACE environment variable is set to "1".
if [ "${TRACE:-0}" = "1" ]; then
    set -o xtrace # 'set -x' is a shorter equivalent and also POSIX.
fi
