<?
function sortout($arr) {
	arsort($arr);
	return $arr;
}
$chars = array_map("trim", file("flat.txt"));


$unis = array_unique($chars);
// print_r(sortout($unis));

$vals = array_count_values($chars);
// print_r(sortout($vals));
// print_r(sortout(array_count_values($vals)));

// echo "\n\n".count($chars)."\n\n";
// echo "\n\n".count($unis)."\n\n";
// echo "\n\n".count($chars)-count($unis)."\n\n";





?>
