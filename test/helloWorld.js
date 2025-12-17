const HelloWorld = artifacts.require("HelloWorld");

contract("HelloWorld", () => {
    it("Hello World Testing", async () => {
        // 1. Récupérer l'instance du contrat déployé
        const helloWorld = await HelloWorld.deployed();

        // 2. Modifier la variable (Set Name)
        await helloWorld.setName("User Name");

        // 3. Lire la variable (Get Name)
        const result = await helloWorld.yourName();

        // 4. Vérifier que le résultat est bien celui attendu
        assert(result === "User Name", "Le nom devrait être 'User Name'");
    });
});