@echo off
setlocal

set "VER=15.0.0.0"
set "COMPANY=M&R Research Team London"
set "DESC=chess engine"
set "COPY=Copyright (C) 2022-2026"
set "PRODUCT=Vafra Cfish clone"
set "ICON=cfish.ico"

rem Clear read-only and MOTW just in case
attrib -R cfish_v15.0_*.exe >nul 2>&1
powershell -NoProfile -Command "Get-Item cfish_v15.0_*_win.exe -ErrorAction SilentlyContinue | Unblock-File" >nul 2>&1

for %%F in (
  cfish_v15.0_x86-64-vnni_win.exe
  cfish_v15.0_x86-64-avx512_win.exe
  cfish_v15.0_x86-64-avx2_win.exe
  cfish_v15.0_x86-64-sse41_win.exe
) do (
  if exist "%%F" (
    echo Patching %%F

    call :try rcedit-x64.exe "%%F" --set-icon "%ICON%"
    call :try rcedit-x64.exe "%%F" --set-file-version %VER% --set-product-version %VER%
    call :try rcedit-x64.exe "%%F" --set-version-string "CompanyName" "%COMPANY%"
    call :try rcedit-x64.exe "%%F" --set-version-string "FileDescription" "%DESC%"
    call :try rcedit-x64.exe "%%F" --set-version-string "LegalCopyright" "%COPY%"
    call :try rcedit-x64.exe "%%F" --set-version-string "ProductName" "%PRODUCT%"
    call :try rcedit-x64.exe "%%F" --set-version-string "OriginalFilename" "%%F"

    rem small pause before next file (lets Explorer/AV release handles)
    timeout /t 1 /nobreak >nul
  ) else (
    echo Skipping %%F (not found)
  )
)

echo Done.
endlocal
exit /b 0

:try
rem usage: call :try <command> <args...>
set /a __tries=0
:again
%* 1>nul 2>nul && exit /b 0
set /a __tries+=1
if %__tries% GEQ 6 (
  rem last attempt (show error this time)
  %*
  if errorlevel 1 echo ERROR: %* & exit /b 1
  exit /b 0
)
timeout /t 1 /nobreak >nul
goto again
