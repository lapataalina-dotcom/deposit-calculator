# deposit-calculator

Лабораторная работа №2 «Инструменты и средства разработки сценариев в системах непрерывной интеграции» (БГУИР, каф. ЭИ).
Калькулятор банковского вклада (простые проценты и капитализация), собираемый тремя системами: **Ant**, **Maven**, **Gradle**.

## Требования

- JDK 17+ (проверено на JDK 21), `javac`/`java` в PATH
- Apache Ant 1.10.x (с `ant-junitlauncher.jar` в `ANT_HOME\lib`)
- Apache Maven 3.9.x
- (опционально) Gradle для создания Wrapper

## Быстрый старт (Windows, CMD/PowerShell)

```bat
cd C:\Users\mi\IdeaProjects\deposit-calculator
download-junit.bat
run-all.bat
```

Подробная пошаговая инструкция: [ЗАПУСК.md](ЗАПУСК.md).

## Основные команды

| Инструмент | Команда | Результат |
|---|---|---|
| Ant | `ant -p` | список targets |
| Ant | `ant clean test report jar run` | тесты, HTML-отчёт, JAR, запуск |
| Ant | `ant all` | полная чистая сборка |
| Maven | `mvn clean verify` | компиляция, тесты, JAR |
| Maven | `mvn surefire-report:report` | `target\site\surefire-report.html` |
| Gradle | `gradlew.bat build` | тесты + JAR (после создания Wrapper) |

## Структура

```
deposit-calculator/
├── src/main/java/by/student/deposit/{Main.java, model/Deposit.java, service/DepositCalculator.java}
├── src/test/java/by/student/deposit/DepositCalculatorTest.java
├── lib/                    JAR-ы JUnit 5 для Ant (скачивает download-junit.bat)
├── build.xml               Ant
├── pom.xml                 Maven
├── build.gradle, settings.gradle   Gradle (расширение)
├── .github/workflows/maven.yml     GitHub Actions (расширение)
├── download-junit.bat, run-all.bat
└── README.md, ЗАПУСК.md
```

## Артефакты

- Ant: `build\reports\xml`, `build\reports\html\index.html`, `build\jar\DepositCalculator.jar`
- Maven: `target\surefire-reports`, `target\site\surefire-report.html`, `target\deposit-calculator-1.0.0-SNAPSHOT.jar`
- Gradle: `build\reports\tests\test\index.html`, `build\libs\deposit-calculator-1.0.0-SNAPSHOT.jar`
