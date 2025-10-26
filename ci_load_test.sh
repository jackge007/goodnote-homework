#!/bin/bash

# foo load test 
time fortio load -qps 5000 -t 60s -c 8 -r 0.0001 http://foo.localhost/ -json ci_foo_load_test.json | tee ci_foo_load_test.log

# bar load test
time fortio load -qps 5000 -t 60s -c 8 -r 0.0001 http://bar.localhost/ -json ci_bar_load_test.json | tee ci_bar_load_test.log
