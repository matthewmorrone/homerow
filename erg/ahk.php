<?
function sortout($arr) {
	arsort($arr);
	return $arr;
}

function ref() {
	return $ref = array(
		"q" => "a",
		"z" => "a",
		"w" => "s",
		"x" => "s",
		"e" => "d",
		"c" => "d",
		"r" => "f",
		"v" => "f",
		"t" => "g",
		"b" => "g",
		"y" => "h",
		"n" => "h",
		"u" => "j",
		"m" => "j",
		"i" => "k",
		"o" => "l",
		"p" => "l",
		);
}

function words($asString) {
	if ($asString) {
		$file = file_get_contents("words.txt");
		$file = strtolower($file);
		$file = trim($file);
		return $file;
	}
	$file = file("words.txt");
	$file = array_map("strtolower", $file);
	$file = array_map("trim", $file);
	return $file;
}

function wordsToChars() {
	$ref = ref();
	$file = words(true);

	foreach($ref as $k=>$v):
		$file1 = str_replace($k, $v, $file1);
	endforeach;

	$file2 = fopen("chars.txt", "w+");
	fwrite($file2, $file1);
	fclose($file2);
}

function charsInfo() {
	$chars = array_map("trim", file("chars.txt"));

	$unis = array_unique($chars);
	// print_r(sortout($unis));

	$vals = array_count_values($chars);
	// print_r(sortout($vals));
	print_r(sortout(array_count_values($vals)));

	echo "\n\n";
	echo "C:     ".count($chars)."\n";
	echo "U:     ".count($unis)."\n";
	echo "C - U: ".(count($chars)-count($unis))."\n";
	echo "\n\n";

}


function generateMap() {
	$ref = ref();
	$file = words();



	$out = out();

	$file2 = fopen("map.txt", "w+");
	foreach($out as $k=>$v):
		fwrite($file2, "$k\t$v\n");
	endforeach;
	fclose($file2);

}


function out() {
	$file = words();
	$ref = ref();
	foreach($file as $line):
		$before = $line;
		$after = $line;
		foreach($ref as $k=>$v):
			$after = str_replace($k, $v, $after);
		endforeach;
		$out[$before] = $after;
	endforeach;
	return $out;
}


function toAHK() {
	$out = out();
	$file = fopen("map.ahk", "w+");
	foreach($out as $k=>$v):
		fwrite($file, ":*:$v::$k\n");
	endforeach;
	fclose($file);
}


function findIso() {
	$chars = array_map("trim", file("map.ahk"));
	$iso = [];
	foreach($chars as $line):
		$line = explode("::", $line);
		// echo $line[1]." ".$line[2]."\n";
		if (strcmp($line[1], $line[2]) === 0) {
			// echo $line[1]."\n";
			$iso[] = $line[1];
		}
	endforeach;
	return $iso;
}

function findCollisions() {
	$chars = array_map("trim", file("map.ahk"));
	$crash = [];
	$crash2 = [];
	foreach($chars as $line):
		$line = explode("::", $line);
		$crash[$line[1]][] = $line[2];
	endforeach;
	foreach($crash as $k=>$entry):
		if (count($entry) > 1) {
			// $crash2[count($entry)][$k] = $entry;
			// $crash2[count($entry)][$k][strlen($k)] = $entry;
			$crash2[count($entry)][strlen($k)][$k] = $entry;
		}
	endforeach;
	// print_r($crash[2]);
	// print_r($crash[3]);
	// print_r($crash[4]);
	// print(count($crash[2]))."\n";
	// print(count($crash[3]))."\n";
	// print(count($crash[4]))."\n";
	return $crash2;
}

function printCollisions() {
	$z = findCollisions();
	print_r($z);
	return;
	foreach($z as $a=>$b):
		asort($b);
		echo "\n\n\n".$a."\n\n\n";
		foreach($b as $c=>$d):
			echo $c.":\t";
			foreach($d as $e=>$f):
				echo $f."\t";
			endforeach;
			echo "\n";
		endforeach;
	endforeach;
}

// generateMap();
// charsInfo();
// toAHK();
// parseAHK();
// findCollisions();
printCollisions();


?>
