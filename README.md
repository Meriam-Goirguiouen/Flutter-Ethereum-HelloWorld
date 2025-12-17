# Flutter-Ethereum-HelloWorld# Flutter & Ethereum DApp - Hello World

Ce projet est une Application Décentralisée (DApp) simple réalisée dans le cadre d'un TP.
Elle permet de stocker et lire un nom sur une blockchain locale.

## Technologies utilisées
- **Flutter** (Front-end Web & Mobile)
- **Solidity** (Smart Contract)
- **Truffle** (Framework de développement Ethereum)
- **Ganache** (Blockchain locale personnelle)
- **Web3dart** (Librarie Dart pour interagir avec la blockchain)

## Fonctionnalités
- Déploiement d'un Smart Contract `HelloWorld`.
- Lecture de l'état du contrat via RPC.
- Envoi de transactions signées pour modifier l'état.

## Sécurité des données (Avertissement):
- On note bien que la clé privée utilisée dans ce projet provient de **Ganache** (blockchain locale de test).
Bien qu'elle soit visible ici à des fins de démonstration, il est rappelé qu'une véritable clé privée (Mainnet) ne doit **jamais** être partagée ou commitée sur un dépôt public.
