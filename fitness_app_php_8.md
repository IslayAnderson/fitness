# Fitness App — PHP 8.2 / Apache / MariaDB

This canvas contains a complete project scaffold for the fitness app you requested. It uses:

- PHP 8.2 with PDO
- Apache (recommended mod\_rewrite)
- MariaDB / MySQL
- Twig templating
- BEM-style SCSS
- Vanilla JS

The included installer will ask for database credentials and import the supplied `_fitness.sql` schema (place that file in the project root before running the installer).

---

## Quick start (what to do next)

1. Place this project folder into your Apache `DocumentRoot` (or configure a virtual host pointing to the `public/` folder).
2. Put the supplied `_fitness.sql` (the file you uploaded) into the project root.
3. Run `composer install` to fetch Twig. (composer.json is included.)
4. Make sure `cache/` and `logs/` are writable by the web server.
5. Open `http://your-host/installer.php` in a browser and enter your database credentials. The installer will create the database/tables by importing `_fitness.sql`.
6. Visit the app pages: `/measurements`, `/exercise`, `/diary`, `/data`.
7. API endpoints are under `/api/*` (see README sections below).

---

## File structure (important files)

```
/ (project root)
  composer.json
  installer.php
  _fitness.sql  <-- place your SQL here before running installer
  public/
    .htaccess
    index.php
    public/
    assets/
      css/main.css (compiled from scss)
      scss/_variables.scss
      scss/main.scss
      js/app.js
  src/
    Config/Database.php
    Controller/PageController.php
    Controller/ApiController.php
    Model/*.php
    Helpers/Response.php
  templates/
    layout.twig
    measurements.twig
    exercise.twig
    diary.twig
    data.twig
    partials/*.twig
  cache/
  logs/
  README.md
```

---

## Key files (open to view/edit)

Below are the main files you'll want to inspect. **Do not paste them elsewhere** — they're provided here for quick copy.

---

### composer.json

```json
{
  "name": "fitness/app",
  "description": "Fitness tracker app - PHP 8.2, Twig",
  "require": {
    "twig/twig": "^3.0"
  },
  "autoload": {
    "psr-4": { "App\\": "src/" }
  }
}
```

---

### installer.php

```php
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
```

---

### public/.htaccess

```apacheconf
RewriteEngine On
RewriteCond %{REQUEST_FILENAME} !-f
RewriteRule ^ index.php [QSA,L]

# For Apache: ensure public/ is document root, or use this .htaccess in public/ folder.
```

---

### public/index.php (router)

```php
<?php
require_once __DIR__ . '/../vendor/autoload.php';

use App\Config\Database;
use App\Controller\PageController;
use App\Controller\ApiController;

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];

// Basic routing
$twigLoader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../templates');
$twig = new \Twig\Environment($twigLoader, [
    'cache' => __DIR__ . '/../cache',
    'auto_reload' => true,
]);

$db = Database::getPdo();

// API routes
if (preg_match('#^/api/([^/]+)$#', $uri, $m)) {
    $resource = $m[1];
    $api = new ApiController($db);
    header('Content-Type: application/json');
    if ($method === 'GET') echo json_encode($api->get($resource));
    elseif ($method === 'PUT') {
        $body = json_decode(file_get_contents('php://input'), true) ?? [];
        echo json_encode($api->put($resource, $body));
    } else {
        http_response_code(405);
        echo json_encode(['error' => 'Method not allowed']);
    }
    exit;
}

// Page routes
$pc = new PageController($twig, $db);
if ($uri === '/' || $uri === '/measurements') $pc->measurements();
elseif ($uri === '/exercise') $pc->exercise();
elseif ($uri === '/diary') $pc->diary();
elseif ($uri === '/data') $pc->data();
else {
    http_response_code(404);
    echo $twig->render('layout.twig', ['title' => 'Not found', 'content' => '<h1>404</h1>']);
}
```

---

