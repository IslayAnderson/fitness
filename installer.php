<?php
// installer.php - web/cli DB installer which imports _fitness.sql
// Place _fitness.sql in project root before running.

if (php_sapi_name() === 'cli') {
    // Simple CLI installer
    echo "Enter DB host (default: localhost): "; $host = trim(fgets(STDIN)) ?: '127.0.0.1';
    echo "Enter DB port (default: 3306): "; $port = trim(fgets(STDIN)) ?: '3306';
    echo "Enter DB name (will be created if missing): "; $dbname = trim(fgets(STDIN));
    echo "Enter DB user: "; $user = trim(fgets(STDIN));
    echo "Enter DB password: "; $pass = trim(fgets(STDIN));

    install($host, $port, $dbname, $user, $pass);
    exit;
}

/**
 * @param string $host
 * @param string $port
 * @param string $dbname
 * @param string $user
 * @param string $pass
 * @return void
 */
function install(string $host, string $port, string $dbname, string $user, string $pass) {
    $sqlFile = __DIR__ . DIRECTORY_SEPARATOR . '_fitness.sql';

    if (!file_exists($sqlFile)) {
        echo "SQL file not found at: $sqlFile\n";
        return;
    }

    try {
        $pdo = new PDO("mysql:host=$host;port=$port;charset=utf8mb4", $user, $pass, [
            PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION
        ]);

        // Create database if not exists
        $pdo->exec("CREATE DATABASE IF NOT EXISTS `" . addslashes($dbname) . "` CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci\n");
        $pdo->exec("USE `" . addslashes($dbname) . "`");

        // Read SQL and import
        $sql = file_get_contents($sqlFile);
        // Split by semicolon followed by line break; simple but should work for this dump
        $statements = array_filter(array_map('trim', preg_split('/;\s*\n/', $sql)));

        foreach ($statements as $stmt) {
            if ($stmt === '') continue;
            $pdo->exec($stmt);
        }

        echo "Imported SQL into database '$dbname' successfully.\n";
    } catch (Exception $e) {
        echo "Installation error: " . $e->getMessage() . "\n";
    }
}

// If called via web form
if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $host = $_POST['db_host'] ?? '127.0.0.1';
    $port = $_POST['db_port'] ?? '3306';
    $dbname = $_POST['db_name'] ?? '';
    $user = $_POST['db_user'] ?? '';
    $pass = $_POST['db_pass'] ?? '';

    ob_start();
    install($host, $port, $dbname, $user, $pass);
    $output = ob_get_clean();
}
?>

<!doctype html>
<html>
<head>
    <meta charset="utf-8">
    <title>Installer - Fitness App</title>
    <style>body{font-family:system-ui,Segoe UI,Roboto,Helvetica,Arial;margin:2rem}label{display:block;margin-top:.8rem}</style>
</head>
<body>
<h1>Installer</h1>
<p>Place <code>_fitness.sql</code> in the project root then enter DB credentials below. The installer will create the database and import the file.</p>
<?php if (!empty($output)): ?>
    <pre><?php echo htmlspecialchars($output); ?></pre>
<?php endif; ?>
<form method="post">
    <label>Host <input name="db_host" value="127.0.0.1"></label>
    <label>Port <input name="db_port" value="3306"></label>
    <label>DB Name <input name="db_name" required></label>
    <label>User <input name="db_user" required></label>
    <label>Password <input name="db_pass" type="password"></label>
    <button type="submit">Install</button>
</form>
</body>
</html>