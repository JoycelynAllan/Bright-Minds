const games = [
  {
    title: "Memory Match Game",
    instructions: "Flip cards to find pairs that match! Test your memory and focus!"
  },
  {
    title: "Catch the Star",
    instructions: "Use your arrow keys to catch as many falling stars as you can before time runs out!"
  },
  {
    title: "Animal Sound Quiz",
    instructions: "Listen carefully to each sound and guess which animal it belongs to!"
  },
  {
    title: "Color Splash",
    instructions: "Click on the correct color when the word appears! Hurry, it’s fast!"
  }
];

const titleEl = document.getElementById("game-title");
const instructionsEl = document.getElementById("game-instructions");
const startBtn = document.getElementById("start-game-btn");

startBtn.addEventListener("click", () => {
  const randomGame = games[Math.floor(Math.random() * games.length)];
  titleEl.textContent = randomGame.title;
  instructionsEl.textContent = randomGame.instructions;
});
