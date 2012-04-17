package Term::Slide;
use strict;
use warnings;
use utf8;
our $VERSION = '0.01';

use Class::Load;
use Term::ScreenColor;

my $TITLE_LINE = "===================================";

sub new {
    my ($class, $parser_class, $file) = @_;
    Class::Load::load_class($parser_class);
    my $parser = $parser_class->new($file);

    return bless +{ slides => $parser->data }, $class;
}

sub show {
    my ($self) = @_;
    my $screen    = Term::ScreenColor->new;

    $screen->clrscr;

    my $rows    = $screen->rows;
    my $columns = $screen->cols;
    my $slides  = $self->{slides};


    my $page_num = scalar @{ $slides };
    my $page_index = 0;
    while (0 <= $page_index && $page_index < $page_num) {

        my $page = $slides->[$page_index];
        if ( $page->{title}) {
            $screen->at(0)->bold->cyan->puts($TITLE_LINE)->normal;
            $screen->at(1)->bold->cyan->puts($page->{title})->normal;
            $screen->at(2)->bold->cyan->puts($TITLE_LINE)->nomal;
        }

        my $line_index = 4;
        for my $line (@{ $page->{contents} }) {
            $screen->at($line_index)->puts($line->{content});
            $line_index++;

            if ($line->{wait}) {
                while ( my $c = $screen->at($rows, $columns)->getch ) {
                    if ( $c eq 'n' ) {
                        last;
                    }
                }
            }
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

Term::Slide is poor slide tool for terminal.

=head1 AUTHOR

masasuzu / SUZUKI Masashi E<lt>m15.suzuki.masashi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
