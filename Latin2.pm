package HTML::Entities::Latin2;

use 5.006;
use strict;
use warnings;

require Exporter;

our @ISA = qw(Exporter);
our @EXPORT_OK = qw(encode);

our $VERSION = '0.02';

my $char_map = {
	'A1' => ['&#260;', '&#x0104;', '&Aogon;', "\x{0104}", 'LATIN CAPITAL LETTER A WITH OGONEK'],
	'A2' => ['&#728;', '&#x02D8;', '&breve;', "\x{02D8}", 'BREVE'],
	'A3' => ['&#321;', '&#x0141;', '&Lstrok;', "\x{0141}", 'LATIN CAPITAL LETTER L WITH STROKE'],
	'A4' => ['&#164;', '&#x00A4;', '&curren;', "\x{00A4}", 'CURRENCY SIGN'],
	'A5' => ['&#317;', '&#x013D;', '&Lcaron;', "\x{013D}", 'LATIN CAPITAL LETTER L WITH CARON'],
	'A6' => ['&#346;', '&#x015A;', '&Sacute;', "\x{015A}", 'LATIN CAPITAL LETTER S WITH ACUTE'],
	'A7' => ['&#167;', '&#x00A7;', '&sect;', "\x{00A7}", 'SECTION SIGN'],
	'A8' => ['&#168;', '&#x00A8;', '&uml;', "\x{00A8}", 'DIAERESIS'],
	'A9' => ['&#352;', '&#x0160;', '&Scaron;', "\x{0160}", 'LATIN CAPITAL LETTER S WITH CARON'],
	'AA' => ['&#350;', '&#x015E;', '&Scedil;', "\x{015E}", 'LATIN CAPITAL LETTER S WITH CEDILLA'],
	'AB' => ['&#356;', '&#x0164;', '&Tcaron;', "\x{0164}", 'LATIN CAPITAL LETTER T WITH CARON'],
	'AC' => ['&#377;', '&#x0179;', '&Zacute;', "\x{0179}", 'LATIN CAPITAL LETTER Z WITH ACUTE'],
	'AD' => ['&#150;', '&#x00AD;', '&shy;', "\x{00AD}", 'SOFT HYPHEN'],
	'AE' => ['&#381;', '&#x017D;', '&Zcaron;', "\x{017D}", 'LATIN CAPITAL LETTER Z WITH CARON'],
	'AF' => ['&#379;', '&#x017B;', '&Zdot;', "\x{017B}", 'LATIN CAPITAL LETTER Z WITH DOT ABOVE'],
	'B0' => ['&#730;', '&#x00B0;', '&deg;', "\x{00B0}", 'DEGREE SIGN'],
	'B1' => ['&#261;', '&#x0105;', '&aogon;', "\x{0105}", 'LATIN SMALL LETTER A WITH OGONEK'],
	'B2' => ['&#731;', '&#x02DB;', '&ogon;', "\x{02DB}", 'OGONEK'],
	'B3' => ['&#322;', '&#x0142;', '&lstrok;', "\x{0142}", 'LATIN SMALL LETTER L WITH STROKE'],
	'B4' => ['&#714;', '&#x00B4;', '&acute;', "\x{00B4}", 'ACUTE ACCENT'],
	'B5' => ['&#318;', '&#x013E;', '&lcaron;', "\x{013E}", 'LATIN SMALL LETTER L WITH CARON'],
	'B6' => ['&#347;', '&#x015B;', '&sacute;', "\x{015B}", 'LATIN SMALL LETTER S WITH ACUTE'],
	'B7' => ['&#711;', '&#x02C7;', '&caron', "\x{02C7}", 'CARON'],
	'B8' => ['&#184;', '&#x00B8;', '&cedil;', "\x{00B8}", 'CEDILLA'],
	'B9' => ['&#353;', '&#x0161;', '&scaron;', "\x{0161}", 'LATIN SMALL LETTER S WITH CARON'],
	'BA' => ['&#351;', '&#x015F;', '&scedil;', "\x{015F}", 'LATIN SMALL LETTER S WITH CEDILLA'],
	'BB' => ['&#357;', '&#x0165;', '&tcaron;', "\x{0165}", 'LATIN SMALL LETTER T WITH CARON'],
	'BC' => ['&#378;', '&#x017A;', '&zacute;', "\x{017A}", 'LATIN SMALL LETTER Z WITH ACUTE'],
	'BD' => ['&#733;', '&#x02DD;', '&dblac;', "\x{02DD}", 'DOUBLE ACUTE ACCENT'],
	'BE' => ['&#382;', '&#x017E;', '&zcaron;', "\x{017E}", 'LATIN SMALL LETTER Z WITH CARON'],
	'BF' => ['&#380;', '&#x017C;', '&zdot;', "\x{017C}", 'LATIN SMALL LETTER Z WITH DOT ABOVE'],
	'C0' => ['&#340;', '&#x0154;', '&Racute;', "\x{0154}", 'LATIN CAPITAL LETTER R WITH ACUTE'],
	'C1' => ['&#193;', '&#x00C1;', '&Aacute;', "\x{00C1}", 'LATIN CAPITAL LETTER A WITH ACUTE'],
	'C2' => ['&#194;', '&#x00C2;', '&Acirc;', "\x{00C2}", 'LATIN CAPITAL LETTER A WITH CIRCUMFLEX'],
	'C3' => ['&#258;', '&#x0102;', '&Abreve;', "\x{0102}", 'LATIN CAPITAL LETTER A WITH BREVE'],
	'C4' => ['&#196;', '&#x00C4;', '&Auml;', "\x{00C4}", 'LATIN CAPITAL LETTER A WITH UMLAUT'],
	'C5' => ['&#313;', '&#x0139;', '&Lacute;', "\x{0139}", 'LATIN CAPITAL LETTER L WITH ACUTE'],
	'C6' => ['&#262;', '&#x0106;', '&Cacute;', "\x{0106}", 'LATIN CAPITAL LETTER C WITH ACUTE'],
	'C7' => ['&#199;', '&#x00C7;', '&Ccedil;', "\x{00C7}", 'LATIN CAPITAL LETTER C WITH CEDILLA'],
	'C8' => ['&#268;', '&#x010C;', '&Ccaron;', "\x{010C}", 'LATIN CAPITAL LETTER C WITH CARON'],
	'C9' => ['&#201;', '&#x00C9;', '&Eacute;', "\x{00C9}", 'LATIN CAPITAL LETTER E WITH ACUTE'],
	'CA' => ['&#280;', '&#x0118;', '&Eogon;', "\x{0118}", 'LATIN CAPITAL LETTER E WITH OGONEK'],
	'CB' => ['&#203;', '&#x00CB;', '&Euml;', "\x{00CB}", 'LATIN CAPITAL LETTER E WITH UMLAUT'],
	'CC' => ['&#282;', '&#x011A;', '&Ecaron;', "\x{011A}", 'LATIN CAPITAL LETTER E WITH CARON'],
	'CD' => ['&#205;', '&#x00CD;', '&Iacute;', "\x{00CD}", 'LATIN CAPITAL LETTER I WITH ACUTE'],
	'CE' => ['&#206;', '&#x00CE;', '&Icirc;', "\x{00CE}", 'LATIN CAPITAL LETTER I WITH CIRCUMFLEX'],
	'CF' => ['&#270;', '&#x010E;', '&Dcaron;', "\x{010E}", 'LATIN CAPITAL LETTER D WITH CARON'],
	'D0' => ['&#272;', '&#x0110;', '&Dstrok;', "\x{0110}", 'LATIN CAPITAL LETTER D WITH STROKE'],
	'D1' => ['&#323;', '&#x0143;', '&Nacute;', "\x{0143}", 'LATIN CAPITAL LETTER N WITH ACUTE'],
	'D2' => ['&#327;', '&#x0147;', '&Ncaron;', "\x{0147}", 'LATIN CAPITAL LETTER N WITH CARON'],
	'D3' => ['&#211;', '&#x00D3;', '&Oacute;', "\x{00D3}", 'LATIN CAPITAL LETTER O WITH ACUTE'],
	'D4' => ['&#212;', '&#x00D4;', '&Ocirc;', "\x{00D4}", 'LATIN CAPITAL LETTER O WITH CIRCUMFLEX'],
	'D5' => ['&#336;', '&#x0151;', '&Odblac;', "\x{0151}", 'LATIN CAPITAL LETTER O WITH DOUBLE ACUTE'],
	'D6' => ['&#214;', '&#x00D6;', '&Ouml;', "\x{00D6}", 'LATIN CAPITAL LETTER O WITH UMLAUT'],
	'D7' => ['&#215;', '&#x00D7;', '&times;', "\x{00D7}", 'MULTIPLICATION SIGN'],
	'D8' => ['&#344;', '&#x0158;', '&Rcaron;', "\x{0158}", 'LATIN CAPITAL LETTER R WITH CARON'],
	'D9' => ['&#366;', '&#x016E;', '&Uring;', "\x{016E}", 'LATIN CAPITAL LETTER U WITH RING ABOVE'],
	'DA' => ['&#218;', '&#x00DA;', '&Uacute;', "\x{00DA}", 'LATIN CAPITAL LETTER U WITH ACUTE'],
	'DB' => ['&#368;', '&#x0170;', '&Udblac;', "\x{0170}", 'LATIN CAPITAL LETTER U WITH DOUBLE ACUTE'],
	'DC' => ['&#220;', '&#x00DC;', '&Uuml;', "\x{00DC}", 'LATIN CAPITAL LETTER U WITH UMLAUT'],
	'DD' => ['&#221;', '&#x00DD;', '&Yacute;', "\x{00DD}", 'LATIN CAPITAL LETTER Y WITH ACUTE'],
	'DE' => ['&#354;', '&#x0162;', '&Tcedil;', "\x{0162}", 'LATIN CAPITAL LETTER T WITH CEDILLA'],
	'DF' => ['&#223;', '&#x00DF;', '&szlig;', "\x{00DF}", 'LATIN SMALL LETTER SHARP S'],
	'E0' => ['&#341;', '&#x0155;', '&racute;', "\x{0155}", 'LATIN SMALL LETTER R WITH ACUTE'],
	'E1' => ['&#225;', '&#x00C1;', '&aacute;', "\x{00C1}", 'LATIN SMALL LETTER A WITH ACUTE'],
	'E2' => ['&#226;', '&#x00E2;', '&acirc;', "\x{00E2}", 'LATIN SMALL LETTER A WITH CIRCUMFLEX'],
	'E3' => ['&#259;', '&#x0103;', '&abreve;', "\x{0103}", 'LATIN SMALL LETTER A WITH BREVE'],
	'E4' => ['&#228;', '&#x00E4;', '&auml;', "\x{00E4}", 'LATIN SMALL LETTER A WITH UMLAUT'],
	'E5' => ['&#314;', '&#x013A;', '&lacute;', "\x{013A}", 'LATIN SMALL LETTER L WITH ACUTE'],
	'E6' => ['&#263;', '&#x0107;', '&cacute;', "\x{0107}", 'LATIN SMALL LETTER C WITH ACUTE'],
	'E7' => ['&#231;', '&#x00E7;', '&ccedil;', "\x{00E7}", 'LATIN SMALL LETTER C WITH CEDILLA'],
	'E8' => ['&#269;', '&#x010D;', '&ccaron;', "\x{010D}", 'LATIN SMALL LETTER C WITH CARON'],
	'E9' => ['&#233;', '&#x00E9;', '&eacute;', "\x{00E9}", 'LATIN SMALL LETTER E WITH ACUTE'],
	'EA' => ['&#281;', '&#x0119;', '&eogon;', "\x{0119}", 'LATIN SMALL LETTER E WITH OGONEK'],
	'EB' => ['&#235;', '&#x00EB;', '&euml;', "\x{00EB}", 'LATIN SMALL LETTER E WITH UMLAUT'],
	'EC' => ['&#283;', '&#x011B;', '&ecaron;', "\x{011B}", 'LATIN SMALL LETTER E WITH CARON'],
	'ED' => ['&#237;', '&#x00ED;', '&iacute;', "\x{00ED}", 'LATIN SMALL LETTER I WITH ACUTE'],
	'EE' => ['&#238;', '&#x00EE;', '&icirc;', "\x{00EE}", 'LATIN SMALL LETTER I WITH CIRCUMFLEX'],
	'EF' => ['&#271;', '&#x010F;', '&dcaron;', "\x{010F}", 'LATIN SMALL LETTER D WITH CARON'],
	'F0' => ['&#273;', '&#x0111;', '&dstrok;', "\x{0111}", 'LATIN SMALL LETTER D WITH STROKE'],
	'F1' => ['&#324;', '&#x0144;', '&nacute;', "\x{0144}", 'LATIN SMALL LETTER N WITH ACUTE'],
	'F2' => ['&#328;', '&#x0148;', '&ncaron;', "\x{0148}", 'LATIN SMALL LETTER N WITH CARON'],
	'F3' => ['&#243;', '&#x00F3;', '&oacute;', "\x{00F3}", 'LATIN SMALL LETTER O WITH ACUTE'],
	'F4' => ['&#244;', '&#x00F4;', '&ocirc;', "\x{00F4}", 'LATIN SMALL LETTER O WITH CIRCUMFLEX'],
	'F5' => ['&#337;', '&#x0151;', '&odblac;', "\x{0151}", 'LATIN SMALL LETTER O WITH DOUBLE ACUTE'],
	'F6' => ['&#246;', '&#x00F6;', '&ouml;', "\x{00F6}", 'LATIN SMALL LETTER O WITH UMLAUT'],
	'F7' => ['&#247;', '&#x00F7;', '&divide;', "\x{00F7}", 'DIVISION SIGN'],
	'F8' => ['&#345;', '&#x0159;', '&rcaron;', "\x{0159}", 'LATIN SMALL LETTER R WITH CARON'],
	'F9' => ['&#367;', '&#x016F;', '&uring;', "\x{016F}", 'LATIN SMALL LETTER U WITH RING ABOVE'],
	'FA' => ['&#250;', '&#x00FA;', '&uacute;', "\x{00FA}", 'LATIN SMALL LETTER U WITH ACUTE'],
	'FB' => ['&#369;', '&#x0171;', '&udblac;', "\x{0171}", 'LATIN SMALL LETTER U WITH DOUBLE ACUTE'],
	'FC' => ['&#252;', '&#x00FC;', '&uuml;', "\x{00FC}", 'LATIN SMALL LETTER U WITH UMLAUT'],
	'FD' => ['&#253;', '&#x00FD;', '&yacute;', "\x{00FD}", 'LATIN SMALL LETTER Y WITH ACUTE'],
	'FE' => ['&#355;', '&#x0163;', '&tcedil;', "\x{0163}", 'LATIN SMALL LETTER T WITH CEDILLA'],
	'FF' => ['&#183;', '&#x02D9;', '&dot;', "\x{02D9}", 'DOT ABOVE'],
};

