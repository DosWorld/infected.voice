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
tasm 80.asm /m2 > nul
tlink 80.obj /t >nul
del 80.obj
del 80.map
echo [RC80]  (c) Populizer (1996)   