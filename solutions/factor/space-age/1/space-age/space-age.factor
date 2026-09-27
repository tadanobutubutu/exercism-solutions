USING: assocs kernel math ;
IN: space-age

SYMBOL: mercury
SYMBOL: venus
SYMBOL: earth
SYMBOL: mars
SYMBOL: jupiter
SYMBOL: saturn
SYMBOL: uranus
SYMBOL: neptune

CONSTANT: orbital-periods H{
    { mercury 0.2408467 }
    { venus 0.61519726 }
    { earth 1.0 }
    { mars 1.8808158 }
    { jupiter 11.862615 }
    { saturn 29.447498 }
    { uranus 84.016846 }
    { neptune 164.79132 }
}

:: on-planet ( seconds planet -- years )
    seconds 31557600.0 /f planet orbital-periods at /f ;
