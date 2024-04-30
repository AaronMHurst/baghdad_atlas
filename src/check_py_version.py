from __future__ import print_function
import sys

major_version = int(sys.version_info[0])
minor_version = int(sys.version_info[1])
micro_version = int(sys.version_info[2])

if major_version == 2:
    print("You're running Python 2 version {0}.{1}.{2}"
    .format(major_version,minor_version,micro_version))

    if minor_version < 7:
        print("Consider upgrading to Python 2.7 or higher")

elif major_version == 3:
    print("You're running Python 3 version {0}.{1}.{2}"
    .format(major_version,minor_version,micro_version))
