signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v12.5_x86-64_vnni_windows.exe
signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v12.5_x86-64_avx512_windows.exe
signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v12.5_x86-64_avx2_windows.exe
signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v12.5_x86-64_sse41_windows.exe

