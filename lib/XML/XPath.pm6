use XML;
use XML::XPath::Actions;
use XML::XPath::Grammar;
use XML::XPath::NodeSet;

class XML::XPath {
    has $.document;
    has $.debug = 0;

    submethod BUILD(:$file, :$xml, :$document) {
        my $doc;
        if $document {
            $doc = $document;
        }
        elsif $file {
        }
        elsif $xml {
            $doc = from-xml($xml);
        }
        $!document = $doc;
    }

    method find(Str $xpath) {
        my $parsed-xpath = self.parse-xpath($xpath);
        my $start-nodeset  = XML::XPath::NodeSet.new($.document);
        my $result-nodeset = $parsed-xpath.evaluate($start-nodeset);
        return $result-nodeset;
    }

    method parse-xpath(Str $xpath) {
        my $actions        = XML::XPath::Actions.new(:$.debug);
        my $match          = XML::XPath::Grammar.parse($xpath, :$actions);
        say $match if $.debug;
        my $parsed-xpath   = $match.ast;
        return $parsed-xpath;
    }
}
