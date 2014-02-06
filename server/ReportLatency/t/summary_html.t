#!/usr/bin/perl -w
#
# Test ReportLatency::Store.pm
#
# Copyright 2013,2014 Google Inc. All Rights Reserved.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#    http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

use strict;
use CGI;
use DBI;
use File::Temp qw(tempfile tempdir);
use Test::More tests => 7;
use HTML::Tidy;

BEGIN {
  use lib '..';
}

use_ok( 'ReportLatency::Store' );
use_ok( 'ReportLatency::StaticView' );

my $dir = tempdir(CLEANUP => 1);
my $dbfile = "$dir/latency.sqlite3";
{
  open(my $sqlite3,"|-",'sqlite3',$dbfile) or die $!;
  open(my $sql,'<','../sql/sqlite3.sql') or die $!;
  while (my $line = $sql->getline) {
    print $sqlite3 $line;
  }
  close($sql);
  ok(close($sqlite3),'latency schema');
}

my $dbh;
$dbh = DBI->connect("dbi:SQLite:dbname=$dbfile",
		       {AutoCommit => 0}, '')
  or die $dbh->errstr;

my $store = new ReportLatency::Store(dbh => $dbh);
my $view = new ReportLatency::StaticView($store);


ok($dbh->do(q{
  INSERT INTO upload(location) VALUES('office.google.com');
}), 'INSERT google.com upload');

ok($dbh->do(q{
  INSERT INTO update_request(upload,name,service,count,total) VALUES(1,'google.com','google.com',2,1998);
}), 'INSERT google.com report');

my $summary_html = $view->summary_html();

my $tidy = new HTML::Tidy;
is($tidy->parse('summary_html',$summary_html), undef, 'summary.html');
for my $message ( $tidy->messages ) {
  print $message->as_string . "\n";
}
$tidy->clear_messages();

like($summary_html, qr/999/, '999ms avg request latency found');
