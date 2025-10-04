<?php
declare(strict_types=1);

namespace App\Model;

final class Body extends BaseModel
{
    public function all(): array
    {
        return $this->fetchAll('SELECT * FROM body ORDER BY id ASC');
    }

    public function find(int $id): ?array
    {
        return $this->fetchOne('SELECT * FROM body WHERE id = ?', [$id]);
    }
}
