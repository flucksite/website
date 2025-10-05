require "rosetta"

@[Rosetta::DefaultLocale(:en)]
@[Rosetta::AvailableLocales(:en)]
module Rosetta
end

Rosetta::Backend.load("./config/rosetta")

Rosetta::Lucky.integrate
