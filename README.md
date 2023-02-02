# IppoPay iOS SDK Integration

## Step - 1 - Add Dependency

```
pod 'IppoPay', '~> 2.0.0'
pod update
```

## Step - 2 - Import SDK 
For Swift
```
import IppoPay
```
For Objective-C
```
#import "IppoPay/IppoPay-Swift.h"
```

## Step - 3 - Initialize SDK 

To initialize the SDK add the below line of code with the public key you retrieved from ippopay merchant panel. If you don't have a public key create new one.


For Swift
```
Ippopay.initSDK("Your Unique Public Key",withDelegate: Self)
```
For Objective-C
```
[Ippopay initSDKWithPublicKey:@"Your Unique Public Key" withDelegate:self];
```

## Step - 4 - Create Order Data Object with necessary inputs

You can create the order data or payment input with our OrderData Model class. Here you need to provide order id and customer details like name, email, mobile number.

For Swift
```
let orderData = OrderData()
orderData.customColor = "#12233"  // make payment page loading color as app color. 
orderData.orderId = ""  // unique order id. 
orderData.orderDescription = ""  // any description.

let customer = Customer()
customer.customerEmail = "email@gmail.com"
customer.customerName = "name"
customer.customerPhoneNumber = "1234567890"
orderData.customer = customer
```
For Objective-C
```
OrderData *orderdata = [[OrderData alloc] init];
orderData.customColor = @"#12233";  // make payment page loading color as app color. 
orderData.orderId = @"";  // unique order id. 
orderData.orderDescription = @"";  // any description.

Customer *customer = [[Customer alloc] init];
customer.customerEmail = @"email@gmail.com";
customer.customerName = @"name";
customer.customerPhoneNumber = @"1234567890";
orderData.customer = customer;
```

## Step - 5 - Make Transaction with Ippopay

Use the below line of code to make the payment with the order data you created in Step - 4
For Swift
```
Ippopay.makePayment(orderData: orderData)
```
For Objective-C
```
[Ippopay makePaymentWithOrderData:orderdata];
```
## Step - 6 - Implement Payment Delegate

Implement our payment delegate to receive the payment result for the payment we made in Step - 5. Use the below code to obtain the payment result.

For Swift
```
extension ViewController: IppopayDelegate{
    func onPaymentError(descriptionOfError: String) {
        // Failure Callback.
    }
    
    func onPaymentSuccess(paymentId: String) {
         // Success Callback
    }
}
```
For Objective-C
```
@interface Main () <IppopayDelegate> {
}

- (void)onPaymentErrorWithDescriptionOfError:(NSString * _Nonnull)descriptionOfError {
    // Failure Callback.
}

- (void)onPaymentSuccessWithPaymentId:(NSString * _Nonnull)paymentId {
    // Success Callback
}
```

## iOS 9 Update

iOS 9 has higher requirements for secure URLs. As many Indian banks do not comply with the requirements, you can implement the following as a workaround in Info.plist

```

<key>NSAppTransportSecurity</key>
<dict>
    <key>NSAllowsArbitraryLoads</key>
    <true/>
</dict>

 <key>LSApplicationQueriesSchemes</key>
        <array>
            <string>amazonToAlipay</string>
            <string>paytmmp</string>
            <string>whatsapp</string>
            <string>phonepe</string>
            <string>bhim</string>
            <string>gpay</string>
        </array>

```

## Ippopay Log

You can enable / disable the SDK logs by using the below line of code. By default it will be enabled.

For Swift
```
PayLog.setLogVisible(debug: true or false)
```
For Objective-C
```
[PayLog setLogVisibleWithDebug:true or false];
```


## Sample Payment Reference.

Please check [this link](https://github.com/ippopay/ippopay-ios-sdk/tree/main/DemoIppopay) for sample payment with above steps.

