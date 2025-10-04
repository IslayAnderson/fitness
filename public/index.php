<?php
require_once __DIR__ . '/../vendor/autoload.php';

use App\Config\Database;
use App\Controller\PageController;
use App\Controller\ApiController;

(new App\Controller\DotEnvEnvironment)->load(__DIR__ . '/../');

$uri = parse_url($_SERVER['REQUEST_URI'], PHP_URL_PATH);
$method = $_SERVER['REQUEST_METHOD'];

// Basic routing
$twigLoader = new \Twig\Loader\FilesystemLoader(__DIR__ . '/../templates');
$twig = new \Twig\Environment($twigLoader, [
    'cache' => __DIR__ . '/../cache',
    'auto_reload' => true,
]);
// Determine base path from the executing script dir (works if app runs in a subfolder)
$scriptDir = rtrim(str_replace('\\', '/', dirname($_SERVER['SCRIPT_NAME'] ?? '')), '/');
$basePath  = $scriptDir === '' ? '' : $scriptDir;

// Share with Twig
$twig->addGlobal('base_path', $basePath);


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
if ($uri === '/' ) $pc->home();
elseif ($uri === '/measurements') $pc->measurements();
elseif ($uri === '/exercise') $pc->exercise();
elseif ($uri === '/diary') $pc->diary();
elseif ($uri === '/data') $pc->data();
else {
    http_response_code(404);
    echo $twig->render('layout.twig', ['title' => 'Not found', 'content' => '<h1>404</h1>']);
}