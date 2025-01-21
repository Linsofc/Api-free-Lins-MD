const fetch = require("node-fetch")
async function games (type) {
  try {
    const response = await fetch(`https://raw.githubusercontent.com/Linsofc/Api-free-Lins-MD/main/db/games/${type}.json`);
    if (!response.ok) {
      throw new Error(`Failed to fetch game data: ${response.statusText}`);
    }
    const gameJson = await response.json();
    return { status: true, creator: "Lins-MD", data: gameJson }
  } catch (err) {
   return { status: false, creator: "Lins-MD", data: { msg: "Eror: ", err }}
  }
}
