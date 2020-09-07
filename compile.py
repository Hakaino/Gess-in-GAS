#!/usr/bin/env python
import os
import sys

if __name__ == '__main__':
	if len(sys.argv) == 2:
		original = sys.argv[1] + ".as"
		obj = sys.argv[1] + ".o"
		command = "as %s -o %s; ld -s -o %s %s; ./%s" %(original, obj, sys.argv[1], obj, sys.argv[1])
		print("\n")
		os.system(command)
		print("\n")
	else:
		print("enter the name of the file without the extention")
