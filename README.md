# TODO List

En enkel TODO-applikation som tillåter inloggning via google-konton och håller en todolista för varje användare. Användare kan lägga till saker i todolistan, samt markera dem som klara.

Applikationen i sin nuvarande form är relativt enkel och skapades på några timmar då jag inte hade ett vettigt projekt för att visa kod jag skrivit. De flesta större projekt jag producerat själv är skrivna åt kunder eller arbetsgivare, och kunde således inte användas som kodexempel mot tredje part.

Ett exempel på ett betydligt större projekt jag utvecklat själv är [MindTech](http://www.mindtechcom.com). Alla projekt som i skrivande stund visas på [D05 IT's hemsida](http://www.d05.se) har även helt eller delvis producerats av mig.

Applikationen i nuläget är funktionell, men givetvis kan mycket vidareutveckling ske.

## Kompitabilitet
Applikationen är utvecklad under Ruby 1.9.3 men bör fungera under Ruby 1.9.2, man måste dock köra med en alterantiv webbserver (t.ex. `unicorn`) i development-miljön. Detta pga att gamla versioner av WEBrick (som används av `rails server`) har en för kort maxlängd på URIs vilket krånglar med google-konto-inloggning. Detta är [löst](https://github.com/ruby/ruby/commit/a671a06d2574ef888018081ed29bb80851a086f7#lib/webrick/httprequest.rb) i versionen som ingår i Ruby 1.9.3.  
