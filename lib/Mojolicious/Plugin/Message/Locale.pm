package Mojolicious::Plugin::Message::Locale;
use Mojo::Base 'Mojolicious::Plugin';
use utf8;

our $VERSION = '0.01';

sub register {
    my ($self, $app, $conf) = @_;

    my $default_msg = exists $conf->{default_message} ? $conf->{default_message} : '';
    my $locale = exists $conf->{locale} ? $conf->{locale} : 'en';
    my $locale_file = exists $conf->{file} ? $conf->{file} : 'locale.conf';

    my $messages = $app->plugin('Config', { file => $locale_file } );

    $app->helper ( set_locale => sub {
        my ($c, $loc,) = @_;
	$locale = $loc ? $loc : 'en';
    });

    $app->helper ( locale => sub {
        my ($c, $key, $group,) = @_;
	unless ( $key ) {
	    warn 'key is undefined or incorrenct.';
            return $default_msg;
        }
	$group ||= 'common';

        if ( exists $messages->{$group}->{$key}->{$locale} ) {
            $messages->{$group}->{$key}->{$locale};
	} elsif ( exists $messages->{'common'}->{$key}->{$locale} ) {
	    $messages->{'common'}->{$key}->{$locale}
	} else {
	    $default_msg;
        }
    });
}

1;
__END__

=head1 NAME

Mojolicious::Plugin::Message::Locale - Mojolicious Plugin

=head1 SYNOPSIS

  # locale.conf
  {
      common => {
          title => { en => 'TITLE', ja => 'タイトル' },
          message => { en => 'MESSAGE', ja => 'メッセージ' }
      },
      original => {
          message => { en => 'OROGINAL MESSAGE', ja => 'オリジナル' }
      }
  }

  # Mojolicious
  $self->plugin('Message::Locale', {
      default_str => '',
      locale => 'en',
      file => 'locale.conf',
  });
  # same $self->plugin('Message::Locale');

  $self->locale('message', 'common'); # MESSAGE
  $self->locale('message', 'original'); # ORIGINAL MESSAGE

  $self->set_locale('ja');
  $self->locale('title');   # タイトル
  $self->locale('message', 'original'); # オリジナル

  $self->set_locale('en');
  $self->locale('title');   # TITLE
  $self->locale('title', 'original'); # TITLE

  # template   .html.ep
  <%= locale "title" %>
  <%= locale "title", "original" %>
  <%= locale "message" %>
  <%= locale "message", "original" %>

=head1 DESCRIPTION

L<Mojolicious::Plugin::Message::Locale> is a plugin for Mojolicious apps to localize messages using L<Mojolicious::Plugin::Config>

=head1 METHODS

L<Mojolicious::Plugin::Message::Locale> inherits all methods from
L<Mojolicious::Plugin> and implements the following new ones.

=head2 C<register>

  $plugin->register($app, $conf);

Register plugin in L<Mojolicious> application.

=head1 SEE ALSO

L<Mojolicious>, L<Mojolicious::Guides>, L<http://mojolicio.us>.

=head1 AUTHOR

Kei Shimada C<< <sasakure_kei __at__ cpan.org> >>

=head1 REPOSITORY

  git clone git://github.com/(sasakure)

=head1 LICENCE AND COPYRIGHT

Copyright (c) 2012, Kei Shimada C<< <sasakure_kei _    _at__ cpan.org> >>. All rights reserved.
This module is free software; you can redistribute     it and/or
modify it under the same terms as Perl itself. See     L<perlartistic>.

=cut
