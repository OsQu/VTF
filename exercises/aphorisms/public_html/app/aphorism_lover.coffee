# Aphorism lover only logs in, and logs out (and runs additionally scripts meanwhile)

casper = require('casper').create()

unless casper.cli.has(0) && casper.cli.has(1) && casper.cli.has(2)
  casper.echo "Command line parameters: startUrl username password"
  casper.exit()

startUrl = casper.cli.get(0)
username = casper.cli.get(1)
password = casper.cli.get(2)

casper.start startUrl, ->
  @fill("form", {
    name: username,
    password: password
  }, true)

casper.then ->
  @wait 3000, ->
    # Okey, time to logout
    @click "#logout"

casper.run()