sub encode {
   my($str, $type) = @_;
   
   if (!defined $type) { $type = 0; }
   $type = {'decimal'=>0, 'number'=>0, 'hex'=>1, 'name'=>2, 'utf8'=>3, 'description'=>4}->{lc($type)};
   
	my $encoded = "";
	foreach my $char (split /|/, $str) {
		next unless ord($char);
		if (ord($char)<128) { $encoded .= $char } # leave low-bit ASCII characters as they are
		elsif (ord($char)<256) {
			# if it's not in our map it's not included from the return string
			next unless defined $char_map->{sprintf("%0.2X", ord($char))};
			$encoded .= $char_map->{sprintf("%0.2X", ord($char))}[$type];
		}
		else {$encoded .= '_' } # characters over 256 shouldn't be in the source string but I'm paranoid
	}
	return $encoded;
}

1;
__END__
# Below is stub documentation for your module. You'd better edit it!

=head1 NAME

HTML::Entities::Latin2 - Encode ISO-8859-2 characters into SGML entities.

=head1 SYNOPSIS

	use HTML::Entities::Latin2;

	$lat2_string = "z\246mmel napos id\336";

	print HTML::Entities::Latin2::encode($lat2_string, 'name');
	# z&Sacute;mmel napos id&Tcedil;
	 
	print HTML::Entities::Latin2::encode($lat2_string); # decimal is default
	print HTML::Entities::Latin2::encode($lat2_string, 'decimal');
	# z&#346;mmel napos id&#354;
	
	print HTML::Entities::Latin2::encode($lat2_string, 'hex');
	# z&#x015A;mmel napos id&#x0162;
	
	print HTML::Entities::Latin2::encode($lat2_string, 'utf8');
	# z\x{015A}}mmel napos id\x{0162}
	
	print HTML::Entities::Latin2::encode($lat2_string, 'description');
	# zLATIN CAPITAL LETTER S WITH ACUTEmmel napos idLATIN CAPITAL LETTER T WITH CEDILLA


=head1 DESCRIPTION

Translate high-bit Latin2 characters into SGML entities based on the ISO8859-2
character map, with option of using named, decimal or hex entities. Using
this process will allow Eastern European encoded text to be used in ASCII
HTML pages.

=head2 EXPORT

None by default.

=head1 SEE ALSO

HTML::Entities

=head1 AUTHOR

Michael Mathews, E<lt>michael@perlinpractice.com<gt>

=head1 COPYRIGHT AND LICENSE

Copyright 2004 Michael Mathews. All rights reserved.

This library is free software; you can redistribute it and/or
modify it under the same terms as Perl itself.

=head1 CAVEATS

This library has only been tested on Perl 5.6

=cut
