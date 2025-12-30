#!/bin/bash
set -a
source .env
set +a
sbt "runMain com.habittracker.Main"