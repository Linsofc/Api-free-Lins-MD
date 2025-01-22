const fetch = require("node-fetch")

async function LinsMD(path, data) => {
   const Lins = await fetch(`https://raw.githubusercontent.com/Linsofc/Api-free-Lins-MD/main/db/${path}/${data}.json`)
   const responseLins = await Lins.json()
   return responseLins
}

let data = LinsMD("games", "asahotak")
console.log(data)
