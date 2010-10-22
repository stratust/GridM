package GridM;
use Moose;
use namespace::autoclean;

use Catalyst::Runtime 5.80;
use Sys::Hostname;

# Set flags and add plugins for the application
#
#         -Debug: activates the debug mode for very useful log messages
#   ConfigLoader: will load the configuration from a Config::General file in the
#                 application's home directory
# Static::Simple: will serve static files from the application's root
#                 directory

use Catalyst qw/
    ConfigLoader::Multi
    Static::Simple

	Unicode::Encoding

	Authentication
	Authorization::Roles

	Session
	Session::State::Cookie
	Session::Store::FastMmap

    Compress 
/;
=cut	
	Authentication
	Authorization::Roles
	Session
	Session::State::Cookie
	Session::Store::FastMmap

	Email
=cut


extends 'Catalyst';

our $VERSION = '0.01';
$VERSION = eval $VERSION;

# Configure the application.
#
# Note that settings in gridm.conf (or other external
# configuration file that you set up manually) take precedence
# over this when using ConfigLoader. Thus configuration
# details given here can function as a default configuration,
# with an external configuration file acting as an override for
# local deployment.

my ($host) = Sys::Hostname::hostname() =~ m/^([^\.]+)/;

__PACKAGE__->config(
    name => 'GridM',
    # Disable deprecated behavior needed by old applications
    disable_component_resolution_regex_fallback => 1,
    default_view           => 'TT',
    'Plugin::ConfigLoader' => {
        file                => __PACKAGE__->path_to('conf'),
        config_local_suffix => 'gridm_' . $host,
    },
    ENCODING => 'utf=8',
    static   => {
        include_path =>
          [ GridM->config->{root} ],
    },

    'Plugin::Authentication'                    => {
        default => {
            credential => {
                class          => 'Password',
                password_type  => 'self_check',
                password_field => 'user_password'
            },
            store => {
                class                     => 'DBIx::Class',
                user_model                => 'GridDB::User',
                role_relation             => 'roles',
                role_field                => 'role',
                use_userdata_from_session => '0'
            }
        }
    },
    email => [ 'SMTP', 'lgmb.fmrp.usp.br', ]

);

# Start the application
__PACKAGE__->setup();


=head1 NAME

GridM - Catalyst based application

=head1 SYNOPSIS

    script/gridm_server.pl

=head1 DESCRIPTION

[enter your description here]

=head1 SEE ALSO

L<GridM::Controller::Root>, L<Catalyst>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
