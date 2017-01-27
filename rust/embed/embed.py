#!/usr/bin/env python3

from ctypes import cdll

lib = cdll.LoadLibrary("target/debug/libembed.so")
lib.process()

print("Done!")
