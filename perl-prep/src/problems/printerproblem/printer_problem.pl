#!/opt/homebrew/bin/perl

use lib '.'; # Look for modules (like Machine.pm) in the current directory
use Dancer2;
use Machine;
use Future;
use List::Util qw(sum); # For cleaner rate summation

# --- Function Prototypes (equivalent to static methods) ---

# Initializes machine objects
sub initialize_machines {
    my ($rate, $count, $name) = @_;
    my @machines;
    for (1 .. $count) {
        push @machines, Machine->new($name, $rate);
    }
    return \@machines; # Returns an ARRAY REFERENCE
}

# Synchronous version of minutesToPrint
sub minutes_to_print {
    my ($books, $machines_ref) = @_;

    # Calculate total rate using List::Util::sum and map()
    my $total_rate_per_hour = sum( map { $_->rate } @$machines_ref );

    return ($books / $total_rate_per_hour) * 60;
}

# Asynchronous version of minutesToPrint
sub minutes_to_print_async {
    my ($books, $machines_ref) = @_;

    # Future->supply simply wraps the calculation in a Future object.
    # The actual async execution requires an event loop (e.g., AnyEvent, Mojo::IOLoop)
    # in a real concurrent environment, but Future simulates the return type.
    return Future->new( sub {
        my $f = shift;

        # Calculate total rate
        my $total_rate_per_hour = sum(
            map {
                $_->rate
            } @$machines_ref
        );

        my $result = ($books / $total_rate_per_hour) * 60;

        $f->done($result); # Signal that the Future is complete
    });
}

# --- Main Logic (equivalent to public static void main) ---

sub main {
    my @all_machines;

    # Add machines from helper functions to the main array
    push @all_machines, @{initialize_machines(600, 10, "Standard Printer")};
    push @all_machines, @{initialize_machines(1200, 2, "Speed Printer")};
    push @all_machines, @{initialize_machines(300, 5, "Old Printer")};

    # # Asynchronously calculate print times
    # my $future1 = minutes_to_print_async(10000, \@all_machines);
    # my $future2 = minutes_to_print_async(5000, \@all_machines);
    #
    # # Wait for all futures to complete (equivalent to CompletableFuture.allOf().join())
    #
    # # How to wait until all futures are done
    #
    # # Extract results
    # my $result1 = $future1->get;
    # my $result2 = $future2->result;
    #
    # # Print results
    # print("Time for 10,000 books: $result1 minutes");
    # print("Time for 5,000 books: $result2 minutes");

    # Uncomment to test synchronous version:
    my $sync_result = minutes_to_print(10000, \@all_machines);
    print("Synchronous time for 10,000 books: $sync_result minutes");
}

main();