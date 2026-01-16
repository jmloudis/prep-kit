package com.northstarcomm.javaprep.problems.interview.printerproblem;

import java.util.*;
import java.util.concurrent.CompletableFuture;

public class PrinterProblem {

    /**
     * Printing Service -> printer can print number of books per rate
     *
     * order - how long will it take to print that amount of books.
     * 10 standard printers - print 600 books per hour, figure out how many minutes will it take to produce x amount of books.
     * 2 speed printers - print 1200 books per hour.
     *
     * How to make this asynchronous for multiple calls to the service
     *
     */
    public static void main(String[] args) {

        ArrayList<Machine> machines = new ArrayList<Machine>();
        machines.addAll(initializeMachines(600, 10, "Standard Printer"));
        machines.addAll(initializeMachines(1200, 2, "Speed Printer"));
        machines.addAll(initializeMachines(300, 5, "Old Printer"));

        CompletableFuture<Double> future1 = minutesToPrintAsync(10000, machines);
        CompletableFuture<Double> future2 = minutesToPrintAsync(5000, machines);

        CompletableFuture.allOf(future1, future2).join();

        try {
            System.out.println("Time for 10,000 books: " + future1.get() + " minutes");
            System.out.println("Time for 5,000 books: " + future2.get() + " minutes");
        } catch (Exception e) {
            e.printStackTrace();
        }

//        System.out.println(minutesToPrint(10000, machines));

    }

    public static double minutesToPrint(int books, ArrayList<Machine> machines) {
        int totalRatePerHour = 0;
        for (Machine machine : machines) {
            totalRatePerHour += machine.getRate();
        }
        System.out.println(totalRatePerHour);
        System.out.println(books);
        return ((double) books / totalRatePerHour) * 60;

    }

    /**
     *
     * Asynchronous version of minutesToPrint
     */
    public static CompletableFuture<Double> minutesToPrintAsync(int books, ArrayList<Machine> machines) {
        return CompletableFuture.supplyAsync(() -> {
            int totalRatePerHour = 0;
            for (Machine machine : machines) {
                totalRatePerHour += machine.getRate();
            }
            return ((double) books / totalRatePerHour) * 60;
        });
    }

    public static ArrayList<Machine> initializeMachines(int rate, int count, String name) {
        ArrayList<Machine> machines = new ArrayList<Machine>();
        for (int i = 0; i < count; i++) {
            machines.add(new Machine(name, rate));
        }
        return machines;
    }


}
