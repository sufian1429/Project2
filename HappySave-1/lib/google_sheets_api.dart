import 'package:gsheets/gsheets.dart';

class GoogleSheetsApi {
  // create credentials
  static const _credentials = r'''
  
{
  "type": "service_account",
  "project_id": "gsheets-340622",
  "private_key_id": "1ff724e58b09065bcc91ac9dbf6529a1385755d2",
  "private_key": "-----BEGIN PRIVATE KEY-----\nMIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQDEYjVJrg/AU0Xc\nbfR0CfhW9ulc0Y2qz+u4qs0gGLIQukNnV08FkyvruZLRjW4ZD8RaT+RsPN8jFYI1\n/h8LN9uRbZlD54ZNqtFZr9rg48orv7iW73C4CbfR57ZoAMbXgF6ALH5FCHIllo/I\nxWDwUwBtLiVvhgn+bCFb6Is5g6weRtyr58xlZjCdeBM11yAbd709OyeQ1f83VSst\nG56HAqog2CO8RzV86YvoGLt/9npKUvK5xK0D5nCW/YH/BJmle5Vv/4pjv0KPqXsD\nu0X6ezq5TNFNVa1KlYQX5BUpWpCd4sxu8Pyx0WfS9FJQzA+AiTlyoIM2Fc/qcT0v\n1dpIdOh7AgMBAAECggEAWtB5iP2LviokE9frJCAaLgkXiHtFcnidLrQZkJ6q9Y5V\nLjxTSCYzONqDuREYmVFPwV3RqXYKz/wZz2MZMwRdLqbKqfqugkscbcejRb1BGDMc\nJvxKGWkxDsoC8ZxuV2i/CrHIoJ7TvmseSb9w4SHZACRHXofTJksVsB1dCLdJyGO3\n7qkenSBj+7Au26npFygUkfDrygVUDtlHxADxbIxX+aMXU8cLf1qjrrhCwExnGzqy\nPJVlMqg9WgszUBYXakGtrGptYB3va09y3NOFyRW5huBZOvNG/FUnR36EIcCZxhPY\nsiNVH4sNjuul4IVv5bYsMrPd1HgdcD7WMc7QR+s6AQKBgQDsP5v2RMLCrct7JaT2\nxOjpH6P6FkbeEoUnq4e68q6cBNCEIoL4EZVR0EygP0YJ/UKhOtUDsERCelwfg3cP\nGJ3RXJZhPYi2TdvJPlyTy4nLMfxRx9B2z/B9MWwAYHNLKj7bb7nlRLYQHpxg9S2D\nFVgzZsZrQ9Ky7TZ1obuHywHaAQKBgQDUzWCm3lVYGZhtIwFV4grWabpadsLbwiTl\nn1SiTQH981KuCr4TUwaXBjCfRmxnIXL79GDdvos9/FMEwH6BZ0WfbopuX1EN6ruL\nZM8Bv9FtzOB22Aw9OjJjGS/Q1ab45iOPovXv9V9zPfTlBQJeJy8QjjKSW59Z9PHp\nZIbF3s0qewKBgQDUssA8DNQ8ajSU/uNyuP3pRW9grcXIEmyHtstQ6UWDemIxVNEN\nfucs7ZjPfagVPktK1akK1RvfrkJarQX4NXWBFRbfHYOEfryuhtLazZmVs78z8e4h\nyjz+ugw+mpeyyKom7oQzgpVYFfc85ADBz+nE/XcPA9Ui+qbZaW9pZsCYAQKBgEZK\n0PJN3sMLMV5bgcVstUe+BOB8+kC9EJMI3lv+M/o+tcDnq4GWm0antMfn60bltaWk\nQ5r7peMDxih7rU3xXv4a9X8f3RZLw0d4NSjOw88RLdQT6XcQEjTJzRGegVkWLAj2\nO2bYFn9qp8o+rVmMd+9wCSRvP2PnlUETA7G4tuyhAoGAVqItvU13vrbK0KAiHh13\nFoP/G29jPjpxC+hNB3y/skG8cenXg3kP1+2fD5g9kmdjNW+eUTkR1E237prOQw+a\nsskn6XcFW8XEa2hJIvUK6P38Of+8X0viQnhufRH/Fy0Gj73yRZYW/usaEjn/pAY+\n3VrPTplmw26YMGHe3Lp94PI=\n-----END PRIVATE KEY-----\n",
  "client_email": "gsheet@gsheets-340622.iam.gserviceaccount.com",
  "client_id": "106628087441501257562",
  "auth_uri": "https://accounts.google.com/o/oauth2/auth",
  "token_uri": "https://oauth2.googleapis.com/token",
  "auth_provider_x509_cert_url": "https://www.googleapis.com/oauth2/v1/certs",
  "client_x509_cert_url": "https://www.googleapis.com/robot/v1/metadata/x509/gsheet%40gsheets-340622.iam.gserviceaccount.com"
}''';

  // set up & connect to the spreadsheet
  static final _spreadsheetId = '1BSrxKH_6NIMa2zJa1OSG8LgeBc2YoKmBt1Mla508Mrk';
  static final _gsheets = GSheets(_credentials);
  static Worksheet? _worksheet;

  // some variables to keep track of..
  static int numberOfTransactions = 0;
  static List<List<dynamic>> currentTransactions = [];
  static bool loading = true;

  // initialise the spreadsheet!
  Future init() async {
    final ss = await _gsheets.spreadsheet(_spreadsheetId);
    _worksheet = ss.worksheetByTitle('Worksheet1');
    countRows();
  }

  // count the number of notes
  static Future countRows() async {
    while ((await _worksheet!.values
            .value(column: 1, row: numberOfTransactions + 1)) !=
        '') {
      numberOfTransactions++;
    }
    // now we know how many notes to load, now let's load them!
    loadTransactions();
  }

  // load existing notes from the spreadsheet
  static Future loadTransactions() async {
    if (_worksheet == null) return;

    for (int i = 1; i < numberOfTransactions; i++) {
      final String transactionName =
          await _worksheet!.values.value(column: 1, row: i + 1);
      final String transactionAmount =
          await _worksheet!.values.value(column: 2, row: i + 1);
      final String transactionType =
          await _worksheet!.values.value(column: 3, row: i + 1);

      if (currentTransactions.length < numberOfTransactions) {
        currentTransactions.add([
          transactionName,
          transactionAmount,
          transactionType,
        ]);
      }
    }
    print(currentTransactions);
    // this will stop the circular loading indicator
    loading = false;
  }

  // insert a new transaction
  static Future insert(String name, String amount, bool _isIncome) async {
    if (_worksheet == null) return;
    numberOfTransactions++;
    currentTransactions.add([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
    await _worksheet!.values.appendRow([
      name,
      amount,
      _isIncome == true ? 'income' : 'expense',
    ]);
  }

  // CALCULATE THE TOTAL INCOME!
  static double calculateIncome() {
    double totalIncome = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'income') {
        totalIncome += double.parse(currentTransactions[i][1]);
      }
    }
    return totalIncome;
  }

  // CALCULATE THE TOTAL EXPENSE!
  static double calculateExpense() {
    double totalExpense = 0;
    for (int i = 0; i < currentTransactions.length; i++) {
      if (currentTransactions[i][2] == 'expense') {
        totalExpense += double.parse(currentTransactions[i][1]);
      }
    }
    return totalExpense;
  }
}
