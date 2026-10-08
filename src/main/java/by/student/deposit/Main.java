package by.student.deposit;

import by.student.deposit.model.Deposit;
import by.student.deposit.service.DepositCalculator;

/**
 * Минимальная точка входа в приложение.
 */
public class Main {

    public static void main(String[] args) {

        // Демонстрационный вклад:
        // 1000 BYN, 10% годовых, 3 года, капитализация.
        Deposit deposit =
                new Deposit(1000, 10, 3, true);

        DepositCalculator calculator =
                new DepositCalculator();

        System.out.println(
                calculator.buildReport(deposit));
    }
}
