package Notification;

use 5.006;
use JSON::Parse 'parse_json';
use Moose;

extends 'FormstackBase';

has '_id'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_form'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_name' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_fromType' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_fromValue'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_recipients' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_subject' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_type' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_hideEmpty'   => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

has '_showSection'   => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

has '_message' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_attachLimit'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_format' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

=pod

=head1 ATTRIBUTES

=over 12 

=item C<_id>

Integer: Holds the unique id for this notification

=item C<_form>

Integer: The form this notification is attached to

=item C<_name>

String: The name given to this notification. Does not need to be unique;
several notifications can have the same name, though obviously they should not

=item C<_fromType>

String: What type of field does this notification come from (?)

=item C<_fromValue>

Integer: No idea what this is for!

=item C<_recipients>

A semi-colon delimited list of e-mail addresses this notification gets sent
to

=item C<_subject>

String: Will appear in the subject line of the e-mail that will be sent

=item C<_type>

Boolean: No idea!

=item C<_hideEmpty>

Boolean: Hide fields in the email if have no value? 0 = false

=item C<_showSection>

Boolean: No idea!

=item C<_message>

String: Body of the e-mail message

=item C<_attachLimit>

Integer: Maximum number of attachments to this notification

=item C<_format>

String: Is the e-mail body in _plaintext_ or _html_?

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