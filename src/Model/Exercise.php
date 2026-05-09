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

    public function total_weight(): float
    {
        {
            $total_weight = 0;
            $dates = array();
            $log = $this->pdo->query('SELECT * FROM log')->fetchAll();
            foreach ($log as $row) {
                $total_weight += ($row['weight']*$row['reps'])*$row['sets'];
                $dates[explode(' ', $row['datetime'])[0]]['time'][]=explode(' ', $row['datetime'])[1];
            }

            return $total_weight;
        }
    }
}
