<?php
namespace App\Config;

class Database {
    private static ?\PDO $pdo = null;

    public static function getPdo(): \PDO {
        if (self::$pdo) return self::$pdo;

        // Read credentials from environment or fallback to these defaults
        $host = $_ENV['DB_HOST'] ?: 'localhost';
        $port = $_ENV['DB_PORT'] ?: '3306';
        $db = $_ENV['DB_NAME'] ?: 'local';
        $user = $_ENV['DB_USER'] ?: 'root';
        $pass = $_ENV['DB_PASS'] ?: 'root';

        $dsn = "mysql:host=$host;port=$port;dbname=$db;charset=utf8mb4";
        self::$pdo = new \PDO($dsn, $user, $pass, [
            \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
            \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        ]);
        return self::$pdo;
    }
}