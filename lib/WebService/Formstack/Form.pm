package Form;

use 5.006;
use JSON::Parse 'parse_json';
use Moose;

extends 'FormstackBase';

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

has '_viewKey' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_views'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_created' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_updated' => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

has '_deleted'   => (
    is      => 'rw',
    isa     => 'Bool',
    default => 0,
);

has '_submissions'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_submissionsUnread'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_submissionsToday'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_lastSubmissionID'   => (
    is      => 'rw',
    isa     => 'Int',
    default => 0,
);

has '_lastSubmissionTime'   => (
    is      => 'rw',
    isa     => 'Str',
    default => '',
);

sub getAllIDs {
    my $self = shift;
    
    my @idList;
    
    my $resp = $self->newHttpRequest();
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        my $forms = ${$json}{forms};
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

sub getAllNames {
    my $self = shift;
    
    my @idList;
    
    my $resp = $self->newHttpRequest();
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        my $forms = ${$json}{forms};
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

sub getForm {
    my $self = shift;
    my $id = shift;

    my $resp = $self->newHttpRequest("\/form\/$id.json");
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        $self->_id(${$json}{id});
        $self->_name(${$json}{name});
        $self->_viewKey(${$json}{viewkey});
        $self->_views(${$json}{views});
        $self->_created(${$json}{created});
        $self->_updated(${$json}{updated});
        $self->_deleted(${$json}{deleted});
        $self->_submissions(${$json}{submissions});
        $self->_submissionsUnread(${$json}{submissions_unread});
        $self->_submissionsToday(${$json}{submissions_today});
        $self->_lastSubmissionID(${$json}{last_submission_id});
        $self->_lastSubmissionTime(${$json}{last_submission_time});
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
        return undef;
    }
    
    return $self;
}

sub getFormCount {
    my $self = shift;
    
    my $count = -1;

    my $resp = $self->newHttpRequest();
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        $count = ${$json}{total};
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
        $count = -1;
    }
    
    return $count;
}

sub searchNames {
    my $self = shift;
    my $searchName = shift;
    
    my %formList;
    
    my $resp = $self->newHttpRequest('/form.json');
    if ($resp->is_success) {
        my $message = $resp->decoded_content;
        my $json = parse_json($message);
        
        my $forms = ${$json}{forms};
        foreach my $form (@$forms) {
            my $name = ${$form}{name};
            
            if ($name  =~ /$searchName/i) {
                my $localID = ${$form}{id};
                $formList{$name} = $localID;
            }
        }
    }
    else {
        print "HTTP GET error code: ", $resp->code, "\n";
        print "HTTP GET error message: ", $resp->message, "\n";
    }
    
    return \%formList;
}

=head1 SYNOPSIS

The Form class extends the FormstackBase class and includes all methods
related to gathering Form information.

Example 1:

    use WebService::Formstack::FormstackBase;
    use WebService::Formstack::Folder;

    my $form = Form->new(
        authKey => 'Bearer <oauth2_key>');
    my $forms = $form->getAllNames();
    foreach my $formName (@$forms) { ... }
    
Example 2:

    use WebService::Formstack::FormstackBase;
    use WebService::Formstack::Form;

    my $form = Form->new(
        authKey => 'Bearer <oauth2_key>');
    my $forms = $form->searchNames('a');
    while (my ($name, $id)  = each %$forms) { print "$name:$id\n";}

=head1 ATTRIBUTES

=head2 _id

Type: Integer

=head1 PUBLIC METHODS

=head2 getAllIDs

Returns an array reference containing the IDs of all forms in your
account.

=head2 getAllNames

Returns an array reference containing the names of all forms in your
account.

=head2 getForm

Returns a populated Form object with the given id

=head2 getFormCount

Returns a count of the number of forms currently in your account.

=head2 searchFormNames

Returns a hash reference containing the IDs and names of all forms in your
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
