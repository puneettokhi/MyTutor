//
//  PayPalViewController.swift
//  MY TUTOR
//
//  Created by PUNEET TOKHI on 12/11/16.
//  Copyright © 2016 Appmart. All rights reserved.
//

import UIKit


class PayPalViewController: UIViewController, PayPalPaymentDelegate{
    
    
    var payPalConfig = PayPalConfiguration() // default

    
       var environment:String = PayPalEnvironmentNoNetwork {
    willSet(newEnvironment) {
    if (newEnvironment != environment) {
    PayPalMobile.preconnect(withEnvironment: newEnvironment)
        }
            }
    
    }
    
    
    var acceptCreditCards: Bool = true{
        didSet {
            
           payPalConfig.acceptCreditCards = acceptCreditCards
            
        }
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        payPalConfig.acceptCreditCards = acceptCreditCards
        payPalConfig.merchantName = "My Tutor!"
        payPalConfig.merchantPrivacyPolicyURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/privacy-full")
        payPalConfig.merchantUserAgreementURL = URL(string: "https://www.paypal.com/webapps/mpp/ua/useragreement-full")
        
        
           payPalConfig.languageOrLocale = Locale.preferredLanguages[0] // the default language of your phone will appear
        
        payPalConfig.payPalShippingAddressOption = .payPal;
        

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        PayPalMobile.preconnect(withEnvironment: environment)
    }
    
    
    
    @IBAction func payAction(_ sender: Any) {
        
        let item1 = PayPalItem(name: "Tutor Fee", withQuantity: 2, withPrice: NSDecimalNumber(string: "80"), withCurrency: "USD", withSku: "My Tutor")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPrice(forItems: items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "2.50")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.adding(shipping).adding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Pay to your Tutor", intent: .sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            present(paymentViewController!, animated: true, completion: nil)
        }
        else {
            // This particular payment will always be processable. If, for
            // example, the amount was negative or the shortDescription was
            // empty, this payment wouldn't be processable, and you'd want
            // to handle that here.
            print("Payment not processalbe: \(payment)")
        }
    
    
    }
    
    
    func payPalPaymentDidCancel(_ paymentViewController: PayPalPaymentViewController) {
        print("PayPal Payment Cancelled")
        
        paymentViewController.dismiss(animated: true, completion: nil)
    }
    
    func payPalPaymentViewController(_ paymentViewController: PayPalPaymentViewController, didComplete completedPayment: PayPalPayment) {
        print("PayPal Payment Success !")
        paymentViewController.dismiss(animated: true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
            
            
        })
    }


}
