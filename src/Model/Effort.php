<?php
declare(strict_types=1);

namespace App\Model;

final class Effort extends BaseModel
{
    public function all(): array
    {
        return $this->fetchAll('SELECT * FROM effort ORDER BY id ASC');
    }

    public function find(int $id): ?array
    {
        return $this->fetchOne('SELECT * FROM effort WHERE id = ?', [$id]);
    }
}
