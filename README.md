# get-exchange-rates

A simple way to get up-to-date exchange rates for Bitcoin and major national currencies. Does *not* require an API key.

# Data format

The base is currently in Euro - this means that the rates will indicate how much `currency` is equivalent to 1 Euro.

Rates are automatically cached for 5 minutes (but this is configurable), and there's currently no historical rate search.

Currently supported currencies (and their sources):

* BTC - Bitcoin (Blockchain.info)
* USD - United States Dollar (ECB, via fixer.io)
* CAD - Canadian Dollar (ECB, via fixer.io)
* GBP - British Pound (ECB, via fixer.io)
* CNY - Chinese Yuan (ECB, via fixer.io)
* RUB - Russian Ruble (ECB, via fixer.io)
* JPY - Japanese Yen (ECB, via fixer.io)
* AUD - Australian Dollar (ECB, via fixer.io)
* NZD - New Zealand Dollar (ECB, via fixer.io)

* BGN - Bulgarian Lev (ECB, via fixer.io)
* BRL - Brazilian Real (ECB, via fixer.io)
* CHF - Swiss Franc (ECB, via fixer.io)
* CZK - Czech Koruna (ECB, via fixer.io)
* DKK - Danish Krone (ECB, via fixer.io)
* HKD - Hong Kong Dollar (ECB, via fixer.io)
* HRK - Croation Kuna (ECB, via fixer.io)
* HUF - Hungarian Forint (ECB, via fixer.io)
* IDR - Indonesian Rupiah (ECB, via fixer.io)
* ILS - Israeli Shekel (ECB, via fixer.io)
* INR - Indian Rupee (ECB, via fixer.io)
* KRW - South Korean Won (ECB, via fixer.io)
* MXN - Mexican Peso (ECB, via fixer.io)
* MYR - Malaysian Ringgit (ECB, via fixer.io)
* NOK - Norwegian Krone (ECB, via fixer.io)
* PHP - Philippine Peso (ECB, via fixer.io)
* PLN - Polish Zloty (ECB, via fixer.io)
* RON - Romanian New Leu (ECB, via fixer.io)
* SEK - Swedish Krona (ECB, via fixer.io)
* SGD - Singapore Dollar (ECB, via fixer.io)
* THB - Thai Baht (ECB, via fixer.io)
* TRY - Turkish Lira (ECB, via fixer.io)
* ZAR - South African Rand (ECB, via fixer.io)

Each currency can be accessed from the result by its 3-letter abbreviation.

Note that fixer.io currencies are subject to change; the module does not currently do any validation, so availability of rates may change if fixer.io or the ECB decides to change them. This list of currencies was up-to-date as of September 20, 2015.

## License

[WTFPL](http://www.wtfpl.net/txt/copying/) or [CC0](https://creativecommons.org/publicdomain/zero/1.0/), whichever you prefer. A donation and/or attribution are appreciated, but not required.

## Donate

My income consists largely of donations for my projects. If this module is useful to you, consider [making a donation](http://cryto.net/~joepie91/donate.html)!

You can donate using Bitcoin, PayPal, Flattr, cash-in-mail, SEPA transfers, and pretty much anything else.

## Contributing

Pull requests welcome. Please make sure your modifications are in line with the overall code style, and ensure that you're editing the `.coffee` files, not the `.js` files.

Build tool of choice is `gulp`; simply run `gulp` while developing, and it will watch for changes.

Be aware that by making a pull request, you agree to release your modifications under the licenses stated above.

## Usage

A simple example:

```javascript
var Promise = require("bluebird");
var getExchangeRates = require("get-exchange-rates");

Promise.try(function() {
	return getExchangeRates();
}).then(function(rates) {
	var amountInEuro = 2;
	var amountInUSD = amountInEuro * rates.USD;
	
	console.log(amountInEuro + " EUR = " + amountInUSD + " USD");
	// eg. "2 EUR = 2.2838 USD"
})
```

## API

### getExchangeRates([cacheExpiration])

Retrieves the exchange rates - either from the cache, or remotely. If retrieved remotely, the results are automatically cached. The rates are *not* rounded - you are responsible for doing this yourself.

Returns a Promise, that resolves with an object containing the rates.

The function will never reject - if either of the APIs is unavailable, the function will simply return stale rates. This may be changed at a later point (and will, in line with semantic versioning, result in a major version bump).

* __cacheExpiration__: *Optional, defaults to 5 minutes.* The duration in seconds, after which the cache should expire. The first call after this duration will result in the cache being repopulated. This option will only take effect if the result is retrieved remotely. __Be respectful to the API operators; please do not set this lower than 5 minutes (300 seconds).__
