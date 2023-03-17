@echo off
echo Sets environment variables for FREEMAX build

REM Now set stuff we need
Set COPYCMD=/Y
Set MAXROOT=Z:\MAX\
Set MBLDOUT=Z:\RELEASE\OUT
Set MBLDREQ=Z:\RELEASE\BUILDREQ\
Set BLDOUT=%MBLDOUT%
Set BLDREQ=%MBLDREQ%
Set LNKCMD=
SET PATH=Z:\MSVC\BIN;Z:\TOOLS;%PATH%
Set MSVC16=Z:\MSVC\

z:
cd max
