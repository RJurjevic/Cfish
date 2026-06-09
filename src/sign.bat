signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v15.0_x86-64-vnni_win.exe
signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v15.0_x86-64-avx512_win.exe
signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v15.0_x86-64-avx2_win.exe
signtool sign /v /tr http://timestamp.digicert.com /f VafraCA.pfx /fd SHA256 /td SHA256 cfish_v15.0_x86-64-sse41_win.exe

