import { relay } from "../../declarations/relay";

document.getElementById("clickMeBtn").addEventListener("click", async () => {
  const name = document.getElementById("name").value.toString();
  // Interact with relay actor, calling the greet method
  const greeting = await relay.greet(name);

  document.getElementById("greeting").innerText = greeting;
});
