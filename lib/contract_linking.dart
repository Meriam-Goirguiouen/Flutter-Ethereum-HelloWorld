import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

class ContractLinking extends ChangeNotifier {
  
  // 1. Configuration
  final String _rpcUrl = "http://127.0.0.1:7545";
  final String _privateKey = "0x91dae7b0947182c58fbd5489fddec94953024b2be4bf56f5fc1072cf07e6988e";

  // 2. Variables
  late Web3Client _client;
  bool isLoading = true;

  late String _abiCode;
  late EthereumAddress _contractAddress;
  late Credentials _credentials;
  late DeployedContract _contract;
  late ContractFunction _yourName;
  late ContractFunction _setName;

  String deployedName = "";
  
  // Variable pour stocker l'ID du réseau (5777 ou 1337)
  BigInt? _chainId;

  ContractLinking() {
    initialSetup();
  }

  initialSetup() async {
    // Connexion HTTP simple (Plus stable pour ce cas)
    _client = Web3Client(_rpcUrl, Client());

    await getAbi();
    await getCredentials();
    await getDeployedContract();
  }

  Future<void> getAbi() async {
    String abiStringFile = await rootBundle.loadString("src/artifacts/HelloWorld.json");
    var jsonAbi = jsonDecode(abiStringFile);

    _abiCode = jsonEncode(jsonAbi["abi"]);
    _contractAddress = EthereumAddress.fromHex(jsonAbi["networks"]["5777"]["address"]);

    // --- DETECTION AUTOMATIQUE DE L'ID ---
    _chainId = await _client.getChainId();
    print("ChainID détecté : $_chainId");
  }

  Future<void> getCredentials() async {
    _credentials = EthPrivateKey.fromHex(_privateKey);
  }

  Future<void> getDeployedContract() async {
    _contract = DeployedContract(
        ContractAbi.fromJson(_abiCode, "HelloWorld"), _contractAddress);

    _yourName = _contract.function("yourName");
    _setName = _contract.function("setName");

    await getName();
  }

  Future<void> getName() async {
    var currentName = await _client.call(
        contract: _contract, function: _yourName, params: []);

    deployedName = currentName[0];
    isLoading = false;
    notifyListeners();
  }

  Future<void> setName(String nameToSet) async {
    isLoading = true;
    notifyListeners();

    // On utilise l'ID détecté automatiquement (_chainId)
    await _client.sendTransaction(
      _credentials,
      Transaction.callContract(
          contract: _contract,
          function: _setName,
          parameters: [nameToSet]
      ),
      chainId: _chainId?.toInt(), 
    );

    await getName();
  }
}