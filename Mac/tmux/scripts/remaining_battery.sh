#!/bin/bash

pmset -g ps  |  sed -n 's/.*[[:blank:]]+*\(.*%\).*/\1/p'
