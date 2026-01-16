package Machine;

# Constructor
sub new {
    my ($class, $name, $rate) = @_;
    my $this = {
        name => $name,
        rate => $rate,
    };
    return bless $this, $class;
}

# Class attribute accessors (like public fields/getters)
sub name {
    my $self = shift;
    $self->{name} = shift if @_;
    return $self->{name}
}

sub rate {
    my $self = shift;
    $self->{rate} = shift if @_;
    return $self->{rate}
}


1;