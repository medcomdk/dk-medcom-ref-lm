/*

Logical: SORServiceEntry
//Parent: http://hl7.org/fhir/StructureDefinition/Logical
Id: SORServiceEntry
Title: "SOR Service Entry"
Description: "Service- eller funktionsbeskrivelse for en SOR-registreret organisatorisk enhed."
* serviceId 0..1 Identifier "Identifikator for servicefunktion eller tilbud"
* serviceType 1..1 CodeableConcept "Type af service eller funktion"
* description 0..1 string "Kort beskrivelse af servicen"
* specialty 0..* CodeableConcept "Speciale eller fagområde for servicen"
* availability 0..* SOROpeningHours "Tilgængelighed for servicen"
* location 0..1 Reference(Location) "Lokation hvor servicen leveres"
* contactPoint 0..* ContactPoint "Kontaktinformation for servicen"

*/