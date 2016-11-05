package FormstackBase;

use 5.006;
use LWP::UserAgent;
use JSON::Parse 'parse_json';
use Moose;
use strict;
use warnings;

has 'BASEURL' => (
    is      => 'ro',
    isa     => 'Str',
    default => 'https://www.formstack.com/api',
);

has 'APIVERSION' => (
    is      => 'ro',
    isa     => 'Str',
    default => '/v2',
);

has 'authKey' => (
    is      => 'rw',
    isa     => 'Str',
);

has 'contentType' => (
    is      => 'rw',
    isa     => 'Str',
    default => 'application/xml',
);

sub newHttpRequest {
    my $self = shift;
    my $definition = shift;

    $definition = '/form.json' if (!defined $definition);
    
    my $ua = LWP::UserAgent->new;
    my $endPoint = $self->BASEURL . $self->APIVERSION . $definition;

    # set custom HTTP request header fields
    my $req = HTTP::Request->new(GET => $endPoint);
    $req->header('content-type' => $self->contentType);
    $req->header('Authorization' => $self->authKey);
    
    my $resp = $ua->request($req);
    
    return $resp;
}

=head1 NAME

WebService::Formstack - Perl 5.x interface to the published Formstack API.
Currently only the read operations are supported.

Pre-requisites:

Because Formstack returns results in JSON format you will need to have
JSON::Parse pre-installed.

This module also requires Moose

=head1 VERSION

Version 0.01

=cut

=head1 SYNOPSIS

This is a wrapper around the Formstack API (web-based forms designer).
You will need a FormStack login and key to use this module.

Example:

    use WebService::Formstack::FormstackBase;
    use WebService::Formstack::Folder;

    my $folder = Folder->new(
        authKey => 'Bearer <oauth2_key>');
    my $forms = $folder->getAllNames();
    foreach my $formName (@$forms) { ... }

=head1 EXPORT

=over 4

=item C<getAllFolderIDs>

=item C<getAllFolderNames>

=item C<getAllFormIDs>

=item C<getAllFormNames>

=item C<getFormCount>

=item C<searchFolderNames>

=back


=head1 SUBROUTINES/METHODS

=head2 getAllFolderIDs

Returns an array reference containing the IDs of all folders in your
account.

=cut

=head2 getAllFolderNames

Returns an array reference containing the IDs of all folders in your
account.

=cut

=head2 getAllFormIDs

Returns an array reference containing the IDs of all forms in your
account.

=cut

=head2 getAllFormNames

Returns an array reference containing the names of all forms in your
account.

=cut

=head2 getFormCount

Returns a count of the number of forms currently in your account.

=cut

=head2 newHttpRequest($definition)

Set up a new HTTP request. $definition is an optional parameter
that determines what actual information is being requested. If not
supplied, we assume the request is '/form'.

=cut

=head2 searchFolderNames

Returns a hash reference containing the IDs and names of all folders in your
account whose name matches <regex>

=cut

=head2 searchFormNames

Returns a hash reference containing the IDs and names of all forms in your
account whose name matches <regex>

=cut

=head1 AUTHOR

Powell, Dean, C<< <PowellDean at gmail.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-webservice-formstack at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=WebService-Formstack>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.




=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc WebService::Formstack


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker (report bugs here)

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=WebService-Formstack>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/WebService-Formstack>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/WebService-Formstack>

=item * Search CPAN

L<http://search.cpan.org/dist/WebService-Formstack/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2016 Powell, Dean.

This program is free software; you can redistribute it and/or modify it
under the terms of the the Artistic License (2.0). You may obtain a
copy of the full license at:

L<http://www.perlfoundation.org/artistic_license_2_0>

Any use, modification, and distribution of the Standard or Modified
Versions is governed by this Artistic License. By using, modifying or
distributing the Package, you accept this license. Do not use, modify,
or distribute the Package, if you do not accept this license.

If your Modified Version has been derived from a Modified Version made
by someone other than you, you are nevertheless required to ensure that
your Modified Version complies with the requirements of this license.

This license does not grant you the right to use any trademark, service
mark, tradename, or logo of the Copyright Holder.

This license includes the non-exclusive, worldwide, free-of-charge
patent license to make, have made, use, offer to sell, sell, import and
otherwise transfer the Package with respect to any patent claims
licensable by the Copyright Holder that are necessarily infringed by the
Package. If you institute patent litigation (including a cross-claim or
counterclaim) against any party alleging that the Package constitutes
direct or contributory patent infringement, then this Artistic License
to you shall terminate on the date that such litigation is filed.

Disclaimer of Warranty: THE PACKAGE IS PROVIDED BY THE COPYRIGHT HOLDER
AND CONTRIBUTORS "AS IS" AND WITHOUT ANY EXPRESS OR IMPLIED WARRANTIES.
THE IMPLIED WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR
PURPOSE, OR NON-INFRINGEMENT ARE DISCLAIMED TO THE EXTENT PERMITTED BY
YOUR LOCAL LAW. UNLESS REQUIRED BY LAW, NO COPYRIGHT HOLDER OR
CONTRIBUTOR WILL BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, OR
CONSEQUENTIAL DAMAGES ARISING IN ANY WAY OUT OF THE USE OF THE PACKAGE,
EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.


=cut

no Moose;
__PACKAGE__->meta->make_immutable;
