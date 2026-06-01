/*
Logical: SOROrganizationEntry
//Parent: http://hl7.org/fhir/StructureDefinition/Logical
Id: SOROrganizationEntry
Title: "SOR Organization Entry"
Description: "Logisk model for organisatoriske poster i Sundhedsvæsenets OrganisationsRegister (SOR)."
* identifier 1..* Identifier "SOR-identifikatorer og officielle enhedsidentifikatorer"
* sorUnitId 0..1 Identifier "SOR's interne organisatoriske enhedsnummer"
* cvrNumber 0..1 Identifier "CVR-nummer for juridisk enhed"
* pNumber 0..1 Identifier "P-nummer for organisatorisk enhed"
* eanNumber 0..1 Identifier "EAN-nummer eller betalingskode"
* name 1..1 string "Organisationens officielle navn"
* displayName 0..1 string "Kort eller forkortet navn"
* alias 0..* string "Alternative navne, forkortelser eller handelsnavne"
* status 0..1 code "Registreringens status i SOR"
* statusReason 0..1 string "Begrundelse for statusændringer eller inaktivitet"
* activePeriod 0..1 Period "Den periode, hvor enheden er aktiv i registeret"
* organizationType 0..* CodeableConcept "Type af organisationsenhed"
* sector 0..1 CodeableConcept "Sektorklassifikation"
* ownership 0..1 CodeableConcept "Ejerskabsform eller juridisk driftsform"
* legalEntityStatus 0..1 CodeableConcept "Juridisk status for den registrerede enhed"
* parentOrganization 0..1 Reference(Organization) "Overordnet organisatorisk enhed"
* managingOrganization 0..1 Reference(Organization) "Organisation der har ledelsesansvaret"
* addresses 0..* SORAddress "Adresseoplysninger knyttet til enheden"
* contactPoints 0..* ContactPoint "Telefon, email og anden kontaktinformation"
* communication 0..* CodeableConcept "Sprog og kommunikationskanaler"
* serviceScope 0..* CodeableConcept "Service- eller fagområde for enheden"
* specialty 0..* CodeableConcept "Fagområder eller specialer knyttet til enheden"
* openingHours 0..* SOROpeningHours "Åbningstider eller tilgængelighedsintervaller"
* relatedLocation 0..* Reference(Location) "Fysiske lokationer knyttet til enheden"
* relatedService 0..* Reference(HealthcareService) "Servicefunktioner knyttet til enheden"
* services 0..* SORServiceEntry "Detaljer om services eller funktioner leveret af enheden"
* affiliations 0..* SOROrganizationRelationship "Relationer til andre organisatoriske enheder"
* notes 0..* string "Frie tekstnoter eller administrative bemærkninger"
* registryEntryDate 0..1 dateTime "Dato og tidspunkt for registrering i SOR"
* lastUpdated 0..1 dateTime "Tidspunkt for seneste opdatering i registeret"

Logical: SOROpeningHours
//Parent: http://hl7.org/fhir/StructureDefinition/Logical
Id: SOROpeningHours
Title: "SOR Opening Hours"
Description: "Åbningstider eller tilgængelighedsintervaller for en SOR-enhed."
* dayOfWeek 0..* CodeableConcept "Ugedag eller dagtype"
* openingTime 0..1 time "Åbningstidspunkt"
* closingTime 0..1 time "Lukketidspunkt"
* isClosed 0..1 boolean "Angivelse om enheden er lukket denne dag"
* description 0..1 string "Beskrivelse af åbningstiden"
* applicablePeriod 0..1 Period "Gyldighedsperiode for disse åbningstider"

*/