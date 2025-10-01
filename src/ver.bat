@echo off
setlocal

set "VER=12.8.0.0"
set "COMPANY=M&R Research Team London"
set "DESC=chess engine"
set "COPY=Copyright (C) 2022-2025"
set "PRODUCT=Vafra Cfish clone"

for %%F in (
  cfish_v12.8_x86-64_vnni_windows.exe
  cfish_v12.8_x86-64_avx512_windows.exe
  cfish_v12.8_x86-64_avx2_windows.exe
  cfish_v12.8_x86-64_sse41_windows.exe
) do (
  if exist "%%F" (
    echo Patching %%F
    rcedit-x64.exe "%%F" --set-file-version %VER% --set-product-version %VER%
    rcedit-x64.exe "%%F" --set-version-string "CompanyName" "%COMPANY%"
    rcedit-x64.exe "%%F" --set-version-string "FileDescription" "%DESC%"
    rcedit-x64.exe "%%F" --set-version-string "LegalCopyright" "%COPY%"
    rcedit-x64.exe "%%F" --set-version-string "ProductName" "%PRODUCT%"
    rcedit-x64.exe "%%F" --set-version-string "OriginalFilename" "%%F"
  ) else (
    echo Skipping %%F (not found)
  )
)

echo Done.
endlocal
