package Folder;

use 5.006;
use JSON::Parse 'parse_json';
use Moose;

extends 'FormstackBase';

sub getAllIDs {
    my $self = shift;
    
    my @idList;
    
    my $resp = $self->newHttpRequest('/folder.json');
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

sub getAllNames {
    my $self = shift;
    
    my @idList;
    
    my $resp = $self->newHttpRequest('/folder.json');
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
    
    my $resp = $self->newHttpRequest('/folder.json');
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

    use WebService::Formstack::FormstackBase;
    use WebService::Formstack::Folder;

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

=head2 searchNames

Returns a hash reference containing the IDs and names of all folders in your
account whose name matches <regex>

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
