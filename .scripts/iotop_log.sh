#! /usr/bin/env bash
sudo iotop 1 | ack 'load|\bW\b' | tee -a writes.out
