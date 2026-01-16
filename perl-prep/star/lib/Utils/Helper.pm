package Utils::Helper;

use Dancer2;
use File::Path qw(make_path);
use Log::Log4perl;


sub new {
    my $class = shift;
    my $this = bless {
        @_
    }, $class;
    $this->logger_init();
    $this->{'example'}->{'test-key'} = 'test-value';
    return($this);
}

sub logger_init {
    my $self = shift;
    return if defined $self->{'logger'};
    ## Only applies if helper is being created as a stand-alone object
    $self->{'logger'} = Log::Log4perl->get_logger("Utils::Helper");
}

sub get_message {
    return "Hello from the custom Helper module!";
}

# Need to setup Master Logger and init logger
sub log_message {
    my $self = shift;
    $self->{'logger'}->info("Logging a message from Utils::Helper");
}

1;