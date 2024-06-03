import Debug "mo:base/Debug";
import Time "mo:base/Time";
import Float "mo:base/Float";

actor DigitalBank {
  // Stable variable to hold the current balance
  stable var balance: Float = 300.0;
  Debug.print(debug_show(balance));

  // Stable variable to hold the start time
  stable var initialTime: Time.Time = Time.now();
  Debug.print(debug_show(initialTime));

  // Function to add funds to the balance
  public func addFunds(amount: Float) {
    balance += amount;
    Debug.print(debug_show(balance));
  };

  // Function to withdraw funds from the balance
  public func takeFunds(amount: Float) {
    let newBalance: Float = balance - amount;
    if (newBalance >= 0.0) {
      balance -= amount;
      Debug.print(debug_show(balance));
    } else {
      Debug.print("Insufficient funds, balance would be negative.")
    }
  };

  // Query function to check the current balance
  public query func checkBalance(): async Float {
    return balance;
  };

  // Function to apply compound interest to the balance
  public func applyInterest() {
    let currentTime = Time.now();
    let elapsedTimeNS = currentTime - initialTime;
    let elapsedTimeS = Float.fromInt(elapsedTimeNS / 1_000_000_000);
    balance := balance * (1.01 ** elapsedTimeS);
    initialTime := currentTime;
  };
}
