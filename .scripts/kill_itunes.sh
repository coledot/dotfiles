#! /bin/bash

pids=`ps axuww | grep 'iTunes.app' | grep -v 'iTunesHelper' | grep -v grep | awk '{print $2}'`

if [ ! -z $pids ]; then
	kill $pids;
fi

