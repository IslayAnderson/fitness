<?php
declare(strict_types=1);

namespace App\Model;

final class MuscleGroup extends BaseModel
{
    public function all(): array
    {
        return $this->fetchAll('SELECT * FROM muscle_groups ORDER BY id ASC');
    }

    public function find(int $id): ?array
    {
        return $this->fetchOne('SELECT * FROM muscle_groups WHERE id = ?', [$id]);
    }
}
