package com.northstarcomm.javaprep.problems.interview.printerproblem;

public class Machine {

    public int rate;
    public String name;

    public Machine(String name, int ratePerHour) {
        this.name = name;
        this.rate = ratePerHour;
    }

    public int getRate() {
        return rate;
    }

    public void setRate(int rate) {
        this.rate = rate;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String toString() {
        return this.name + '_' + this.rate;
    }

}

