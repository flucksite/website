require "rosetta"

@[Rosetta::DefaultLocale(:en)]
@[Rosetta::AvailableLocales(:en, :nl)]
module Rosetta
end

Rosetta::Backend.load("./config/rosetta")

Rosetta::Lucky.integrate
