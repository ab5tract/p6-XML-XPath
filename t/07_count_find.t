use v6.c;

use Test;
use XML::XPath;

plan 9;

my $x = XML::XPath.new(xml => q:to/ENDXML/);
<AAA>
<CCC><BBB/><BBB/><BBB/></CCC>
<DDD><BBB/><BBB/></DDD>
<EEE><CCC/><DDD/></EEE>
<FFF />
</AAA>
ENDXML

my $set;
$set = $x.find('count(/AAA/*)');
is $set, 4, 'found 3 nodes';

$set = $x.find('count(/AAA/*)=4');
is $set, True, 'found 3 nodes';

$set = $x.find('count(/AAA/*)=3');
is $set, False, 'found 3 nodes';

$set = $x.find('//*[count(BBB)=2]');
say $set;
is $set.nodes.elems, 1 , 'found one node';
#is $set.nodes[0].name, 'DDD', 'node name is BBB';

$set = $x.find('//*[count(*)=2]');
is $set.nodes.elems, 2 , 'found two nodes';
is $set.nodes[0].value.name, 'DDD', 'node name is DDD';
is $set.nodes[1].value.name, 'EEE', 'node name is EEE';

$set = $x.find('//*[count(*)=3]');
is $set.nodes.elems, 1 , 'found one node';
is $set.nodes[0].value.name, 'CCC', 'node name is CCC';

done-testing;