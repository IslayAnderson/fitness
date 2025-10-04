<?php
namespace App\Controller;

use Twig\Environment;
use PDO;

class PageController {
    private Environment $twig;
    private PDO $pdo;

    public function __construct(Environment $twig, PDO $pdo) {
        $this->twig = $twig;
        $this->pdo = $pdo;
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

    public function diary() {
        echo $this->twig->render('diary.twig', [
            'title' => 'Diary'
        ]);
    }

    public function data() {
        echo $this->twig->render('data.twig', [
            'title' => 'Progress Data'
        ]);
    }
}