### src/Config/Database.php

```php
<?php
namespace App\Config;

class Database {
    private static ?\PDO $pdo = null;

    public static function getPdo(): \PDO {
        if (self::$pdo) return self::$pdo;

        // Read credentials from environment or fallback to these defaults
        $host = getenv('DB_HOST') ?: '127.0.0.1';
        $port = getenv('DB_PORT') ?: '3306';
        $db = getenv('DB_NAME') ?: 'fitness';
        $user = getenv('DB_USER') ?: 'root';
        $pass = getenv('DB_PASS') ?: '';

        $dsn = "mysql:host=$host;port=$port;dbname=$db;charset=utf8mb4";
        self::$pdo = new \PDO($dsn, $user, $pass, [
            \PDO::ATTR_ERRMODE => \PDO::ERRMODE_EXCEPTION,
            \PDO::ATTR_DEFAULT_FETCH_MODE => \PDO::FETCH_ASSOC,
        ]);
        return self::$pdo;
    }
}
```

---

### src/Controller/ApiController.php

```php
<?php
namespace App\Controller;

use PDO;

class ApiController {
    private PDO $pdo;
    public function __construct(PDO $pdo) { $this->pdo = $pdo; }

    public function get(string $resource) {
        switch ($resource) {
            case 'log':
                return $this->fetchAll('SELECT l.*, e.exercise as exercise_name FROM log l LEFT JOIN exercise e ON l.exercise = e.id ORDER BY l.datetime DESC LIMIT 500');
            case 'diary':
                return $this->fetchAll('SELECT * FROM diary ORDER BY datetime DESC LIMIT 500');
            case 'measurements':
            case 'measurments': // accept both
                return $this->fetchAll('SELECT m.*, b.name as body_part_name FROM measurements m LEFT JOIN body b ON m.body_part = b.id ORDER BY m.datetime DESC LIMIT 1000');
            case 'body':
                return $this->fetchAll('SELECT * FROM body');
            case 'effort':
                return $this->fetchAll('SELECT * FROM effort');
            case 'exercise':
                return $this->fetchAll('SELECT * FROM exercise');
            case 'muscle_groups':
                return $this->fetchAll('SELECT * FROM muscle_groups');
            default:
                http_response_code(404); return ['error' => 'Unknown resource'];
        }
    }

    public function put(string $resource, array $data) {
        switch ($resource) {
            case 'log':
                $sql = 'INSERT INTO log (datetime, exercise, weight, tension_level, reps, sets, time, distance, effort) VALUES (?,?,?,?,?,?,?,?,?)';
                $stmt = $this->pdo->prepare($sql);
                $stmt->execute([
                    $data['datetime'] ?? date('Y-m-d H:i:s'),
                    $data['exercise'] ?? null,
                    $data['weight'] ?? null,
                    $data['tension_level'] ?? null,
                    $data['reps'] ?? null,
                    $data['sets'] ?? null,
                    $data['time'] ?? null,
                    $data['distance'] ?? null,
                    $data['effort'] ?? null,
                ]);
                return ['ok' => true, 'id' => $this->pdo->lastInsertId()];
            case 'diary':
                $sql = 'INSERT INTO diary (datetime, diary) VALUES (?,?)';
                $stmt = $this->pdo->prepare($sql);
                $stmt->execute([$data['datetime'] ?? date('Y-m-d H:i:s'), $data['diary'] ?? '']);
                return ['ok' => true, 'id' => $this->pdo->lastInsertId()];
            case 'measurements':
            case 'measurments':
                $sql = 'INSERT INTO measurements (datetime, body_part, measurement) VALUES (?,?,?)';
                $stmt = $this->pdo->prepare($sql);
                $stmt->execute([$data['datetime'] ?? date('Y-m-d H:i:s'), $data['body_part'] ?? null, $data['measurement'] ?? null]);
                return ['ok' => true, 'id' => 
```
