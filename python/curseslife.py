#!/usr/bin/env python
import curses
import random

W = 70
H = 24
LENGTH = W * H

def coord(x,y):
    return x+(W*y)

# Gotta be a better way of doing this.
# Does not handle edge cases.
def numNeighbors(x,y,field):
    num = 0
    if field[coord(x-1,y-1)]: num += 1
    if field[coord(x,y-1)]:   num += 1
    if field[coord(x+1,y-1)]: num += 1
    if field[coord(x-1,y)]:   num += 1
    if field[coord(x+1,y)]:   num += 1
    if field[coord(x-1,y+1)]: num += 1
    if field[coord(x,y+1)]:   num += 1
    if field[coord(x+1,y+1)]: num += 1
    return num

def update(field):
    newfield = [False] * LENGTH
    for i in range(W-1):
        for j in range(H-1):
            if numNeighbors(i,j,field) < 2: newfield[coord(i,j)] = False
            elif numNeighbors(i,j,field) > 3: newfield[coord(i,j)] = False
            else: newfield[coord(i,j)] = True
    return newfield

def draw(scr,field):
    for i in range(W):
        for j in range(H):
            if field[coord(i,j)]:
                scr.addch(j,i,'@')
            else:
                scr.addch(j,i,'.')

def main(scr):
    random.seed()
    field = [False] * LENGTH
    for i in range(LENGTH):
        #field[i] = random.choice([True,False])
        if i%2 == 0:
            field[i] = True

    while True:
        field = update(field)
        draw(scr,field)
        scr.refresh()
        scr.timeout(250)
        char = scr.getch()
        if char > -1:
            break

if __name__ == '__main__':
   curses.wrapper(main)
