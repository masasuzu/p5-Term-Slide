use inc::Module::Install;
name 'Term-Slide';
all_from 'lib/Term/Slide.pm';
readme_markdown_from 'lib/Term/Slide.pm';
githubmeta;

# requires '';

tests 't/*.t';
author_tests 'xt';

build_requires 'Test::More';
auto_set_repository;
auto_include;
WriteAll;
