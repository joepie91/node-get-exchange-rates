Promise = require "bluebird"
bhttp = require "bhttp"

lastRates = null
lastRateCheck = 0
expireTime = 5 * 60 * 1000 # 5 minutes

module.exports = (cacheExpiration) ->
	Promise.try ->
		if Date.now() > lastRateCheck + expireTime
			# We need fresh API data, our cache has expired.
			Promise.try ->
				Promise.all [
					bhttp.get "http://api.fixer.io/latest", decodeJSON: true
					bhttp.get "https://blockchain.info/ticker", decodeJSON: true
				]
			.spread (fixerRates, blockchainRates) ->
				eurRates = fixerRates.body.rates
				eurRates.BTC = 1 / blockchainRates.body.EUR["15m"]
				return eurRates
			.then (rates) ->
				lastRates = rates
				lastRateCheck = Date.now()
				
				if cacheExpiration?
					expireTime = cacheExpiration * 1000
					
				return rates
			.catch (err) ->
				# API is down. FIXME: Allow for logging this error somehow.
				return lastRates
		else
			return lastRates
