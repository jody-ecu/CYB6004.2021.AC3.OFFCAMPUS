#!/usr/bin/perl
use Digest::SHA qw(sha256_hex);

$passwordHash = "8b7df143d91c716ecfa5fc1730022f6b421b05cedee8fd52b1fc65a96030ad52";
#prepare for the range of characters in the word to be created.
@chars = ("a".."z"); 

while (1) {
    #hash the word
    $word .= $chars[rand @chars] for 1..4; #then length of the password to be cracked has to be 4 characters in length. 
    $wordlistHash = sha256_hex($word);

    print "$word: $wordlistHash\n";
    #if the hash is the same as the correct password's hash then we have cracked the password!

    if($wordlistHash eq $passwordHash) {

        print("Password has been cracked! It was $word\n");

        exit;

    }
    $word="";
}
