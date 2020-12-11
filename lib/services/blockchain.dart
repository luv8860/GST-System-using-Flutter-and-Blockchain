import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';
import 'dart:async';

class Blockchain extends StatelessWidget {
  Client httpClient;
  Web3Client ethClient;
  var myData;
  dynamic accno = "waiting";
  dynamic gstno = "waiting";
  dynamic name = "waiting";
  dynamic bal = "waiting";
  dynamic taxpaid = "waiting";
  dynamic billgen = "waiting";

  final myAddress = '0xBE198fb90F6E9267746088B4c0d44C26691C4E86';

  Future<List> getGovt() async {
    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    List<dynamic> result = await query("getGovt", []);
    return result;
  }

  Future<String> login(String gst, String pwd) async {

    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    List<dynamic> result = await query("businessLogin", [gst, pwd]);
    var status = result[0];
    return (status.toString());
  }
  Future<String> govtLogin(String uid, String pwd) async {

    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    List<dynamic> result = await query("governmentLogin", [uid, pwd]);
    var status = result[0];
    return (status.toString());
  }

  Future<List> getBusiness(String gstno) async {
    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    List<dynamic> result = await query("getBusinessDetails", [gstno]);
    // setState(() {
    //   accno = result[0];
    //   bal = result[6];
    //   billgen = result[7];
    //   taxpaid = result[8];
    // });
    return result;
  }

  Future<String> genBill(int billno, String adhano, String cusphono, int amt,
      int tgst, String gst) async {
    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    String result = await submit("addbilldetails", [
      BigInt.from(billno),
      gst,
      adhano,
      cusphono,
      BigInt.from(amt),
      BigInt.from(tgst),
    ]);
    print(result);
    return result.toString();
  }

  Future<String> addBusiness(String name, String pwd, String gst, String adhano,
      String bkno, String phno, int balno) async {
    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    String result = await submit("addBusiness", [
      bkno,
      gst,
      name,
      adhano,
      phno,
      pwd,
      BigInt.from(balno),
    ]);
    print(result);
    return result.toString();
  }

  Future<List> getBill(BigInt billNo, String gstNo) async {
    httpClient = Client();
    ethClient = Web3Client(
        'https://rpc-mumbai.maticvigil.com/v1/ea78efdb0dda43d3e2be1f3ad04f0e026d52bcb8',
        httpClient);
    List<dynamic> result = await query("searchBill", [billNo, gstNo]);
    return result;
  }

  // void initState() {
  //   super.initState();

  //   getGovt();
  // }

  Future<DeployedContract> localContract() async {
    String abi = await rootBundle.loadString("assets/abi.json");
    String contractAddress = "0xed5D0C9b22D1c8A2E1af36E6c53E789Ec6f80f52";

    final contract = DeployedContract(ContractAbi.fromJson(abi, "GSTCHAIN"),
        EthereumAddress.fromHex(contractAddress));

    return contract;
  }

  Future<List<dynamic>> query(String functionName, List<dynamic> args) async {
    final contract = await localContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.call(
        contract: contract, function: ethFunction, params: args);

    return result;
  }

  Future<String> submit(String functionName, List<dynamic> args) async {
    EthPrivateKey creditional = EthPrivateKey.fromHex(
        "47dcde407ad4b99f55922e431f223c6656acff80b8fca21118240126904508fb");
    final contract = await localContract();
    final ethFunction = contract.function(functionName);
    final result = await ethClient.sendTransaction(
        creditional,
        Transaction.callContract(
            contract: contract,
            function: ethFunction,
            parameters: args,
            maxGas: 3000000),
        fetchChainIdFromNetworkId: true);
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            child: FlatButton(
      onPressed: () {},
      child: Text("dabaiye isko"),
    )));
  }
}
