@echo off
cls
echo .									.
echo      ▄▄                  █
echo     ▀▀▀  Virus Magazine  █ Box 10, Kiev 148, Ukraine       IV  1996
echo     ▀██ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ █ ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀ ▀ ▀▀▀▀▐▀▀▀  █▀▀▀▀▀▀█
echo      ▐█ █▀▄ █▀▀ ▄▀▀ ▄▀▀ ▄█▄ ▄▀▀ █▀█    ▌ █ ▄▀█ █ ▄▀▀ █▄▄   █ █▀▀█ █ 
echo       █ █ █ █▀  █▀  █    █  █▀  █ █    █ █ █ █ █ █   █     █ ▀▀▀█ █
echo       █ ▐ ▐ ▐   ▐▄▄ ▐▄▄  ▐  ▐▄▄ ▐▄▀     ▀█ ▀▄█ ▐ ▐▄▄ ▐▄▄▄  █ █▄▄█ █
echo       ▐ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  █▄▄▄▄▄▄█
echo       (C) Copyright, 1994-96, by STEALTH group WorldWide, unLtd.
echo .									.
tasm obj.asm /m2 > nul
tlink obj.obj /t >nul
del obj.obj
del obj.map
echo [Obj-Infector]  (c) IntMaster (1996)   