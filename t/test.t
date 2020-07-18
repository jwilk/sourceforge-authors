#!/usr/bin/env bash

# Copyright © 2020 Jakub Wilk <jwilk@jwilk.net>
# SPDX-License-Identifier: MIT

set -e -u
echo 1..1
base="${0%/*}/.."
prog="$base/sourceforge-authors"
if [ -z "${SOURCEFORGE_AUTHORS_ONLINE_TESTS-}" ]
then
    echo 'SOURCEFORGE_AUTHORS_ONLINE_TESTS is not set' >&2
    echo 'not ok 1'
    exit 1
fi
exp=$'jakub-wilk = jakub-wilk <jakub-wilk@users.sourceforge.net>\n(no author) = nobody <nobody@users.sourceforge.net>\n'
out=$("$prog" jakub-wilk '(no author)')
diff=$(diff -u <(printf '%s' "$exp") <(printf '%s\n' "$out")) || true
if [ -z "$diff" ]
then
    echo 'ok 1'
else
    sed -e 's/^/# /' <<< "$diff"
    echo 'not ok 1'
fi

# vim:ts=4 sts=4 sw=4 et ft=sh
