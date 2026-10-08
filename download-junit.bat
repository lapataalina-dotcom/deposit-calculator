@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

if not exist lib mkdir lib
set "BASE=https://repo.maven.apache.org/maven2"

echo === Скачивание 7 JAR-файлов JUnit 5 в lib\ ===

call :dl org/junit/jupiter/junit-jupiter-api/5.14.4 junit-jupiter-api-5.14.4.jar || goto :fail
call :dl org/junit/jupiter/junit-jupiter-engine/5.14.4 junit-jupiter-engine-5.14.4.jar || goto :fail
call :dl org/junit/platform/junit-platform-commons/1.14.4 junit-platform-commons-1.14.4.jar || goto :fail
call :dl org/junit/platform/junit-platform-engine/1.14.4 junit-platform-engine-1.14.4.jar || goto :fail
call :dl org/junit/platform/junit-platform-launcher/1.14.4 junit-platform-launcher-1.14.4.jar || goto :fail
call :dl org/opentest4j/opentest4j/1.3.0 opentest4j-1.3.0.jar || goto :fail
call :dl org/apiguardian/apiguardian-api/1.1.2 apiguardian-api-1.1.2.jar || goto :fail

echo.
echo === Готово. Содержимое lib\: ===
dir /b lib\*.jar
echo.
echo Дальше: ant test   (или run-all.bat)
exit /b 0

:dl
if exist "lib\%~2" (
    echo [пропуск] %~2 уже есть
    exit /b 0
)
echo [загрузка] %~2
powershell -NoProfile -ExecutionPolicy Bypass -Command "$ProgressPreference='SilentlyContinue'; try { Invoke-WebRequest -UseBasicParsing -Uri '%BASE%/%~1/%~2' -OutFile 'lib\%~2' -ErrorAction Stop } catch { Write-Host $_.Exception.Message; exit 1 }"
if errorlevel 1 (
    del "lib\%~2" >nul 2>&1
    exit /b 1
)
exit /b 0

:fail
echo.
echo [ОШИБКА] Не удалось скачать файл. Проверьте интернет/прокси и запустите скрипт ещё раз.
echo Запасной вариант: mvn dependency:copy-dependencies -DoutputDirectory=lib -DincludeScope=test
exit /b 1
