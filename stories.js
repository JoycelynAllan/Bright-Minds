const stories = [
  {
    title: "The Brave Little Elephant",
    text: "Once upon a time, in the heart of the jungle, there was a little elephant named Ella who dreamed of flying. One day, she met a kind bird who taught her that courage can make you soar higher than wings ever could!"
  },
  {
    title: "The Rainbow Painter",
    text: "A little boy named Sam loved colors so much that one day, he painted the sky after a storm—and the first rainbow appeared! Since then, rainbows remind everyone to smile after hard times."
  },
  {
    title: "Luna and the Talking Moon",
    text: "Luna stayed up late one night and whispered to the moon. To her surprise, the moon whispered back! They talked about stars, dreams, and the magic of believing in yourself."
  },
  {
    title: "The Mouse Who Loved Music",
    text: "Max the mouse found an old piano in the attic. Every night, he played soft melodies that made the whole house fall asleep with happy dreams."
  }
];

const titleEl = document.getElementById("story-title");
const textEl = document.getElementById("story-text");
const newStoryBtn = document.getElementById("new-story-btn");

newStoryBtn.addEventListener("click", () => {
  const randomIndex = Math.floor(Math.random() * stories.length);
  const story = stories[randomIndex];
  titleEl.textContent = story.title;
  textEl.textContent = story.text;
});
