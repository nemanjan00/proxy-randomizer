<?php
$data = explode("\n", explode("\n\n", file_get_contents("https://raw.githubusercontent.com/clarketm/proxy-list/master/proxy-list.txt"))[1]);

$output = file_get_contents("./haproxy.cfg.tpl");

shuffle($data);

$data = array_splice($data, 0, 50);

foreach ($data as $i => $line) {
	$line = trim(explode(" ", $line)[0]);
	$output .= "	server ip-$i $line check\n";
}

echo $output;

