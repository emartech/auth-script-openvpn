#!/bin/bash

CC=cc
CFLAGS="-O -Wall -Wextra -Wformat-security -D_FORTIFY_SOURCE=2 -std=c99 -D_POSIX_C_SOURCE=200809L -fstack-protector-strong"
LDFLAGS="-fPIC -shared"

$CC $CFLAGS $LDFLAGS -o openvpn-plugin-auth-script.so openvpn-plugin-auth-script.c
