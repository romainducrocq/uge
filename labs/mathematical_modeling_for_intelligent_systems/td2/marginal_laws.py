#!/usr/bin/python

import sys
import math

def help():
    print("./marginal_law.py p[1:3] xtild[1:3] p0[1:4]")
    print("     p: [1/3, 1/2, 2/3]")
    print("     xtild: [E/3, E/2, E*2/3]")
    print("     p0: [[1,0,...,0], [0,...,0,1], [0,0,0,0,0,0,0,0,1], [0,...,1 (at position xtild),...,0], [1/(E+1),...,1/(E+1)]")
    exit()

E = 10
n = 10

p_set = [1/3., 1/2., 2/3.]
xtild_set = [E/3., E/2., E*2/3.]

p = 0
xtild = 0

pN = [[0 for x in range(E+1)] for y in range(n+1)]

if len(sys.argv) == 4:
    if int(sys.argv[1]) >= 1 and int(sys.argv[1]) <= 3:
        p = p_set[int(sys.argv[1])-1]
    else:
        help()
    if int(sys.argv[2]) >= 1 and int(sys.argv[2]) <= 3:
        xtild = xtild_set[int(sys.argv[2])-1]
    else:
        help()
    if int(sys.argv[3]) >= 1 and int(sys.argv[3]) <= 4:
        if int(sys.argv[3]) == 1:
            pN[0][0] = 1
        elif int(sys.argv[3]) == 2:
            pN[0][-1] = 1
        elif int(sys.argv[3]) == 3:
            pN[0][int(math.floor(xtild))] = 1
        elif int(sys.argv[3]) == 4:
            pN[0] = [1./(E+1) for x in range(E+1)]
    else:
        help()
else:
    help()

matrix = [[0 for x in range(E+1)] for y in range(E+1)]
for x in range(E+1) :
    if x <= int(math.floor(xtild)) :
        matrix[x][x] = p
        matrix[x][x+1] = 1-p
    else :
        matrix[x][x] = p
        matrix[x][x-1] = 1-p

for i in range(n):
    for j in range(E+1):
        for k in range(E+1):
            pN[i+1][j] += pN[i][k] * matrix[k][j]

print("E = 10, n = 10")
print("p = " + str(p))
print("xtild = " + str(xtild))
print("p0 = " + str(pN[0]))

print("")
print("M = ")
for x in matrix:
    print(x)

print("")
print("pN+1 = pN*M")
i = 0
for p in pN:
    print("p" + str(i) + ": " + str(p))
    i+=1

exit()
