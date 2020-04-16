use Test::More;
use Crypt::OpenSSL::VerifyX509;
use Crypt::OpenSSL::X509;
use File::Slurp qw(read_file);

my $v = Crypt::OpenSSL::VerifyX509->new('t/cacert.pem');
ok($v);

my $text =<<CERT;
-----BEGIN CERTIFICATE-----
MIIDkTCCAvqgAwIBAgIBATANBgkqhkiG9w0BAQQFADCBiDELMAkGA1UEBhMCU0Ux
EDAOBgNVBAcTB1VwcHNhbGExETAPBgNVBAoTCE15U1FMIEFCMSEwHwYDVQQDExhB
YnN0cmFjdCBNeVNRTCBEZXZlbG9wZXIxMTAvBgkqhkiG9w0BCQEWImFic3RyYWN0
Lm15c3FsLmRldmVsb3BlckBteXNxbC5jb20wHhcNMDMwOTEyMTYyMTE5WhcNMTMw
OTA5MTYyMTE5WjB8MQswCQYDVQQGEwJTRTEQMA4GA1UEBxMHVXBwc2FsYTERMA8G
A1UEChMITXlTUUwgQUIxFTATBgNVBAMTDE15U1FMIENsaWVudDExMC8GCSqGSIb3
DQEJARYiYWJzdHJhY3QubXlzcWwuZGV2ZWxvcGVyQG15c3FsLmNvbTCBnzANBgkq
hkiG9w0BAQEFAAOBjQAwgYkCgYEAxAMK7uOxEvzutBn04WAd4CjDli3fgmnNdHxU
WNCus1k/DBkcmRCmEsnPOmQFQ46/0mU2gJELZbAnJjjJI9g2okrw98AvaDhwAScp
/7LFUuFr8cjXw1zu8DdsKpuWGgWe6zOiOVp3ZmIndR8vbzja5Z94r8prIj9XK7ym
j0fRmW8CAwEAAaOCARQwggEQMAkGA1UdEwQCMAAwLAYJYIZIAYb4QgENBB8WHU9w
ZW5TU0wgR2VuZXJhdGVkIENlcnRpZmljYXRlMB0GA1UdDgQWBBSAgaki66vWyn4/
jbvRrCr0h50TKTCBtQYDVR0jBIGtMIGqgBSImGXZ8/KLAx1mYGEj+q1zbdNokqGB
jqSBizCBiDELMAkGA1UEBhMCU0UxEDAOBgNVBAcTB1VwcHNhbGExETAPBgNVBAoT
CE15U1FMIEFCMSEwHwYDVQQDExhBYnN0cmFjdCBNeVNRTCBEZXZlbG9wZXIxMTAv
BgkqhkiG9w0BCQEWImFic3RyYWN0Lm15c3FsLmRldmVsb3BlckBteXNxbC5jb22C
AQAwDQYJKoZIhvcNAQEEBQADgYEAhhcc858QG3VHA8pU6u/3FVSNj1jJZH3eLr/q
pl1yVsmBvrsceKWR1vh3353Sy5TZBmFPBSEiKuqew4tN/pTHmGHNfogZyZIBHxBb
xhaVmZsyATqJ3/oKiaz6tUBVesoKvV2LBth+4USMcMhjx3dqNz2krFfcAMHB83IX
W1CV7rc=
-----END CERTIFICATE-----
CERT

my $cert = Crypt::OpenSSL::X509->new_from_string($text);
ok($cert);

my $ret = $v->verify($cert);
ok($ret);

# Test loading CACert from a string

my $catext = read_file('t/cacert.pem');
like($catext, qr/CBiDELMAkGA1UEBhMCU0UxEDAOBgNV/);

my $ca = Crypt::OpenSSL::X509->new_from_string($catext);
ok($ca);

my $vx509 = Crypt::OpenSSL::VerifyX509->new_from_x509($ca);
ok($vx509);

my $ret = $vx509->verify($cert);
ok($ret);

done_testing;
