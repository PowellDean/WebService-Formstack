package Form;

use 5.006;
use JSON::Parse 'parse_json';
use Moose;

extends 'FormstackBase';

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
    use WebService::Formstack::Form;

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

=head1 PUBLIC METHODS

=head2 getAllIDs

Returns an array reference containing the IDs of all forms in your
account.

=head2 getAllNames

Returns an array reference containing the names of all forms in your
account.

=head2 getFormCount

Returns a count of the number of forms currently in your account.

=head2 searchFormNames

Returns a hash reference containing the IDs and names of all forms in your
account whose name matches <regex>

=cut

no Moose;
__PACKAGE__->meta->make_immutable;
