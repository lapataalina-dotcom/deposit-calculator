@echo off
chcp 65001 >nul
setlocal
cd /d "%~dp0"

where ant >nul 2>&1
if errorlevel 1 goto :noant
where mvn >nul 2>&1
if errorlevel 1 goto :nomvn
if not exist "lib\junit-jupiter-engine-5.14.4.jar" goto :nolib

echo ===== [1/7] ant clean =====
call ant clean || goto :fail
echo ===== [2/7] ant test =====
call ant test || goto :fail
echo ===== [3/7] ant report =====
call ant report || goto :fail
echo ===== [4/7] ant jar =====
call ant jar || goto :fail
echo ===== [5/7] ant run =====
call ant run || goto :fail
echo ===== [6/7] mvn clean verify =====
call mvn -B clean verify || goto :fail
echo ===== [7/7] mvn surefire-report:report =====
call mvn -B surefire-report:report || goto :fail

echo.
echo ============================================================
echo  ВСЁ УСПЕШНО. Где искать результаты:
echo.
echo  Ant   XML-отчёты : build\reports\xml\
echo  Ant   HTML-отчёт : build\reports\html\index.html
echo  Ant   JAR        : build\jar\DepositCalculator.jar
echo.
echo  Maven XML/TXT    : target\surefire-reports\
echo  Maven HTML-отчёт : target\site\surefire-report.html
echo  Maven JAR        : target\deposit-calculator-1.0.0-SNAPSHOT.jar
echo ============================================================
exit /b 0

:noant
echo [ОШИБКА] ant не найден в PATH. Добавьте D:\programm\Apache Ant\apache-ant-1.10.18\bin и откройте новый терминал.
exit /b 1

:nomvn
echo [ОШИБКА] mvn не найден в PATH.
exit /b 1

:nolib
echo [ОШИБКА] В lib\ нет JAR-файлов JUnit. Сначала запустите download-junit.bat
exit /b 1

:fail
echo.
echo [ОШИБКА] Шаг завершился неуспешно, дальнейшие шаги пропущены. Смотрите вывод выше.
exit /b 1
