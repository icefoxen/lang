#make standalone, needs at least pygame-1.4 and py2exe-0.3.1

from distutils.core import setup
import py2exe, sys, os, pygame, shutil

#setup the project variables here.
#i can't claim these will cover all the cases
#you need, but they seem to work for all my
#projects, just change as neeeded.

project_name = "test2" #name for EXE
project_script = "test2.py" #name of base .PY
icon_file = "" #ICO file for the .EXE
optimize = 2 #0, 1, or 2; like -O and -OO
dos_console = 0 #set to 1 to run in a DOS box (for debugging)
extra_data = ['liquid.bmp', 'player1.gif'] #list of extra files/dirs copied to game
extra_modules = [] #list of extra python modules not automatically found






#use the default pygame icon, if none given
if not icon_file:
    path = os.path.split(pygame.__file__)[0]
    icon_file = '"' + os.path.join(path, 'pygame.ico') + '"'
#unfortunately, this cool icon stuff doesn't work in current py2exe :(
#icon_file = ''


#create the proper commandline args
args = ['py2exe', '--force', '-O'+`optimize`]
args.append(dos_console and '--console' or '--windows')
if icon_file:
    args.append('--icon')
    args.append(icon_file)
args.append('--force-imports')
args.append(','.join(extra_modules))
#args.append(','.join(pygame_modules + extra_modules))
sys.argv[1:] = args + sys.argv[1:]


#this will create the executable and all dependencies
setup(name=project_name, scripts=[project_script])

#also need to hand copy the extra files here
def installfile(name):
    dst = os.path.join('dist', project_name)
    print 'copying', name, '->', dst
    if os.path.isdir(name):
        dst = os.path.join(dst, name)
        if os.path.isdir(dst):
            shutil.rmtree(dst)
        shutil.copytree(name, dst)
    elif os.path.isfile(name):
        shutil.copy(name, dst)
    else:
        print 'Warning, %s not found' % name




pygamedir = os.path.split(pygame.base.__file__)[0]
installfile(os.path.join(pygamedir, 'helmetb.ttf'))
installfile(os.path.join(pygamedir, 'pygame_icon.bmp'))
for data in extra_data:
    installfile(data)
