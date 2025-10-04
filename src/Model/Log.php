<?php
declare(strict_types=1);

namespace App\Model;

use Exception;

final class Log extends BaseModel
{
    public function latest(int $limit = 500): array
    {
        $limit = max(1, min($limit, 1000));
        $sql = "SELECT l.*, e.exercise AS exercise_name
                FROM log l
                LEFT JOIN exercise e ON l.exercise = e.id
                ORDER BY l.datetime DESC
                LIMIT {$limit}";
        return $this->fetchAll($sql);
    }

    /**
     * Create a log row.
     * @param array{
     *   datetime?: string,
     *   exercise?: int,
     *   weight?: float|null,
     *   tension_level?: int|null,
     *   reps?: int|null,
     *   sets?: int|null,
     *   time?: string|null,
     *   distance?: float|null,
     *   effort?: int|null,
     *   lat?: float|null,
     *   lng?: float|null
     * } $data
     */
    public function create(array $data): int
    {
        $hasGeo = isset($data['lat'], $data['lng']) && $data['lat'] !== null && $data['lng'] !== null;

        if ($hasGeo) {
            // Insert without location first (easier with PDO), then update geometry.
            $sql = 'INSERT INTO log (datetime, location, exercise, weight, tension_level, reps, sets, time, distance, effort)
                    VALUES (?,?,?,?,?,?,?,?,?,?)';
            $stmt = $this->pdo->prepare($sql);
            $stmt->execute([
                $data['datetime'] ?? date('Y-m-d H:i:s'),
                null,
                $data['exercise'] ?? null,
                $data['weight'] ?? null,
                $data['tension_level'] ?? null,
                $data['reps'] ?? null,
                $data['sets'] ?? null,
                $data['time'] ?? null,
                $data['distance'] ?? null,
                $data['effort'] ?? null,
            ]);
            $id = (int)$this->pdo->lastInsertId();

            // Try to set POINT(lng lat). If spatial functions aren't enabled, just ignore.
            try {
                $lng = (float)$data['lng'];
                $lat = (float)$data['lat'];
                $this->pdo->exec(
                    "UPDATE log SET location = ST_GeomFromText('POINT({$lng} {$lat})') WHERE id = {$id}"
                );
            } catch (Exception) {
                // ignore spatial errors
            }

            return $id;
        }

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
        return (int)$this->pdo->lastInsertId();
    }
}
