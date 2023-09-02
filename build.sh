#!/bin/bash
#need this top comment so the environment knows to use bash to run this file

#bash ./setvars.sh
#if [ $? != 0 ]; then  exit 1; fi 

# Create fresh build dir
if [ -d "c_build" ]; then
    rm -r c_build
    mkdir c_build
 else
    mkdir c_build
    echo "made c_build _______________________________________________________"
fi

if [ $? != 0 ]; then  exit 1; fi 
 
# Build C library
cd c_build
if [ $? != 0 ]; then  exit 1; fi
echo "SWITCHED TO C_BUILD_____________________________________"
cd ../src/ias_lib
#gcc -O2 -c ../src/ias_lib/*.c 
gcc -O2 -c -fPIC *.c
if [ $? != 0 ]; then  exit 1; fi
echo "COMPILED C FILES__________________________________________________"
cp -v *.o ../../c_build #should move the object files into the build directory
#the cp command wasn't working because I wasn't in the correct directory to move it, so it couldn't see the files
#I need it to compile the library in the cd build directory
#ar rcs l8ang.a *.o
cd ../../c_build
if [ $? != 0 ]; then  exit 1; fi  #exit status of 0 means command executed successfully
echo "MOVING OBJECT FILES________________________________________________"
gcc -v -shared -o l8ang.so *.o #added a -fPIC tag to the makefile and it worked"

#gcc -v -l l8ang.so *.o

#ar -v -rc l8ang.a *.o



if [ $? != 0 ]; then  exit 1; fi 
echo "COMPILED INTO SHARED LIBRARIES__________________________________"
rm *.o #should clear the current directory of all obj files
if [ $? != 0 ]; then  exit 1; fi 
echo "REMOVED OBJECT FILES____________________________________"

#gcc -O2 -c ../src/*.c
cd ../src
gcc -O2 -c -fPIC *c
echo "COMPILED SRC FILE___________________________"
cp -v *.o ../c_build
if [ $? != 0 ]; then  exit 1; fi 
echo "MOVED THEM"
cd ../c_build
#lib *.obj l8ang.lib /out:..\l8_angles.lib

gcc -v -shared -o libl8_angles.so *.o 

#gcc -v -l l8_angles.so *.o

#ar -v rcs l8_angles.a *.o l8ang.a



echo "MADE STATIC LIBRARY_____________________________"
if [ $? != 0 ]; then  exit 1; fi 
echo "COMPILED SO FILE_________________________________"
#cp -v libl8angles.so ../src
#cp -v libl8angles.so ../
#cp -v libl8angles.so ../src/ias_lib
#cp -v l8ang.so ../src/ias_lib
#cp -v l8_angles.so ../src
#cp -v l8_angles.so ../
if [ $? != 0 ]; then  exit 1; fi 

cd ..

echo "SUCCESS, EVERYTHING SHOULD HAVE WORKED___________________________"

# Setup python package
echo "starting setup.py___________________________________________________"
#python setup.py install I don't think I can use install, here, because that is installing the module
python setup.py bdist_wheel
pip install . 
#stuck here now

if [ $? != 0 ]; then  exit 1; fi 

#compile everything, then run the setup.py

