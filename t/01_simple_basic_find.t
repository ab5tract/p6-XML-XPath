use v6.c;

use Test;
use XML::XPath;

plan 7;

my $x = XML::XPath.new(xml => q:to/ENDXML/);
<AAA>
    <BBB/>
    <CCC/>
    <BBB/>
    <CCC/>
    <BBB/>
    <!-- comment -->
    <DDD>
        <BBB/>
        Text
        <BBB/>
    </DDD>
    <CCC/>
</AAA>
ENDXML

my $set;
$set = $x.find("/");
isa-ok $set, XML::XPath::Result::Node, 'found one node';

$set = $x.find("/AAA");
isa-ok $set, XML::XPath::Result::Node, 'found one node';
is $set.value.name, 'AAA', 'node name is AAA';

$set = $x.find("/AAA/BBB");
is $set.nodes.elems, 3 , 'found three nodes';
is $set.nodes[0].value.name, 'BBB', 'node name is BBB';

$set = $x.find("/AAA/DDD/BBB");
is $set.nodes.elems, 2 , 'found three nodes';
is $set.nodes[0].value.name, 'BBB', 'node name is BBB';

done-testing;
