use Test::More;
use Crypt::OpenSSL::VerifyX509;
use Crypt::OpenSSL::X509;

my $v;
eval {
        $v = Crypt::OpenSSL::VerifyX509->new(__FILE__);
};
ok(!$v);

my $vx509;
eval {
        $vx509 =  Crypt::OpenSSL::VerifyX509->new_from_x509();
};
ok(!$vx509);

done_testing;
