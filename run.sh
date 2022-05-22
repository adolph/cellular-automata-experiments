# starting line
seed=$(echo "obase=2;ibase=10;$RANDOM" | bc);
echo -n "\$seed: $seed, ";
echo "obase=10;ibase=2;$seed" | bc;
echo "\${#seed}: ${#seed}";

# rule to use
rule=$(echo "obase=2;ibase=10;30" | bc); 
echo "\$rule: $rule";
echo "\${#rule}: ${#rule}";

#find bits for p[revious], t[his[ and n[ext] from seed
for i in $(seq 0 $(( ${#seed} - 1))); do 
	echo -n "$i :: ${seed:$i:1}"; 
	t=${seed:$i:1}; 
	case $i in 
		0) p=${seed:$(( ${#seed} - 1)):1}; n=${seed:$(( $i + 1 )):1};; 
		$(( ${#seed} - 1))) p=${seed:$(( $i - 1 )):1}; n=${seed:0:1};; 
		*) p=${seed:$(( $i - 1 )):1}; n=${seed:$(( $i + 1 )):1};; 
	esac; 
	echo -n " :: $p,$t,$n :: "; 
	echo "obase=10;ibase=2; $p$t$n" | bc; 
done
