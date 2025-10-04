<?php
declare(strict_types=1);

namespace App\Model;

final class Diary extends BaseModel
{
    public function latest(int $limit = 500): array
    {
        $limit = max(1, min($limit, 1000));
        return $this->fetchAll("SELECT * FROM diary ORDER BY datetime DESC LIMIT {$limit}");
    }

    public function create(?string $datetime, string $entry): int
    {
        $sql = 'INSERT INTO diary (datetime, diary) VALUES (?, ?)';
        $stmt = $this->pdo->prepare($sql);
        $stmt->execute([$datetime ?? date('Y-m-d H:i:s'), $entry]);
        return (int)$this->pdo->lastInsertId();
    }
}
