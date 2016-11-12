package Submission;

use 5.006;
use JSON::Parse 'parse_json';
use Moose;

extends 'FormstackBase';

has '_id'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_timestamp' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_userAgent' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_remoteAddr' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_form'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_data' =>  (
    is      => 'rw',
    isa     => 'HashRef',
);

sub _getData {
    my $self = shift;
    my $data = shift;
    
    my %fields;
    
    foreach my $hash (@$data) {
        my $fieldID = ${$hash}{field};
        $fields{$fieldID} = ${$hash}{value};
    }
    
    return \%fields;
}

sub getSubmission {
    my $self = shift;
    my $subID = shift;

    my $resp = $self->newHttpRequest("\/submission\/$subID.json");
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        $self->_id(${$json}{id});
        $self->_timestamp(${$json}{timestamp});
        $self->_userAgent(${$json}{user_agent});
        $self->_remoteAddr(${$json}{remote_addr});
        $self->_form(${$json}{form});
        $self->_getData(${$json}{data});
        
        $self->_data(_getData(${$json}{data}));
    }
    
    return $self;
}

=pod

=head1 ATTRIBUTES

=over 12 

=item C<_id>

Integer: Holds the unique id for this submission

=item C<_timestamp>

Timestamp: Holds the date/time the submission was saved

=item C<_userAgent>

String: The agent string of the browser used to create the submission

=item C<_remoteAddr>

String: The I.P. address of the form submitter

=item C<_form>

Integer: The unique ID of the form definition being submitted. Look for this
value in the Form package

=back

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