<?

$ref = array(
"1" => "a",
"q" => "a",
"z" => "a",
"2" => "s",
"w" => "s",
"x" => "s",
"3" => "d",
"e" => "d",
"c" => "d",
"4" => "f",
"r" => "f",
"v" => "f",
"5" => "f",
"t" => "f",
"g" => "f",
"b" => "f",
"6" => "j",
"y" => "j",
"h" => "j",
"n" => "j",
"7" => "j",
"u" => "j",
"m" => "j",
"8" => "k",
"i" => "k",
"," => "k",
"9" => "l",
"o" => "l",
"." => "l",
"0" => ";",
"p" => ";",
"/" => ";",
"-" => ";",
"[" => ";",
"'" => ";",
"=" => ";",
"]" => ";",
);

$file = file("words.txt");
$file = array_map("strtolower", $file);
$file = array_map("trim", $file);

$out = [];
foreach($file as $line):
	$before = $line;
	$after = $line;
	foreach($ref as $k=>$v):
		$after = str_replace($k, $v, $after);
	endforeach;
	$out[$before] = $after;
endforeach;

$file2 = fopen("map.txt", "w+");
foreach($out as $k=>$v):
	fwrite($file2, "$k\t$v\n");
endforeach;
fclose($file2);








?>
