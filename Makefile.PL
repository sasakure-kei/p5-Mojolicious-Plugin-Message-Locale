use strict;
use warnings;

use ExtUtils::MakeMaker;

WriteMakefile(
  NAME         => 'Mojolicious::Plugin::Message::Locale',
  VERSION_FROM => 'lib/Mojolicious/Plugin/Message/Locale.pm',
  AUTHOR       => 'Kei Shimada <sasakure_kei@cpan.org>',
  PREREQ_PM    => {'Mojolicious' => '3.56'},
  test         => {TESTS => 't/*.t'}
);
