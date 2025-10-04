<?php
namespace App\Config;

class Database {
    private static ?\PDO $pdo = null;

    public static function getPdo(): \PDO {
        if (self::$pdo) return self::$pdo;

        // Read credentials from environment or fallback to these defaults
        $host = getenv('DB_HOST') ?: 'localhost';
        $port = getenv('DB_PORT') ?: '3306';
        $db = getenv('DB_NAME') ?: 'local';
        $user = getenv('DB_USER') ?: 'root';
        $pass = getenv('DB_PASS') ?: 'root';

        $dsn = "mysql:host=$host;port=$port;dbname=$db;charset=utf8mb4";
        self::$pdo = new \PDO($dsn, $user, $pass, [
            \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
            \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        ]);
        return self::$pdo;
    }
}