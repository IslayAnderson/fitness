<?php
declare(strict_types=1);

namespace App\Model;

final class Measurement extends BaseModel
{
    public function latest(int $limit = 1000): array
    {
        $limit = max(1, min($limit, 2000));
        $sql = "SELECT m.*, b.name AS body_part_name
                FROM measurements m
                LEFT JOIN body b ON m.body_part = b.id
                ORDER BY m.datetime DESC
                LIMIT {$limit}";
        return $this->fetchAll($sql);
    }

    public function byBodyPart(int $bodyPartId, int $limit = 500): array
    {
        $limit = max(1, min($limit, 2000));
        $sql = "SELECT m.*, b.name AS body_part_name
                FROM measurements m
                LEFT JOIN body b ON m.body_part = b.id
                WHERE m.body_part = ?
                ORDER BY m.datetime DESC
                LIMIT {$limit}";
        return $this->fetchAll($sql, [$bodyPartId]);
    }

    public function create(?string $datetime, int $bodyPartId, float $measurement): int
    {
        $sql = 'INSERT INTO measurements (datetime, body_part, measurement) VALUES (?,?,?)';
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$datetime ?? date('Y-m-d H:i:s'), $bodyPartId, $measurement]);
        return (int)$this->pdo->lastInsertId();
    }
}
