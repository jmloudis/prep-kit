from machine import Machine
import asyncio

def initialize_machines(rate, count, name):
    return [Machine(name, rate) for _ in range(count)]

def minutes_to_print(books, machines):
    total_rate_per_hour = sum(machine.rate for machine in machines)
    return (books / total_rate_per_hour) * 60

async def minutes_to_print_async(books, machines):
    await asyncio.sleep(0)  # Simulate async work
    total_rate_per_hour = sum(machine.rate for machine in machines)
    return (books / total_rate_per_hour) * 60

def main():
    machines = []
    machines += initialize_machines(600, 10, "Standard Printer")
    machines += initialize_machines(1200, 2, "Speed Printer")
    machines += initialize_machines(300, 5, "Old Printer")

    # Synchronous calculation
    sync_result = minutes_to_print(10000, machines)
    print(f"Synchronous time for 10,000 books: {sync_result} minutes")

    # Asynchronous calculation
    async def run_async():
        future1 = asyncio.create_task(minutes_to_print_async(10000, machines))
        future2 = asyncio.create_task(minutes_to_print_async(5000, machines))
        await asyncio.gather(future1, future2)
        print(f"Time for 10,000 books: {future1.result()} minutes")
        print(f"Time for 5,000 books: {future2.result()} minutes")

    asyncio.run(run_async())

if __name__ == "__main__":
    main()