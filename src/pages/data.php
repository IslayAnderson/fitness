<?php

namespace App\pages;
use App\Controller\PageController;
use Twig\Environment;
use PDO;
class Pages extends PageController
{
    public function data() {
        $total_time = 0;
        $total_weight = 0;
        $dates = array();
        $log = $this->pdo->query('SELECT * FROM log')->fetchAll();
        foreach ($log as $row) {
            $total_weight += ($row['weight']*$row['reps'])*$row['sets'];
            $date[explode(' ', $row['datetime'])[0]]['time'] = explode(' ', $row['datetime'])[0];
        }
        foreach ($dates as $date => $data) {
            $ordered_time = asort($data['time']);
            $dates[$date]['total_time'] = $ordered_time[0]-$ordered_time[-1];
        }
        foreach ($dates as $date => $data) {
            $total_time += $data['total_time'];
        }
        echo $this->twig->render('data.twig', [
            'title' => 'Progress Data',
            'weeks' => 'som other bullshit',
            'hours' => $total_time,
            'workouts' => count($dates),
            'total_weight' => $total_weight,
        ]);
    }

}