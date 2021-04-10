#!/usr/bin/bash

kill -9 $(fuser 1099/tcp 2>/dev/null)
kill -9 $(fuser 2000/tcp 2>/dev/null)

