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

$file1 = file_get_contents("words.txt");
$file1 = strtolower($file1);

foreach($ref as $k=>$v):
	$file1 = str_replace($k, $v, $file1);
endforeach;

$file2 = fopen("map.txt", "w+");
fwrite($file2, $file1);
fclose($file2);








?>
