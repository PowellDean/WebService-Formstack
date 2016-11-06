package Folder;

use 5.006;
use JSON::Parse 'parse_json';
use Moose;

extends 'FormstackBase';

has '_endpoint' => (
    is      => 'rw',
    isa     => 'Str',
    default => '/folder.json',
);

has '_id'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_name' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_parent'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_permissions' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

sub getAllIDs {
    my $self = shift;
    
    my @idList;
    
    my $resp = $self->newHttpRequest($self->_endpoint);
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        my $forms = ${$json}{folders};
        foreach my $form (@$forms) {
            push @idList, ${$form}{id};
        }
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
    }
    
    return \@idList;
}

sub getFolder {
    my $self = shift;
    my $id = shift;

    my $resp = $self->newHttpRequest("\/folder\/$id.json");
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        $self->_id(${$json}{id});
        $self->_name(${$json}{name});
        $self->_parent(${$json}{parent});
        $self->_permissions(${$json}{permissions});
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
        return undef;
    }
    
    return $self;
}

sub getAllNames {
    my $self = shift;
    
    my @idList;
    
    my $resp = $self->newHttpRequest($self->_endpoint);
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        my $forms = ${$json}{folders};
        foreach my $form (@$forms) {
            push @idList, ${$form}{name};
        }
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
    }
    
    return \@idList;
}

sub searchNames {
    my $self = shift;
    my $searchName = shift;
    
    my %folderList;
    
    my $resp = $self->newHttpRequest($self->_endpoint);
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        my $forms = ${$json}{folders};
        foreach my $form (@$forms) {
            my $name = ${$form}{name};

            if ($name  =~ /$searchName/i) {
                my $localID = ${$form}{id};
                $folderList{$name} = $localID;
            }
        }
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
    }
    
    return \%folderList;
}

=head1 SYNOPSIS

The Form class extends the FormstackBase class and includes all methods
related to gathering Folder information.

Example 1:

    use WebService::Formstack::FormstackBase;
    use WebService::Formstack::Folder;

    my $folder = Folder->new(
        authKey => 'Bearer <oauth2_key>');
    my $forms = $folder->getAllNames();
    foreach my $formName (@$forms) { ... }
    
Example 2:

    use WebService::Formstack::Classes::FormstackBase;
    use WebService::Formstack::Classes::Folder;

    my $folder = Folder->new(
        authKey => 'Bearer <oauth2_key>');
    my $forms = $folder->searchNames('a');
    while (my ($name, $id)  = each %$forms) { print "$name:$id\n";}

=head1 PUBLIC METHODS

=head2 getAllIDs

Returns an array reference containing the IDs of all folders in your
account.

=head2 getAllNames

Returns an array reference containing the IDs of all folders in your
account.

=head2 getFolder

For the given folder id, return a populated Folder object

=head3 Returns:

=over 12

=item B<If successful:   A Folder object>

=item B<If unsuccessful: undef>

=back

=head2 searchNames

Returns a hash reference containing the IDs and names of all folders in your
account whose name matches <regex>

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
