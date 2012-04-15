package Term::Slide;
use strict;
use warnings;
use 5.14.2;
our $VERSION = '0.01';

use Term::Screen;

my $slides = [
    +{
        content => [
            +{ content => 'ほげ', },
            +{ content => 'ほげ', },
            +{ content => "\e[33mほげ\e[0m", wait => 1 },
            +{ content => 'ほげ', },
        ],
    },
    +{
        content => [
            +{ content => 'ほげ', },
            +{ content => 'ほほげ', },
        ],
    },
    +{
        content => [
            +{ content => 'ほげ', },
            +{ content => 'ほほほげ', },
            +{ content => 'ほげ', },
            +{ content => 'ほげ', },
        ],
    },
];

sub new {
    my ($class, $parser_class, $file) = @_;

    my $parser = $parser_class->new($file);
    return bless +{
        __parser => $parser,
    }, $class;

}

sub show {
    my ($self) = @_;
    my $screen    = Term::Screen->new;

    my $rows    =  $screen->rows;
    my $columns = $screen->cols;
    #my $slides = $self->paser->data;

    $screen->clrscr;

    my $page_num = scalar @{ $slides };
    my $page_index = 0;
    while (0 <= $page_index && $page_index < $page_num) {

        my $line_index = 0;
        for my $line (@{ $slides->[$page_index]->{content} }) {
            $screen->at($line_index)->puts($line->{content});
            sleep 1 if $line->{wait};
            $line_index++;
        }
        while ( my $c = $screen->at($rows, $columns)->getch ) {
            if ( $c eq 'n' ) {
                $page_index++;
                last;
            }
            elsif ( $c eq 'p' ) {
                $page_index--;
                last;
            }
        }

        $screen->clrscr;
    }

}

1;
__END__

=head1 NAME

Term::Slide -

=head1 SYNOPSIS

  use Term::Slide;

=head1 DESCRIPTION

Term::Slide is

=head1 AUTHOR

masasuzu / SUZUKI Masashi E<lt>m15.suzuki.masashi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
