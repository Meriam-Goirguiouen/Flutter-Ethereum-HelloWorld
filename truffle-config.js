module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",     // Localhost
      port: 7545,            // Port standard de Ganache (vérifie sur ton appli Ganache)
      network_id: "*",       // Accepter n'importe quel ID de réseau
    },
  },

  // Dossier où Truffle va mettre les fichiers JSON pour Flutter
  contracts_build_directory: "./src/artifacts/",

  // Configuration du compilateur
  compilers: {
    solc: {
      version: "0.5.16",     
      settings: {
        optimizer: {
          enabled: false,
          runs: 200
        },
        evmVersion: "byzantium"
      }
    }
  }
};