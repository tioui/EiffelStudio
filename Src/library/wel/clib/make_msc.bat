@echo off
echo ------------------------------------------------------------------------
echo Compiling Wel.lib
echo ------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile.msc 

echo ------------------------------------------------------------------------
echo Compiling mousehook.dll
echo ------------------------------------------------------------------------
nmake /NOLOGO /C /S /f makefile_dll.msc

echo ------------------------------------------------------------------------
echo done.
echo ------------------------------------------------------------------------
