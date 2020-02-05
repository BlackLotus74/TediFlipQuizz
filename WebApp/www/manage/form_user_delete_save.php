<?php

session_start();
require_once dirname(__DIR__, 2).'/Loader.php';
require_once dirname(__DIR__, 2).'/Debug.php';

$username = $_POST['username'] ?? null;

if(!empty($username)) {
    $accounts = new Models\AccountManager;

    if($accounts->removeUser($username)) {
        echo "1";
        exit;
    }
}

echo "0";
