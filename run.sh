# starting line
input=$(echo "obase=2;ibase=10;$RANDOM" | bc);
input=$(echo "obase=2;ibase=10;3716" | bc);
echo -n "\$input: $input, ";
echo "obase=10;ibase=2;$input" | bc;
echo "\${#input}: ${#input}";

# rule to use
rule=30;
echo "Base 10 Rule: $rule";
rule=$(echo "obase=2;ibase=10;$rule" | bc); 
# left zero pad rule to be 8 bits wide
for i in $(seq $(( 8 - ${#rule}))); do rule="0${rule}"; done
echo "Binary \$rule: $rule";

# return bits for p[revious], t[his[ and n[ext] from input
function ptn() {
	local input=$1; 
	local point=$2;
	t=${input:$point:1}; 
	case $point in 
		0) p=${input:$(( ${#input} - 1)):1}; n=${input:$(( $point + 1 )):1};; 
		$(( ${#input} - 1))) p=${input:$(( $point - 1 )):1}; n=${input:0:1};; 
		*) p=${input:$(( $point - 1 )):1}; n=${input:$(( $point + 1 )):1};; 
	esac; 
	echo "$p$t$n";
}

# return value for position in rule
function run_rule() {
	local rule=$1;
	local position=$2;
	echo "${rule:$(( 7 - $position )):1}";
}

function mutate() {
	local input=$1;
	local rule=$2;
	local position="";
	local i="";
	local output="";
	#loop over each bit in input
	for i in $(seq 0 $(( ${#input} - 1))); do 
		position=$(echo "obase=10;ibase=2; $(ptn $input $i)" | bc);
		output="${output}$(run_rule $rule $position)";
	done
	echo $output
}

echo "";
for i in $(seq 50); do 
	echo $input;
	input="$(mutate $input $rule)";
done
