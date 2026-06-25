# Usecases - DK MEDCOM REFERRAL LM v0.1.0

* [**Table of Contents**](toc.md)
* **Usecases**

## Usecases

# Use cases

De følgende use cases omsætter [Fra "FHIR Henvisninger (Word)"](#fra-fhir-henvisninger-word) til use case beskrivelser. oversigten over use cases er ingenlunde dækkende for henvisningsområdet, men er initielle eksempler på, hvilke udfordringer, som man gerne vil have løst ift den eksisterende henvisningsløsning i Danmark.

## Visitator use cases

### Indeholdt besked i henvisningen

* Som visitator af en henvisning 
* Vil jeg gerne kunne bede om yderligere information fra henviser
* Når jeg vurderer at henvisningen ikke er fyldestgørende ift at riagere den.
 

(De vil gerne vide mere omkring at holde 'besked' i henvisningen - således hvis den er mangelfuld så kan den suppleres/opdateres?)

### Undgå genindtastning af henvisning

* Som henviser 
* vil jeg gerne undgå at skulle indtaste henvisningen igen
* når jeg har fået en henvisning retur fra visitator med ønske om flere informationer
 

(1. Det er muligt at 'pakke' henvisningen ind i den data paradigme kontekst som passer og holde et ID på indholdet = henvisningen, og ID på selve indpakningen. )

## Fra "FHIR Henvisninger (Word)":

De vil gerne vide mere omkring at holde 'besked' i henvisningen - således hvis den er mangelfuld så kan den suppleres/opdateres? Hvilke muligheder har vi? Lav et notat med fordele for modernisering af henvisninger.

```
    1.	Det er muligt at 'pakke' henvisningen ind i den data paradigme kontekst som passer og holde et ID på indholdet = henvisningen, og ID på selve indpakningen. 
    2.	Det er muligt at udstille et notefelt hvor bruger kan beskrive mangler på henvisningen når denne returneres. 
    3.	Det er vigtigt at henvisningen kan 'sendes' frem & tilbage og data kan beriges og persisteres. 
    4.	Vi ønsker at droppe korrespondancen i den sammenhæng.
    5.	Visitationscentralen skal understøttes - så 'videre sendelse' skal være muligt. 
    6.	Henvisninger skal fortsat kunne understøtte ’pausering’. 
    **Arbejdsgangen på sygehuse for håndtering af modtagne henvisninger og pausering af en henvisning, mens der indhentes oplysninger. (Korrespondancen / CareC)**
    7.	Hvorledes ser vi (MedCom) DNHF i denne sammenhæng. Er der et bedre alternativ?
    8.	Pakke tabellen? (meget er fritekst i dag) – kan vi erstatte det med struktureret data?
    9.	Understøtte Vedhæftninger (genbrug fra CareC).
    10.	Årsager til ’tilbage viste’ henvisninger (til statistik opsamling).

```

