<?php
declare(strict_types=1);

namespace App\Model;

final class Workout_time extends BaseModel
{
    public function all(): array
    {
        $total_time = 0;
        $total_weight = 0;
        $dates = array();
        $log = $this->pdo->query('SELECT * FROM log')->fetchAll();
        foreach ($log as $row) {
            $total_weight += ($row['weight']*$row['reps'])*$row['sets'];
            $dates[explode(' ', $row['datetime'])[0]]['time'][]=explode(' ', $row['datetime'])[1];
        }

        foreach ($dates as $date => $data) {
            if(count($data['time']) >1) {
                $ordered_time = $this->get_sorted_times($data['time']);
                $dates[$date]['total_time'] = strtotime($ordered_time[0]) - strtotime(end($ordered_time));
            }else{
                $dates[$date]['total_time'] = 1;
            }
        }
        foreach ($dates as $date => $data) {
            $dates[$date]['total_time'] = (abs($data['total_time'])/60)/60;
        }

        return $dates;
    }
    public function get_sorted_times(array $group)
    {
        // Author: some bloke on stackoverflow
        $tmp = array();
        foreach( $group as $times )
        {
            $tmp[$times] = strtotime($times);
        }
        asort($tmp);
        return array_keys($tmp);
    }
}
