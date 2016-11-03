## Inspiration

Airline tickets, concert tickets, even drivers licenses use encoded but not encrypted 2d bar codes such. This means anyone can make their own fake tickets and identities, and without access to a central database, it is impossible to distinguish the real ones from the fake ones. Internet access and a robust database system are needed to be sure any given identity or ticket was issued by a reputable source. 

That's pretty stupid, because public key cryptography solved this problem decades ago and databases are cumbersome to set up and maintain. With algorithms like RSA, anyone with a public key can check that tickets and identities were issued by the correct authority, and forgers are unable to modify tickets once they are issued. 

## What it does

Cryptr uses the RSA algorithm to hash and sign plaintext messages. These messages contain information such as the name of the intended recipient, the event the ticket / ID is for, the date and an ID number. The app can also scan a qr code and verify identities as valid or invalid.

## Video Walkthrough

# http://i.imgur.com/zrj0DxZ.gifv

## How we built it

We built this app using Swift on iOS. We relied on library wrappers and other example projects that implemented low-level cryptographic libraries such as CommonCrypto and other functionality such as QR code scanning. 

## Challenges we ran into

Many of the cryptography libraries available on iOS, especially the CommonCrypto library provided by apple, are very poorly documented and not easily used in a Swift app. 

## Accomplishments that I'm proud of

We're proud that we were able to implement RSA securely. We're also quite proud of the design of the app.

## What I learned

We were able to find a way to make scanning and creating QR codes quick and easy. In addition to that, we were able to develop a better understanding of the CommonCrypto library.

## What's next for Cryptr

As we develop the app more, the user will be taken to a screen that displays the coded information after the signature is verified.

## LICENSE

The MIT License (MIT)
Copyright (c) 2015 Ignacio Nieto Carvajal (http://digitalleaves.com)

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
