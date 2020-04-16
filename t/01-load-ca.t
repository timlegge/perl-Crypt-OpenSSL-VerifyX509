use Test::More;
use Crypt::OpenSSL::X509;
use Crypt::OpenSSL::VerifyX509;
use File::Slurp qw(read_file);

my $v = Crypt::OpenSSL::VerifyX509->new('t/cacert.pem');
ok($v);

my $catext = read_file('t/cacert.pem');
like($catext, qr/CBiDELMAkGA1UEBhMCU0UxEDAOBgNV/);

$ca = Crypt::OpenSSL::X509->new_from_string($catext);
ok($ca);

my $v = Crypt::OpenSSL::VerifyX509->new_from_x509($ca);
ok($v);

done_testing;

