<?php
declare(strict_types=1);

namespace App\Helpers;

final class Response
{
    private function __construct() {}

    /**
     * Send a JSON response with status and optional extra headers.
     */
    public static function json(
        mixed $data,
        int $status = 200,
        array $headers = []
    ): void {
        http_response_code($status);
        // Default headers
        header('Content-Type: application/json; charset=utf-8');

        // Additional headers (e.g., caching, custom)
        foreach ($headers as $name => $value) {
            header($name . ': ' . $value);
        }

        echo json_encode(
            $data,
            JSON_UNESCAPED_UNICODE | JSON_UNESCAPED_SLASHES
        );
    }

    /**
     * Common OK response wrapper.
     */
    public static function success(
        array|object $data = [],
        int $status = 200,
        array $meta = [],
        array $headers = []
    ): void {
        self::json([
            'ok'   => true,
            'data' => $data,
            'meta' => $meta,
        ], $status, $headers);
    }

    /**
     * Common error response wrapper.
     */
    public static function error(
        string|array $message,
        int $status = 400,
        ?string $code = null,
        array $extra = [],
        array $headers = []
    ): void {
        $payload = [
            'ok'    => false,
            'error' => [
                'message' => $message,
            ],
        ];
        if ($code !== null) {
            $payload['error']['code'] = $code;
        }
        if (!empty($extra)) {
            $payload['error']['extra'] = $extra;
        }

        self::json($payload, $status, $headers);
    }

    /**
     * Turn an exception into a JSON error response.
     */
    public static function fromThrowable(\Throwable $e, int $status = 500): void {
        $code = $e->getCode();
        self::error(
            $e->getMessage(),
            $status,
            $code ? (string)$code : null
        );
    }

    /**
     * (Optional) Basic CORS support. Call at the start of index.php if needed.
     */
    public static function cors(
        string $origin = '*',
        array $methods = ['GET', 'PUT', 'POST', 'DELETE', 'OPTIONS'],
        array $headers = ['Content-Type', 'Authorization', 'Accept']
    ): void {
        header('Access-Control-Allow-Origin: ' . $origin);
        header('Access-Control-Allow-Methods: ' . implode(',', $methods));
        header('Access-Control-Allow-Headers: ' . implode(',', $headers));

        // Handle preflight
        if (($_SERVER['REQUEST_METHOD'] ?? '') === 'OPTIONS') {
            http_response_code(204);
            exit;
        }
    }
}
