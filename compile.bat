@echo off 
set Path=%cd%\;%Path%
set TYPST_FONT_PATHS=%cd%\fonts
typst --font-path fonts compile thesis.typ
echo ���н�������������˳�
pause>nul