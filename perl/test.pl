$a = "awstats.foo.com.conf";
print $a;
$_ = $a;
s/awstats\.//g;
s/\.conf//g;
print "\n";
print $_;
print "\n";


opendir( DIR, "." );
@files = readdir( DIR );
closedir( DIR );
foreach $file (@files) {
   print "$file\n";
}
