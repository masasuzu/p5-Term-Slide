package Term::Slide;
use strict;
use warnings;
use 5.14.2;
our $VERSION = '0.01';

use Term::ScreenColor;

my $slides = [
    +{
        title => "ほげほげータイトル",
        contents => [
            +{ content => '* ほげ', },
            +{ content => "* \e[31mほげ\e[0m", },
            +{ content => "* \e[33mほげ\e[0m", wait => 1 },
            +{ content => '* ほげ', },
        ],
    },
    +{
        contents => [
            +{ content => '* タイトルなし', },
            +{ content => "* \e[31mほげ\e[0m", },
            +{ content => '* ほげ', },
            +{ content => '  * ほほげ', wait => 1 },
            +{ content => '  * ほほげ', },
        ],
    },
    +{
        title => "ほげほげータイトル",
        contents => [
            +{ content => "* \e[31mほげ\e[0m", },
            +{ content => '* ほげ', },
            +{ content => '  * ほほほげ', },
            +{ content => '  * ほげ', },
            +{ content => '* ほげ', },
        ],
    },
];

sub show {
    my ($self) = @_;
    my $screen    = Term::ScreenColor->new;

    my $rows    = $screen->rows;
    my $columns = $screen->cols;

    $screen->clrscr;

    my $page_num = scalar @{ $slides };
    my $page_index = 0;
    while (0 <= $page_index && $page_index < $page_num) {

        my $title_line = "===================================";
        my $page = $slides->[$page_index];
        if ( $page->{title}) {
            $screen->at(0)->bold->cyan->puts($title_line)->normal;
            $screen->at(1)->bold->cyan->puts($page->{title})->normal;
            $screen->at(2)->bold->cyan->puts($title_line)->nomal;
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

Term::Slide is

=head1 AUTHOR

masasuzu / SUZUKI Masashi E<lt>m15.suzuki.masashi@gmail.comE<gt>

=head1 SEE ALSO

=head1 LICENSE

This library is free software; you can redistribute it and/or modify
it under the same terms as Perl itself.

=cut
