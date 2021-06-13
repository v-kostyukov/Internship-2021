<?php
$ip_server = $_SERVER['SERVER_ADDR'];
$info_server =  php_uname();
$os_server = PHP_OS;

echo "<h1>Hello World!</h1><br>";
echo "<b>Server info:</b> $info_server", "<br><p>";
echo "<b>Server OS:</b> $os_server", "<br><p>";
echo "<b>Server IP Address is:</b> $ip_server", "<br><p>";
echo "<b>Made by <font color=blue>Vitaliy Kostyukov</b>";
?>
