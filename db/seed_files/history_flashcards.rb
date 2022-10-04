module HistoryFlashcards
  def self.seed
    game_history = Theme.new(name: "Période historique")
    game_history.image_src = '<i class="fas fa-atlas"> </i>'
    game_history.adventure_only = true
    game_history.save!

    game_history_level_1 = ThemeLevel.new(
      name: "niveau 1",
      level: 1,
      objective: " no objective!",
      theme: game_history)
    game_history_level_1.save!

    prehistory = Subtheme.new(name: "Prehistoire", theme_level: game_history_level_1)
    prehistory.save!

    timeline = Category.new(subtheme: prehistory, name: "timeline", objective: "Pas d'objectifs", ordering: 1, img_src:"none")
    timeline.save!

    quizz = Quizz.new(category: timeline, name: "quizz", ordering: 1, crown_or_sphere:"crown")
    quizz.save!


    question_answers_data = [{
      question: "A quel âge correspond le Paléolithique inférieur ?",
      answer: "L'âge de la pierre taillée",
      level: 1
    },

    {
      question: "Par quelle 'découverte' est caractérisée le Paléolitique inférieur ?",
      answer: "La maitrise du feu (~400 000 av. JC)",
      level: 1
    },

    {
      question: "Quel est la première période de la Préhistoire",
      answer: "Le paléolithique inférieur",
      level: 1
    },


    {
      question: "Date d'apaprition de l'Homo Sapiens, appelé homme moderne (concordant avec la fin du paléolitique ancien) ?",
      answer: "~300000 av. JC",
      level: 1
    },

    {
      question: "2 comportements évolués de Paléolithique moyen ?",
      answer: "Chasse de grands herbivores <br> Aménagement des habitats",
      level: 2
    },

    {
      question: "2 représentants du genre Homo au Paléolitique moyen",
      answer: "Afrique du Nord : Homo sapiens<br> Europe: Homme de Néendertal",
      level: 2
    },


    {
      question: "Quand prend approximativement fin le Paléolitique moyen ?",
      answer: "-45000 av J-C",
      level: 2
    },

    {
      question: "Date d'apparation des premières formes d'art",
      answer: "-50000 av J-C",
      level: 2
    },

    {
      question: "Qu'apporte l'Homo-sapiens à l'Europe lors du Paléolithique supérieur ?",
      answer: "Son industrie lithique, dite de 'mode 4', à savoir des lames et lamelles servant de base à la réalisation d'un outillage diversifié. Pour plus d'informations : <a href='https://fr.wikipedia.org/wiki/Pierre_taill%C3%A9e' target='_blank' style='display:inline;'><strong>cf. wikipédia</strong></a>",
      level: 3
    },

    {
      question: "Par quoi commence le Paléolithique supérieur (~-40000)?",
      answer: "L'arrivée d'homo-sapiens en Europe </br> (cohabitation pendant plusieurs milliers d'année avec l'Homme de Néandertal qui disparait en -30000)",
      level: 3
    },

    {
      question: "Par quoi s'achève le Paléolithique supérieur ?",
      answer: "La dernière ère glacière",
      level: 3
    },

    {
      question: "Quand prend approximativement fin le Paléolitique supérieur ?",
      answer: "-10000 av J-C",
      level: 3
    },

    {
      question: "Date des peintures des grottes de Lascaux?",
      answer: "-18000 av J-C",
      level: 3
    },

    {
      question: "Par quoi est marqué le Mésolithique?",
      answer: "Un réchauffement climatique </br> Disparitition de grands herbivores (Mammouths)",
      level: 4
    },

    {
      question: "Quelle arme est fortement dévoloppée au Mésolitique",
      answer: "L'arc (à noter qu'il n'y a pas de consensus sur la date d'apparition)",
      level: 4
    },

    {
      question: "Période de création des menhirs et Dolmen",
      answer: "-10000 av.JC",
      level: 5
    },

    {
      question: "Estimation de la population en France au Mésolitique",
      answer: "~75000",
      level: 5
    },


    {
      question: "Quand s'achève approximativement le Mésolithique en Europe ?",
      answer: "-6500 (en Europe)",
      level: 6
    },

    {
      question: "Par quoi est caractérisé la fin du Mésolithique",
      answer: "Passage d'une économie de chasse / ceuillette à une économie agro-pastorale (pastoralisme: pratique de l'élevage) avec la domestication de certains animaux",
      level: 6
    },


    {
      question: "A quel âge correspond le Néolithique ?",
      answer: "L'âge de la pierre polie",
      level: 7
    },

    {
      question: "3 principales innovations du Néolitique",
      answer: "Pierre polie, poterie, tissage",
      level: 7
    },

    {
      question: "Quels sont les 2 changements majeurs du Néolitique ?",
      answer: "Apparition de l'agriculture </br> Sédentarisation des peuples",
      level: 8
    },

    {
      question: "A quelle époque apparaissent les premiers villages ?",
      answer: "-10000 av. JC",
      level: 8
    },

    {
      question: "A quelle ère historique débute le commerce ??",
      answer: "Néolithique (sous forme de troc)",
      level: 9
    },


    {
      question: "A quelle ère préhistorique est associée la systématisation des rites funéraires ?",
      answer: "Néolithique",
      level: 9
    },


    {
      question: "Quand s'achève approximativement le Néolitique, et donc la Préhistoire ?",
      answer: "-3000 (en Asie mineure)",
      level: 9
    }]

    Level.all.each do |level|
      # p level.level
      # p question_answers_data
      question_answers_data_for_level = question_answers_data.select{ |question_answer_data|
        p question_answer_data[:level] == level.level
        question_answer_data[:level] == level.level
      }
      if (question_answers_data_for_level.size.zero?)
        [1..3].each do |i|
          question_template = {
            question: "Question en cours d'écriture ?",
            answer: "Réponse à venir",
            level: level.level
          }
          question_answers_data_for_level << question_template
        end
      end

      # p question_answers_data_for_level

      question_answers_data_for_level.each do | question_answer_data|
        question_answer = QuestionAnswer.new(question: question_answer_data[:question], answer: question_answer_data[:answer], level: Level.find(level.id))
        question_answer.save!
        quizz_question_answer = QuizzQuestionAnswer.new(question_answer: question_answer, quizz: quizz)
        quizz_question_answer.save!
      end
    end
  end
end
