package by.student.deposit.service;

import by.student.deposit.model.Deposit;

/**
 * Сервис содержит бизнес-логику расчёта вклада.
 *
 * Важно: в классе нет кода Ant/Maven/Gradle.
 * Поэтому один и тот же класс можно собирать
 * разными build-системами.
 */
public class DepositCalculator {

    /**
     * Расчёт по простой формуле процентов.
     */
    public double calculateSimple(Deposit deposit) {
        return deposit.getPrincipal()
                * (1
                + deposit.getAnnualRate()
                * deposit.getYears()
                / 100.0);
    }

    /**
     * Расчёт по сложной формуле с капитализацией.
     */
    public double calculateCompound(Deposit deposit) {
        return deposit.getPrincipal()
                * Math.pow(
                    1 + deposit.getAnnualRate() / 100.0,
                    deposit.getYears());
    }

    /**
     * Выбор алгоритма расчёта.
     */
    public double calculateTotal(Deposit deposit) {
        return deposit.isCapitalization()
                ? calculateCompound(deposit)
                : calculateSimple(deposit);
    }

    /**
     * Сумма начисленных процентов.
     */
    public double calculateInterest(Deposit deposit) {
        return calculateTotal(deposit)
                - deposit.getPrincipal();
    }

    /**
     * Формирование демонстрационного отчёта.
     */
    public String buildReport(Deposit deposit) {
        StringBuilder sb = new StringBuilder();

        sb.append("=== Отчёт по вкладу ===\n");
        sb.append(String.format(
                "Начальная сумма: %.2f BYN%n",
                deposit.getPrincipal()));
        sb.append(String.format(
                "Ставка: %.2f%%%n",
                deposit.getAnnualRate()));
        sb.append(String.format(
                "Срок: %d лет%n",
                deposit.getYears()));
        sb.append(String.format(
                "Капитализация: %s%n",
                deposit.isCapitalization() ? "да" : "нет"));
        sb.append(String.format(
                "Итоговая сумма: %.2f BYN%n",
                calculateTotal(deposit)));
        sb.append(String.format(
                "Начислено процентов: %.2f BYN%n",
                calculateInterest(deposit)));

        return sb.toString();
    }
}
