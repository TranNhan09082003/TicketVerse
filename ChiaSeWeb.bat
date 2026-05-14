@echo off
title Cong cu chia se web TicketVerse
color 0A

echo ===================================================
echo   KHOI DONG HE THONG CHIA SE WEB (LOCALTUNNEL)
echo ===================================================
echo.
echo Dang khoi tao Proxy de vuot tuong lua IIS Express...
start cmd /k "title IIS Express Proxy & npx iisexpress-proxy 62642 to 8080"
timeout /t 3 >nul

:start_tunnel
echo.
echo ===================================================
echo Dang tao duong link Online... (Neu bi ngat se tu dong tao lai)
echo ===================================================
call npx localtunnel --port 8080
echo.
echo [!] Duong ham bi dong dot ngot do mang! Tu dong ket noi lai sau 3 giay...
timeout /t 3 >nul
goto start_tunnel
