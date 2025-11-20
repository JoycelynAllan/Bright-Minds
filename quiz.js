const questions = [
  {
    question: "What color is the sky on a sunny day?",
    options: ["Blue", "Green", "Red", "Yellow"],
    answer: "Blue"
  },
  {
    question: "How many legs does a spider have?",
    options: ["6", "8", "10", "4"],
    answer: "8"
  },
  {
    question: "Which animal is known as the King of the Jungle?",
    options: ["Elephant", "Tiger", "Lion", "Giraffe"],
    answer: "Lion"
  },
  {
    question: "What do bees make?",
    options: ["Honey", "Milk", "Butter", "Cheese"],
    answer: "Honey"
  }
];

let currentQuestionIndex = 0;
let score = 0;

const questionEl = document.getElementById("question");
const optionsEl = document.getElementById("options");
const nextBtn = document.getElementById("next-btn");
const scoreContainer = document.getElementById("score-container");
const scoreEl = document.getElementById("score");
const restartBtn = document.getElementById("restart-btn");
const questionContainer = document.getElementById("question-container");

function showQuestion() {
  const currentQuestion = questions[currentQuestionIndex];
  questionEl.textContent = currentQuestion.question;
  optionsEl.innerHTML = "";
  nextBtn.classList.add("hidden");

  currentQuestion.options.forEach(option => {
    const button = document.createElement("button");
    button.textContent = option;
    button.classList.add("option-btn");
    button.addEventListener("click", () => selectAnswer(button, currentQuestion.answer));
    optionsEl.appendChild(button);
  });
}

function selectAnswer(button, correctAnswer) {
  const allButtons = document.querySelectorAll(".option-btn");
  allButtons.forEach(btn => btn.disabled = true);

  if (button.textContent === correctAnswer) {
    button.classList.add("correct");
    score++;
  } else {
    button.classList.add("wrong");
    allButtons.forEach(btn => {
      if (btn.textContent === correctAnswer) {
        btn.classList.add("correct");
      }
    });
  }

  nextBtn.classList.remove("hidden");
}

nextBtn.addEventListener("click", () => {
  currentQuestionIndex++;
  if (currentQuestionIndex < questions.length) {
    showQuestion();
  } else {
    showScore();
  }
});

function showScore() {
  questionContainer.classList.add("hidden");
  nextBtn.classList.add("hidden");
  scoreContainer.classList.remove("hidden");
  scoreEl.textContent = `You scored ${score} out of ${questions.length}! 🎊`;
}

restartBtn.addEventListener("click", () => {
  currentQuestionIndex = 0;
  score = 0;
  questionContainer.classList.remove("hidden");
  scoreContainer.classList.add("hidden");
  showQuestion();
});

// Initialize first question
showQuestion();