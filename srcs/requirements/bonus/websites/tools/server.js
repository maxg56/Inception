const express = require('express');

const app = express();

// Servir les fichiers statiques depuis le dossier 'app'
app.use(express.static('app'));

// Lancer le serveur sur le port 3000
app.listen(3000, () => {
    console.log("Server running on port 3000");
}).on('error', (err) => {
    console.error('Error starting the server:', err);
});
