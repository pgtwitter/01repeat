use POSIX;
foreach my $i (1..10) {
	my $s;
	for($j= 0; $j<$i; $j++) {
		$s.= ($j%2==0)?'0':'1';
	}

	my @type;
	my @ops= operations1($i);
	foreach my $op (@ops) {
		my $p= operated_s1($s, $op);
		push(@type, $p) if (!grep {$_ eq $p} @type);
	}
	my $q= Fib($i);
	
	printf "n=%d, F(%d)= %d, a(n)=%d, s(n)='%s', [%s]\n", $i, $i, $q, ($#type+1), $s, join(', ', @type);
}

sub Fib($i) {
	return 1 if ($i==0 || $i ==1);
	return Fib($i-1)+Fib($i-2);
}

sub operated_s1 {
	my ($s, $op)= @_;

	my @tmp= split('', $s);
	my @op_ary= split('', $op);
		
	for(my $j=0; $j<$#op_ary+1; $j++) {
		next if ($op_ary[$j] == 0);
		my $v= $tmp[$j];
		$tmp[$j]= $tmp[$j+1];
		$tmp[$j+1]= $v;
  	}
	return join('', @tmp);
}

sub operations1 {
	my ($i)= @_;
	
	my @ops;
	
	return ('0') if ($i==1);
	
	for(my $j=0; $j<=pow(2,$i-1)-1; $j++) {
		my $a = sprintf('%b',$j);
		while(length($a)<$i-1) {
			$a= '0'.$a;
		}
		if ($a!~/11/) {
			push(@ops, $a);
		}
	}
	return @ops;
}