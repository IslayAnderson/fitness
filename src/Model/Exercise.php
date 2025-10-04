<?php
declare(strict_types=1);

namespace App\Model;

final class Exercise extends BaseModel
{
    public function all(): array
    {
        return $this->fetchAll('SELECT * FROM exercise ORDER BY muscle_group, exercise');
    }

    public function byMuscleGroup(int $muscleGroupId): array
    {
        return $this->fetchAll('SELECT * FROM exercise WHERE muscle_group = ? ORDER BY exercise', [$muscleGroupId]);
    }

    public function find(int $id): ?array
    {
        return $this->fetchOne('SELECT * FROM exercise WHERE id = ?', [$id]);
    }
}
