use POSIX;
foreach my $i (1..10) {
	my $s;
	for($j= 0; $j<$i; $j++) {
		$s.= ($j%2==0)?'0':'1';
	}

	my @type;
	my @ops= operations0($i);
	foreach my $op (@ops) {
		my $p= operated_s0($s, $op);
		push(@type, $p) if (!grep {$_ eq $p} @type);
	}
	my $q= Quarter_square($i) + 1;
	
	printf "n=%d, qs1(%d)= %d, a(n)=%d, s(n)='%s', [%s]\n", $i, $i, $q, ($#type+1), $s, join(', ', @type);
}

sub Quarter_square($n) {
	my ($n)= @_;
	return floor($n*$n/4.0);
}

sub operated_s0 {
	my ($s, $op)= @_;

	my @tmp= split('', $s);
	if ($op) {
		my ($j, $k)= split(':', $op);
		
		my $v= $tmp[$j];
		$tmp[$j]= $tmp[$k];
		$tmp[$k]= $v;
    }
	
	return join('', @tmp);
}

sub operations0 {
	my ($i)= @_;
	
	my @ops;
	
	return ( NULL ) if ($i==1);
		
	for(my $j=0; $j<$i-1; $j++) {
		for(my $k=$j+1; $k<$i; $k++) {
			push(@ops, "$j:$k");
		}
	}
	return @ops;
}