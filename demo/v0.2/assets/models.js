class Team
{
    constructor(_id, _name) {
        this.id = _id;
        this.name = _name;
        this.score = 0;
        this.isActive = false;
    }
}

class Question 
{
    constructor() {
        this.question_id = 0;
        this.category_id = 0;
        this.question_level = 100;
        this.question_content = "Question";
        this.question_answer = "";
        this.isAvailable = true;
    }

    hydrate(q){
        this.question_id = parseInt(q.question_id);
        this.category_id = parseInt(q.category_id);
        this.question_level = (parseInt(q.question_level)*100);
        this.question_content = q.question_content;
        this.question_answer = q.question_answer;
        this.isAvailable = true;
    }
}

class Category 
{
    constructor(){
        this.category_id = 0;
        this.quiz_id = 0;
        this.category_name = "Category";
        this.category_description = "";
    }

    hydrate(c){
        this.category_id = parseInt(c.category_id);
        this.quiz_id = parseInt(c.quizz_id);
        this.category_name = c.category_name;
        this.category_description = c.category_description;
    }
}

class Quiz
{
    constructor() {
        this.quizz_id = 0;
        this.quizz_theme = "Tedi FlipQuizz";
        this.textcolor = "#000000";
        this.backcolor = "#FFFFFF";
        this.backimage = 0;
    }

    init(id) {

    }

    hydrate(q)  {
        this.quizz_id = parseInt(q.quizz_id);
        this.quizz_theme = q.quizz_theme;
        this.textcolor = q.quizz_textcolor;
        this.backcolor = q.quizz_backcolor;
        this.backimage = q.quizz_id;

        this.teams = [];

        /*for(var i=0; i<2; i++) {
            this.teams.push(new Team(i+1, "Team #" +(i+1)));
        }

        this.activeTeamIdx = Math.floor(Math.random() * this.teams.length);
        this.activeTeam.isActive = true;*/

        this.message = "Welcome !";
    }

    get activeTeam() {
        return this.teams[this.activeTeamIdx];
    }

    getQuestion(_id)
    {
        return this.questions.find(item => item.id === parseInt(_id));
    }

    static setMessage(_quiz, _message) {
        _quiz.message =  _message;
    }

    startRound() {
        var msg = this.activeTeam.name + "'s turn !";
        var q = this;
        setTimeout(function() { Quiz.setMessage(q, msg)}, 5000);
    }

    endRound(_won) {

        this.activeTeam.score += parseInt(_won);
        this.activeTeam.isActive = false;

        this.message = this.activeTeam.name + ' wins ' + _won + ' points';

        if(this.activeTeamIdx >= (this.teams.length - 1)) {
            this.activeTeamIdx = 0;
        }
        else {
            this.activeTeamIdx++;
        }

        this.activeTeam.isActive = true;

        this.startRound();
    }
}

class TestQuiz extends Quiz
{
    constructor() {
        super();

        
    }
}