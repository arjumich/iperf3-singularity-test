import sys
import math

argument_from_shell = int(sys.argv[1])

delay=argument_from_shell


CALC_DELAY=delay*0.001
BYTE=1048576
BANDWIDTH=2500
PRODUCT=2*BANDWIDTH*CALC_DELAY
BUF_SIZE_MB=PRODUCT*0.125
BUF_SIZE_BYTE=BUF_SIZE_MB*BYTE

BUF=math.floor(BUF_SIZE_BYTE)

print(BUF)
