import thread, time

threadmax = 5
currentthread = 0

def pr( x, starttime ):
   global currentthread
   time.sleep( 5 )
   print 'Thread', x, 'finished'
   print 'Elapsed time = ', (time.time() - starttime)
   currentthread -= 1

start = time.time()


while 1:
   if currentthread < threadmax:
      currentthread += 1
      alpha = thread.start_new_thread( pr, (currentthread, time.time()) )
      print 'New thread started:', currentthread
   else:
      pass

