<?php
namespace App\Controller;

use PDO;
use Exception;

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
                http_response_code(404);
                return ['error' => 'Unknown resource'];
        }
    }

    public function put(string $resource, array $data) {
        try {
            switch ($resource) {
                case 'log':
                    $sql = 'INSERT INTO log (datetime, exercise, weight, tension_level, reps, sets, time, distance, effort) 
                            VALUES (?,?,?,?,?,?,?,?,?)';
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
                    $stmt->execute([
                        $data['datetime'] ?? date('Y-m-d H:i:s'),
                        $data['diary'] ?? ''
                    ]);
                    return ['ok' => true, 'id' => $this->pdo->lastInsertId()];

                case 'measurements':
                case 'measurments':
                    $sql = 'INSERT INTO measurements (datetime, body_part, measurement) VALUES (?,?,?)';
                    $stmt = $this->pdo->prepare($sql);
                    $stmt->execute([
                        $data['datetime'] ?? date('Y-m-d H:i:s'),
                        $data['body_part'] ?? null,
                        $data['measurement'] ?? null
                    ]);
                    return ['ok' => true, 'id' => $this->pdo->lastInsertId()];

                default:
                    http_response_code(404);
                    return ['error' => 'Unknown resource'];
            }
        } catch (Exception $e) {
            http_response_code(400);
            return ['error' => $e->getMessage()];
        }
    }

    private function fetchAll(string $sql) {
        $s = $this->pdo->query($sql);
        return $s->fetchAll();
    }
}
