use Test::More;
use Crypt::OpenSSL::VerifyX509;
use Crypt::OpenSSL::X509;
use File::Slurp qw(read_file);

my $v = Crypt::OpenSSL::VerifyX509->new('t/cacert.pem');
ok($v);

my $ret;
eval {
        my $not_cert = 'foo!';
        $ret = $v->verify($not_cert);
};
ok($@ =~ /x509 is not of type Crypt::OpenSSL::X509/);
ok(!$ret);

# Test loading CACert from a string

my $catext = read_file('t/cacert.pem');
like($catext, qr/CBiDELMAkGA1UEBhMCU0UxEDAOBgNV/);

my $ca = Crypt::OpenSSL::X509->new_from_string($catext);
ok($ca);

my $vx509 = Crypt::OpenSSL::VerifyX509->new_from_x509($ca);
ok($vx509);

my $retx509;
eval {
        my $not_cert = 'foo!';
        $retx509 = $vx509->verify($not_cert);
};
ok($@ =~ /x509 is not of type Crypt::OpenSSL::X509/);
ok(!$retx509);



done_testing;
