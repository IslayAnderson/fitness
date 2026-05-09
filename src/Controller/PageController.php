<?php
namespace App\Controller;

use Twig\Environment;
use PDO;

class PageController {
    protected Environment $twig;
    protected PDO $pdo;

    public function __construct(Environment $twig, PDO $pdo) {
        $this->twig = $twig;
        $this->pdo = $pdo;
    }

    public function get_pages() {
        $pages = glob(__DIR__.'/../pages/*.php');
        foreach ($pages as $page) {
            include $page;
        }
    }

    public function home() {
        echo $this->twig->render('home.twig', [
            'title' => 'Welcome to Fitness App',
        ]);
    }

    public function measurements() {
        $bodyParts = $this->pdo->query('SELECT * FROM body')->fetchAll();
        echo $this->twig->render('measurements.twig', [
            'title' => 'Measurements',
            'bodyParts' => $bodyParts
        ]);
    }

    public function exercise() {
        $muscles   = $this->pdo->query('SELECT * FROM muscle_groups')->fetchAll();
        $exercises = $this->pdo->query('SELECT * FROM exercise order by exercise asc')->fetchAll();
        $last_exercise = $this->pdo->query(
            'SELECT * FROM log INNER 
                    JOIN exercise ON log.exercise = exercise.id 
                    order by log.id desc limit 1'
        )->fetchAll();
        $efforts   = $this->pdo->query('SELECT * FROM effort')->fetchAll();

        echo $this->twig->render('exercise.twig', [
            'title'     => 'Exercise Log',
            'muscles'   => $muscles,
            'exercises' => $exercises,
            'last_exercise' => $last_exercise,
            'efforts'   => $efforts
        ]);
    }
    public function get_sorted_times(array $group)
    {
        // Author: some bloke on stackoverflow
        $tmp = array();
        foreach( $group as $times )
        {
            $tmp[$times] = strtotime(substr($times, 0, strpos($times, '-')));
        }
        asort($tmp);
        return array_keys($tmp);
    }
    public function data() {
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
            $total_time += $data['total_time'];
        }

        echo $this->twig->render('data.twig', [
            'title' => 'Progress Data',
            'weeks' => 'some other bullshit',
            'hours' => round(sqrt(abs($total_time))),
            'workouts' => count($dates),
            'total_weight' => $total_weight,
        ]);
    }

    public function diary() {
        echo $this->twig->render('diary.twig', [
            'title' => 'Diary'
        ]);
    }


    // In PageController.php
    public function recentLogs() {
        // 1) fetch all muscle groups and their exercises
        $groups = $this->pdo->query(
            'SELECT mg.id AS mg_id, mg.name AS mg_name, e.id AS ex_id, e.exercise AS ex_name
         FROM muscle_groups mg
         LEFT JOIN exercise e ON e.muscle_group = mg.id
         ORDER BY mg.order, e.exercise'
        )->fetchAll();

        // 2) assemble nested structure
        $byGroup = [];
        foreach ($groups as $row) {
            $gid = (int)$row['mg_id'];
            if (!isset($byGroup[$gid])) {
                $byGroup[$gid] = ['id' => $gid, 'name' => $row['mg_name'], 'exercises' => []];
            }
            if ($row['ex_id']) {
                $byGroup[$gid]['exercises'][] = ['id' => (int)$row['ex_id'], 'exercise' => $row['ex_name'], 'logs' => []];
            }
        }

        // 3) fetch last 3 logs per exercise (simple loop; fine for small datasets)
        foreach ($byGroup as &$g) {
            foreach ($g['exercises'] as &$ex) {
                $stmt = $this->pdo->prepare(
                    'SELECT datetime, weight, reps, sets, effort, time, distance
                 FROM log
                 WHERE exercise = ?
                 ORDER BY datetime DESC
                 LIMIT 3'
                );
                $stmt->execute([$ex['id']]);
                $ex['logs'] = $stmt->fetchAll() ?: [];
            }
        }
        unset($g, $ex);

        echo $this->twig->render('last_logs.twig', [
            'title' => 'Recent Logs',
            'groups' => array_values($byGroup),
        ]);
    }

}
