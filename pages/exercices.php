<?php
    // Vérification si l'exercice a bien été selectionné
    if(!isset($params[1]) or empty($params[1]) or !is_numeric($params[1]))
    {
        $_SESSION['error'] = "Veuillez d'abord cliquer sur un exercice";
        session_write_close();
        header('location: '.WEBROOT.'accueil');
    };

    // Récupère l'ID de l'exercice
    $exercice_id = $params[1];

    // Si il n'est pas connecté, on verifie si le niveau de l'exercice est L1
    if(!isset($_SESSION['Auth']))
    {
        $query = "SELECT a.num_annee as annee FROM exercice JOIN matieres m ON exercice.id_matiere = m.id_matiere JOIN annees a ON m.code_annee = a.code_annee WHERE id_exercice = ? LIMIT 1";
        $sem_id = newSQLQuery( $query, "select", "fetch", "FETCH_NUM", $exercice_id)[0];

        if($sem_id != 1) {
            $_SESSION['error'] = "Vous devez vous connecter pour acceder a cet exercice";
            session_write_close();
            header('location: ' . WEBROOT . 'login');
        }
    }

    if(isset($_POST['ajouterCommentaire']))
        include_once 'addComment.php';

    /*
     * Vérifications a chaque nouvelle affichage d'une question
     */
    $end = false;
    if(isset($_POST['next'])) // Si ce n'est pas la première question (Si il a cliqué sur Suivant)
    {
        // Vérification si toutes les données cachées sont passées
        if(isset($_POST['answers']) and isset($_POST['qnumber']) and isset($_POST['starttime']) and !empty($_POST['answers']) and !empty($_POST['qnumber']) and !empty($_POST['starttime']))
        {
            $time = $_POST['starttime'];
            $nbQuestions = $_POST['qnumber'];
            $answers = json_decode($_POST['answers']);
            $starttime = $_POST['starttime'];


            // Si une réponse a été cochée
            if(isset($_POST['quizz']))
            {
                // On rajoute la réponse dans la chaine de réponse
                if (is_array($_POST['quizz']))
                {
                    $subarray = array();
                    foreach ($_POST['quizz'] as $key => $answer) {
                        $subarray[$key] = intval($answer);
                    }
                    $answers[sizeof($answers)] = $subarray;
                } else if(is_numeric($_POST['quizz']))
                    $answers[sizeof($answers)] = intval($_POST['quizz']);
                else
                    $answers[sizeof($answers)] = $_POST['quizz'];

            } else
                $_SESSION['error'] = "Pas de réponse selectionnée";

            // Si la taille des réponses et équivalent aux nombres de questions => Exercice terminée
            $cpt = sizeof($answers);
            if($cpt == $nbQuestions){
                $end = true;
            }
            else // Sinon, on passe a la prochaine question
                $nextQuestion = $cpt+1;

        } else {
            $_SESSION['error'] = "Erreur données en POST";
        }
    } else {
        // Si c'est la première question. Initialisation du système
        $nbQuestions = newSQLQuery( "SELECT count(*) FROM questions WHERE id_exercice = ?", "select", "fetch", "FETCH_NUM", $exercice_id)[0];
        $nextQuestion = 1;
        $answers = array();
        $time = time();
    }

    $content = "";
    // Si l'exercice n'est pas terminé
    if(!$end) {
        $question = newSQLQuery( "SELECT id_question, question, id_type FROM questions JOIN type_question USING (id_type) WHERE id_exercice = ? ORDER BY id_question ASC LIMIT " . ($nextQuestion - 1) . ", 1 ", "select", "fetch", "FETCH_ASSOC", $exercice_id);
        $id_question = $question['id_question'];
        $liste_choix = newSQLQuery( "SELECT id_choix, choix FROM choix WHERE id_question = ?", "select","fetchAll", "FETCH_NUM", $id_question);


        // On récup l'énoncé
        $exercice = newSQLQuery( "SELECT enonce FROM exercice WHERE id_exercice = ? LIMIT 1", "select", "fetch", "FETCH_ASSOC", $exercice_id);

        $content = "<h1>" . stripslashes ($exercice['enonce']) . "</h1>";
        $content .= "<p style='margin-bottom:30px;'>$nextQuestion. " . stripslashes ($question['question']) . "</p>";

        /**
         * Génération du formulaire pour la question
         */
        $content .= "<form role='form' name='quizform' action='" . WEBROOT . "exercices/" . $exercice_id . "' method='post'>";
        $content .= "<input name='starttime' value='$time' type='hidden'>";
        $content .= "<input name='qnumber' value='$nbQuestions' type='hidden'>";
        $content .= "<input name='answers' value='" . json_encode($answers) . "' type='hidden'>";
        switch ($question['id_type']){
            // Choix unique ou mutliple
            case 1:
            case 2:
                if($liste_choix) {
                    foreach ($liste_choix as $key => $choix) {
                        if($question['id_type'] == 1)
                            $content .= "<div class='checkbox'><label><input name='quizz[]' value='" . $key . "' type='checkbox'>" . stripslashes (htmlspecialchars($choix[1])) . "</label></div>";
                        else
                            $content .= "<div class='radio'><label><input name='quizz' value='".$key."' type='radio'>" . stripslashes (htmlspecialchars($choix[1])) . "</label></div>";
                    }
                } else {
                    $_SESSION['error'] = "Il n'y a pas de choix de réponse pour cette question. Veuillez contacter un administrateur.";
                    session_write_close();
                    header('location: ' . WEBROOT . 'accueil');
                }
                break;
            // Normal
            case 3:
                $content .= "<div class='text'><label><input name='quizz' type='text'></label></div>";
                break;
        }
        $content .= "<br><input name='next' value=' Suivant ' type='submit'>";
        $content .= "</form>";
        $content .= "<div>Total $nbQuestions questions</div>";
    } else {
        // Affichage de fin
        $nbBonnesReponses = nbBonnesReponses($exercice_id, $answers);
        $percent = ($nbBonnesReponses * 100 / $nbQuestions);

        // Sauvegarde du score
        $ancien_score = saveScore($exercice_id, $nbBonnesReponses);


        // Création du contenue de la vue
        $content .= "<center><h2>Resultat:</h2>$nbBonnesReponses sur $nbQuestions<p><b>" . $percent . "%</b></p>";
        $content .= "<p>" . getSentenceResult($percent) . "<br>";

        // Si un score a été retourné
        if ($ancien_score)
            if ($ancien_score > $nbBonnesReponses)
                $content .= "Votre score précédent était de " . $ancien_score . ". C'était mieux !";
            else if ($ancien_score > $nbBonnesReponses)
                $content .= "Votre score précédent était de " . $ancien_score . ". C'est mieux !";
            else
                $content .= "Votre score précédent était le même.";

        /**
         * Récupère les secondes et minutes du timestamp
         */
        $now = time();
        $tmpsPasse = $now-$time;
        $minutes = 0;
        $secondes = 0;
        while($tmpsPasse >= 60){
            $tmpsPasse = $tmpsPasse - 60;
            $minutes ++;
        }
        $secondes = $tmpsPasse;

        /**
         *  Génération de la vue pour l'affichage du nombres de bonnes réponses
         */
        $content .= "</p><p><b>Temps passé</b><br>".$minutes." minutes ".$secondes." secondes</p></center>";
        $content .= "<form role='form' target='_blank' action='" . WEBROOT . "resultat' method='post'>";
        $content .= "<input name='points' value='$nbBonnesReponses' type='hidden'>";
        $content .= "<input name='id' value='$exercice_id' type='hidden'>";
        $content .= "<input name='timespent' value='".$minutes." minutes ".$secondes." secondes' type='hidden'>";
        $content .= "<input name='answers' value='" . json_encode($answers) . "' type='hidden'>";
        $content .= "<table width='100%'><tbody><tr>";
        $content .= "<td><input value='Vérifier les réponses' class='btn btn-primary' name='checkAnswers' type='submit'></td>";
        $content .= "<td align='right'><input value='Réessayer' class='btn btn-primary' onclick='window.location.href = window.location.href;' type='button'></td>";
        $content .= "</tr></tbody></table>";
        $content .= "</form><br><hr><br>";

        /**
         *  Commentaires
         */
        if (isset($_SESSION['Auth']['isStudent'])) {
            $content .= "<form role='form' action='' method='post'>";
            $content .= "<div class='form-group'>";
            $content .= "<label for='comment'>Ajouter un commentaire :</label>";
            $content .= "<textarea class='form-control' rows='5' name='comment'></textarea>";
            $content .= "</div><input name='idExercice' value='$exercice_id' hidden><input type='submit' name='ajouterCommentaire' class='btn btn-primary' value='Ajouter'> ";
            $content .= "</form><br><br>";
        } else {
            $content .= "<div class='alert alert-danger'><strong>Attention!</strong> Vous n'êtes pas etudiant, vous ne pouvez pas ajouter de commentaire.</div>";
        }

        $commentaires = newSQLQuery( "SELECT id_etudiant, commentaire, timestamp FROM commentaires WHERE id_exercice = ? ORDER BY timestamp DESC ", "select", "fetchAll", "FETCH_ASSOC", $exercice_id);
        foreach ($commentaires as $commentaire) {
            $comment = $commentaire['commentaire'];
            $username = $commentaire['id_etudiant'];
            $timestamp = $commentaire['timestamp'];

            $content .= "<div class='panel panel-default'>";
                $content .= "<div class='panel-heading'><strong>$username</strong> <span class='text-muted'>".timeElapsed($timestamp)."</span></div>";
                $content .= "<div class='panel-body'>$comment</div>";
            $content .= "</div>";
        }
    }

echo $content;