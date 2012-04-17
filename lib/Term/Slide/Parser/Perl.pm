package Term::Slide::Parser::Perl;
use strict;
use warnings;

use Carp;

sub new {
    my ($class, $file) = @_;

    my $data = do $file or Carp::croak 'cannot read slide';
    return bless +{ __data => $data }, $class;
}

sub data { return $_[0]->{__data}; }

1;

__END__
