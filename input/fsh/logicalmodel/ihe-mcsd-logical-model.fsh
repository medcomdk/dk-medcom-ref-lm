/*
// ╔══════════════════════════════════════════════════════════════════════╗
// ║   IHE mCSD – Mobile Care Services Discovery                         ║
// ║   FHIR Logical Model in FSH (FHIR Shorthand)                        ║
// ║   Baseret på IHE IT Infrastructure Technical Framework Supplement   ║
// ║   mCSD Rev. 3.8 (2023)                                              ║
// ╚══════════════════════════════════════════════════════════════════════╝

Alias: $v3-RoleCode        = http://terminology.hl7.org/CodeSystem/v3-RoleCode
Alias: $organization-type  = http://terminology.hl7.org/CodeSystem/organization-type
Alias: $contactentity-type = http://terminology.hl7.org/CodeSystem/contactentity-type
Alias: $mcsd-orgtype       = https://profiles.ihe.net/ITI/mCSD/CodeSystem/MCSDOrgAffTypes
Alias: $mcsd-ep-type       = https://profiles.ihe.net/ITI/mCSD/CodeSystem/MCSDEndpointTypes

// ──────────────────────────────────────────────────────────────────────
// 1.  LOGISK MODEL: mCSD Organization
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDOrganizationModel
Id: MCSDOrganizationModel
Title: "IHE mCSD Organization – Logisk Model"
Description: """
Logisk model for en organisation i IHE mCSD-kontekst.
En organisation repræsenterer en formel eller uformel gruppering af
personer eller organisationer med et fælles formål inden for
sundhedsvæsenet (f.eks. hospital, klinik, afdeling, netværk).
"""

* identifier          1..*  Identifier    "Entydig identifikator for organisationen"
* active              1..1  boolean       "Angiver om organisationen er aktiv"
* type                0..*  CodeableConcept "Organisationstype (f.eks. prov, dept, team)"
* name                1..1  string        "Organisationens officielle navn"
* alias               0..*  string        "Alternative navne eller forkortelser"
* telecom             0..*  ContactPoint  "Kontaktoplysninger (telefon, e-mail, mv.)"
* address             0..*  Address       "Fysisk eller postadresse"
* partOf              0..1  Reference(MCSDOrganizationModel) "Overordnet organisation (hierarki)"
* contact             0..*  BackboneElement "Kontaktperson for organisationen"
  * purpose           0..1  CodeableConcept  "Formål med kontakten"
  * name              0..1  HumanName        "Kontaktpersonens navn"
  * telecom           0..*  ContactPoint     "Kontaktpersonens kontaktoplysninger"
  * address           0..1  Address          "Kontaktpersonens adresse"
* endpoint            0..*  Reference(MCSDEndpointModel) "Tilknyttede endpoints (services)"

// ──────────────────────────────────────────────────────────────────────
// 2.  LOGISK MODEL: mCSD Location
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDLocationModel
Id: MCSDLocationModel
Title: "IHE mCSD Location – Logisk Model"
Description: """
Logisk model for en lokation i IHE mCSD-kontekst.
En lokation beskriver et fysisk sted, en bygning, en etage, et rum
eller en logisk servicezone, hvorfra sundhedsydelser leveres.
"""

* identifier          1..*  Identifier    "Entydig identifikator for lokationen"
* status              1..1  code          "Status: active | suspended | inactive"
* operationalStatus   0..1  Coding        "Operationel status (f.eks. seng ledig/optaget)"
* name                1..1  string        "Lokationens navn"
* alias               0..*  string        "Alternative navne"
* description         0..1  string        "Fritekstbeskrivelse af lokationen"
* mode                1..1  code          "instance | kind"
* type                0..*  CodeableConcept "Lokationstype (f.eks. HOSP, DENT, PHARM)"
* telecom             0..*  ContactPoint  "Kontaktoplysninger for lokationen"
* address             0..1  Address       "Fysisk adresse"
* physicalType        0..1  CodeableConcept "Fysisk type (f.eks. bu=bygning, ro=rum)"
* position            0..1  BackboneElement "Geografiske koordinater"
  * longitude         1..1  decimal       "Længdegrad (WGS84)"
  * latitude          1..1  decimal       "Breddegrad (WGS84)"
  * altitude          0..1  decimal       "Højde over havoverfladen"
* managingOrganization 0..1 Reference(MCSDOrganizationModel) "Ansvarlig organisation"
* partOf              0..1  Reference(MCSDLocationModel) "Overordnet lokation (hierarki)"
* hoursOfOperation    0..*  BackboneElement "Åbningstider"
  * daysOfWeek        0..*  code          "Ugedage: mon | tue | wed | thu | fri | sat | sun"
  * allDay            0..1  boolean       "Åbent hele dagen"
  * openingTime       0..1  time          "Åbningstidspunkt"
  * closingTime       0..1  time          "Lukketidspunkt"
* availabilityExceptions 0..1 string     "Undtagelser til normale åbningstider"
* endpoint            0..*  Reference(MCSDEndpointModel) "Tilknyttede endpoints"

// ──────────────────────────────────────────────────────────────────────
// 3.  LOGISK MODEL: mCSD Practitioner
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDPractitionerModel
Id: MCSDPractitionerModel
Title: "IHE mCSD Practitioner – Logisk Model"
Description: """
Logisk model for en sundhedsperson (practitioner) i IHE mCSD-kontekst.
Repræsenterer en person med formelle kompetencer til at levere
sundhedsydelser.
"""

* identifier          1..*  Identifier    "Entydig identifikator (f.eks. autorisationsnummer)"
* active              1..1  boolean       "Angiver om sundhedspersonen er aktiv i registret"
* name                1..*  HumanName     "Navn (kan inkludere præfiks og suffiks)"
* telecom             0..*  ContactPoint  "Kontaktoplysninger"
* address             0..*  Address       "Adresseoplysninger"
* gender              0..1  code          "Køn: male | female | other | unknown"
* birthDate           0..1  date          "Fødselsdato"
* photo               0..*  Attachment    "Fotografi"
* qualification       0..*  BackboneElement "Kvalifikationer og uddannelse"
  * identifier        0..*  Identifier    "Identifikator for kvalifikationen"
  * code              1..1  CodeableConcept "Kode for kvalifikationstype"
  * period            0..1  Period        "Gyldighedsperiode"
  * issuer            0..1  Reference(MCSDOrganizationModel) "Udstedende organisation"
* communication       0..*  CodeableConcept "Sprog der tales/skrives"

// ──────────────────────────────────────────────────────────────────────
// 4.  LOGISK MODEL: mCSD PractitionerRole
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDPractitionerRoleModel
Id: MCSDPractitionerRoleModel
Title: "IHE mCSD PractitionerRole – Logisk Model"
Description: """
Logisk model for en sundhedspersons rolle i IHE mCSD-kontekst.
Forbinder en sundhedsperson med en organisation og/eller lokation
i en specifik kapacitet (rolle).
"""

* identifier          0..*  Identifier    "Entydig identifikator for rollen"
* active              1..1  boolean       "Angiver om rollen er aktiv"
* period              0..1  Period        "Periode hvori rollen er gyldig"
* practitioner        1..1  Reference(MCSDPractitionerModel) "Den tilknyttede sundhedsperson"
* organization        1..1  Reference(MCSDOrganizationModel) "Den tilknyttede organisation"
* code                0..*  CodeableConcept "Rollebeskrivelse (f.eks. læge, sygeplejerske)"
* specialty           0..*  CodeableConcept "Specialer (f.eks. kardiologi, pædiatri)"
* location            0..*  Reference(MCSDLocationModel) "Lokationer hvor rollen udøves"
* healthcareService   0..*  Reference(MCSDHealthcareServiceModel) "Tilknyttede sundhedsydelser"
* telecom             0..*  ContactPoint  "Rollespecifikke kontaktoplysninger"
* availableTime       0..*  BackboneElement "Tilgængelighed"
  * daysOfWeek        0..*  code          "Ugedage"
  * allDay            0..1  boolean       "Tilgængelig hele dagen"
  * availableStartTime 0..1 time          "Starttidspunkt"
  * availableEndTime  0..1  time          "Sluttidspunkt"
* notAvailable        0..*  BackboneElement "Perioder med utilgængelighed"
  * description       1..1  string        "Årsag til utilgængelighed"
  * during            0..1  Period        "Periode med utilgængelighed"
* endpoint            0..*  Reference(MCSDEndpointModel) "Tilknyttede endpoints"

// ──────────────────────────────────────────────────────────────────────
// 5.  LOGISK MODEL: mCSD HealthcareService
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDHealthcareServiceModel
Id: MCSDHealthcareServiceModel
Title: "IHE mCSD HealthcareService – Logisk Model"
Description: """
Logisk model for en sundhedsydelse i IHE mCSD-kontekst.
Beskriver en specifik sundhedsydelse eller et tilbud, der leveres
af en organisation på et eller flere steder.
"""

* identifier          0..*  Identifier    "Entydig identifikator for ydelsen"
* active              1..1  boolean       "Angiver om ydelsen er aktiv"
* providedBy          1..1  Reference(MCSDOrganizationModel) "Ydende organisation"
* category            0..*  CodeableConcept "Overordnet ydelseskategori"
* type                0..*  CodeableConcept "Ydelsestype"
* specialty           0..*  CodeableConcept "Relevante specialer"
* location            1..*  Reference(MCSDLocationModel) "Lokationer hvor ydelsen tilbydes"
* name                0..1  string        "Ydelsens navn"
* comment             0..1  string        "Yderligere kommentarer"
* extraDetails        0..1  markdown      "Detaljerede beskrivelser (markdown)"
* photo               0..1  Attachment    "Illustration af ydelsen"
* telecom             0..*  ContactPoint  "Kontaktoplysninger for ydelsen"
* coverageArea        0..*  Reference(MCSDLocationModel) "Geografisk dækningsområde"
* serviceProvisionCode 0..* CodeableConcept "Finansieringsmodel (f.eks. gratis, gebyr)"
* eligibility         0..*  BackboneElement "Kriterie for berettigelse"
  * code              0..1  CodeableConcept "Kode for berettigelseskriteriet"
  * comment           0..1  markdown      "Beskrivelse af kriteriet"
* program             0..*  CodeableConcept "Programmer ydelsen er en del af"
* characteristic      0..*  CodeableConcept "Karakteristika (f.eks. handicapvenlig)"
* communication       0..*  CodeableConcept "Sprog der tilbydes"
* referralMethod      0..*  CodeableConcept "Henvisningsmetode"
* appointmentRequired 0..1  boolean       "Kræves forudgående aftale"
* availableTime       0..*  BackboneElement "Tilgængelighed"
  * daysOfWeek        0..*  code          "Ugedage"
  * allDay            0..1  boolean       "Tilgængelig hele dagen"
  * availableStartTime 0..1 time          "Starttidspunkt"
  * availableEndTime  0..1  time          "Sluttidspunkt"
* notAvailable        0..*  BackboneElement "Perioder med utilgængelighed"
  * description       1..1  string        "Årsag"
  * during            0..1  Period        "Periode"
* availabilityExceptions 0..1 string     "Undtagelser"
* endpoint            0..*  Reference(MCSDEndpointModel) "Tilknyttede endpoints"

// ──────────────────────────────────────────────────────────────────────
// 6.  LOGISK MODEL: mCSD Endpoint
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDEndpointModel
Id: MCSDEndpointModel
Title: "IHE mCSD Endpoint – Logisk Model"
Description: """
Logisk model for et endpoint i IHE mCSD-kontekst.
Et endpoint beskriver en teknisk forbindelsespunkt, der kan bruges til
at sende eller modtage elektroniske meddelelser, dokumenter eller andre
data fra/til en organisation, lokation eller sundhedsydelse.
"""

* identifier          0..*  Identifier    "Entydig identifikator for endpoint"
* status              1..1  code          "Status: active | suspended | error | off | entered-in-error | test"
* connectionType      1..1  Coding        "Forbindelsestype (f.eks. hl7-fhir-rest, ihe-xds)"
* name                0..1  string        "Menneskelæsbart navn"
* managingOrganization 0..1 Reference(MCSDOrganizationModel) "Ansvarlig organisation"
* contact             0..*  ContactPoint  "Teknisk kontaktperson"
* period              0..1  Period        "Gyldighedsperiode"
* payloadType         1..*  CodeableConcept "Understøttede payload-typer"
* payloadMimeType     0..*  code          "MIME-typer (f.eks. application/fhir+json)"
* address             1..1  url           "URL/adresse på endpoint"
* header              0..*  string        "HTTP-headers der skal sendes med forespørgsler"

// ──────────────────────────────────────────────────────────────────────
// 7.  LOGISK MODEL: mCSD OrganizationAffiliation
// ──────────────────────────────────────────────────────────────────────
Logical: MCSDOrganizationAffiliationModel
Id: MCSDOrganizationAffiliationModel
Title: "IHE mCSD OrganizationAffiliation – Logisk Model"
Description: """
Logisk model for en tilknytning mellem to organisationer i mCSD.
Bruges til at modellere netværksmedlemsskaber, franchise-relationer,
samarbejdsaftaler o.l. – relationer der ikke er hierarkiske.
"""

* identifier          0..*  Identifier    "Entydig identifikator"
* active              1..1  boolean       "Angiver om tilknytningen er aktiv"
* period              0..1  Period        "Gyldighedsperiode"
* organization        1..1  Reference(MCSDOrganizationModel) "Den primære organisation (modtager)"
* participatingOrganization 1..1 Reference(MCSDOrganizationModel) "Den deltagende organisation"
* network             0..*  Reference(MCSDOrganizationModel) "Netværk tilknytningen gælder for"
* code                0..*  CodeableConcept "Type af tilknytning (f.eks. member, partner)"
* specialty           0..*  CodeableConcept "Relevante specialer"
* location            0..*  Reference(MCSDLocationModel) "Relevante lokationer"
* healthcareService   0..*  Reference(MCSDHealthcareServiceModel) "Relevante ydelser"
* telecom             0..*  ContactPoint  "Kontaktoplysninger"
* endpoint            0..*  Reference(MCSDEndpointModel) "Tilknyttede endpoints"

// ──────────────────────────────────────────────────────────────────────
// 8.  AKTØR-KAPABILITETSPROFILER (CapabilityStatement skabeloner)
// ──────────────────────────────────────────────────────────────────────

// 8a. Care Services Selective Consumer (ITI-90)
RuleSet: MCSDSelectiveConsumerRules
* rest[0].mode = #client
* rest[0].documentation = """
Care Services Selective Consumer søger i Care Services Directory
via ITI-90 (Find Matching Care Services).
"""
* rest[0].resource[0].type = #Organization
* rest[0].resource[0].interaction[0].code = #search-type
* rest[0].resource[0].interaction[1].code = #read
* rest[0].resource[1].type = #Location
* rest[0].resource[1].interaction[0].code = #search-type
* rest[0].resource[1].interaction[1].code = #read
* rest[0].resource[2].type = #Practitioner
* rest[0].resource[2].interaction[0].code = #search-type
* rest[0].resource[2].interaction[1].code = #read
* rest[0].resource[3].type = #PractitionerRole
* rest[0].resource[3].interaction[0].code = #search-type
* rest[0].resource[3].interaction[1].code = #read
* rest[0].resource[4].type = #HealthcareService
* rest[0].resource[4].interaction[0].code = #search-type
* rest[0].resource[4].interaction[1].code = #read
* rest[0].resource[5].type = #Endpoint
* rest[0].resource[5].interaction[0].code = #search-type
* rest[0].resource[5].interaction[1].code = #read
* rest[0].resource[6].type = #OrganizationAffiliation
* rest[0].resource[6].interaction[0].code = #search-type
* rest[0].resource[6].interaction[1].code = #read

// 8b. Care Services Update Supplier (ITI-91)
RuleSet: MCSDUpdateSupplierRules
* rest[0].mode = #server
* rest[0].documentation = """
Care Services Update Supplier leverer opdateringer til
Care Services Directory via ITI-91 (Request Care Services Updates).
"""
* rest[0].resource[0].type = #Bundle
* rest[0].resource[0].interaction[0].code = #read
* rest[0].resource[0].interaction[1].code = #search-type

// ──────────────────────────────────────────────────────────────────────
// 9.  SØGEPARAMETRE (centrale for ITI-90)
// ──────────────────────────────────────────────────────────────────────

/*
// Organization søgeparametre
SearchParameter: MCSDOrganizationActiveSearchParam
Id: MCSDOrganizationActiveSearchParam
Title: "mCSD Organization – active"
* url = "https://profiles.ihe.net/ITI/mCSD/SearchParameter/MCSDOrganizationActive"
* status = #active
* code = #active
* base[0] = #Organization
* type = #token
* description = "Søg på om organisationen er aktiv"
* expression = "Organization.active"

SearchParameter: MCSDOrganizationTypeSearchParam
Id: MCSDOrganizationTypeSearchParam
Title: "mCSD Organization – type"
* url = "https://profiles.ihe.net/ITI/mCSD/SearchParameter/MCSDOrganizationType"
* status = #active
* code = #type
* base[0] = #Organization
* type = #token
* description = "Søg på organisationstype"
* expression = "Organization.type"

// Location søgeparametre
SearchParameter: MCSDLocationStatusSearchParam
Id: MCSDLocationStatusSearchParam
Title: "mCSD Location – status"
* url = "https://profiles.ihe.net/ITI/mCSD/SearchParameter/MCSDLocationStatus"
* status = #active
* code = #status
* base[0] = #Location
* type = #token
* description = "Søg på lokationsstatus"
* expression = "Location.status"

SearchParameter: MCSDLocationTypeSearchParam
Id: MCSDLocationTypeSearchParam
Title: "mCSD Location – type"
* url = "https://profiles.ihe.net/ITI/mCSD/SearchParameter/MCSDLocationType"
* status = #active
* code = #type
* base[0] = #Location
* type = #token
* description = "Søg på lokationstype"
* expression = "Location.type"

// ──────────────────────────────────────────────────────────────────────
// 10. EKSEMPEL-INSTANSER
// ──────────────────────────────────────────────────────────────────────

// Eksempel: Organisation (hospital)
Instance: ExampleHospital
InstanceOf: Organization
Title: "Eksempel: Regionshospital Nord"
Description: "Eksempel på en mCSD-organisation – et regionshospital"
* identifier[0].system = "urn:oid:1.2.208.176.1.1"
* identifier[0].value = "5790000120314"
* active = true
* type[0] = $organization-type#prov "Healthcare Provider"
* name = "Regionshospital Nord"
* alias[0] = "RHN"
* telecom[0].system = #phone
* telecom[0].value = "+45 96 00 00 00"
* telecom[0].use = #work
* address[0].use = #work
* address[0].type = #physical
* address[0].line[0] = "Hospitalsvej 1"
* address[0].city = "Hjørring"
* address[0].postalCode = "9800"
* address[0].country = "DK"

// Eksempel: Lokation (akutafdeling)
Instance: ExampleEmergencyDept
InstanceOf: Location
Title: "Eksempel: Akutafdeling – Regionshospital Nord"
Description: "Eksempel på en mCSD-lokation – en akutafdeling"
* identifier[0].system = "urn:oid:1.2.208.176.1.1"
* identifier[0].value = "5790000120314-AKU"
* status = #active
* name = "Akutafdeling"
* description = "Akut- og traumeafdeling, Regionshospital Nord"
* mode = #instance
* type[0] = $v3-RoleCode#ER "Emergency room"
* address.use = #work
* address.line[0] = "Hospitalsvej 1, Indgang A"
* address.city = "Hjørring"
* address.postalCode = "9800"
* address.country = "DK"
* physicalType = http://terminology.hl7.org/CodeSystem/location-physical-type#wi "Wing"
* position.longitude = 9.986714
* position.latitude = 57.462046
* managingOrganization = Reference(ExampleHospital)
* hoursOfOperation[0].daysOfWeek[0] = #mon
* hoursOfOperation[0].daysOfWeek[1] = #tue
* hoursOfOperation[0].daysOfWeek[2] = #wed
* hoursOfOperation[0].daysOfWeek[3] = #thu
* hoursOfOperation[0].daysOfWeek[4] = #fri
* hoursOfOperation[0].daysOfWeek[5] = #sat
* hoursOfOperation[0].daysOfWeek[6] = #sun
* hoursOfOperation[0].allDay = true

// Eksempel: Endpoint (FHIR REST)
Instance: ExampleFHIREndpoint
InstanceOf: Endpoint
Title: "Eksempel: FHIR REST Endpoint – Regionshospital Nord"
Description: "Eksempel på et mCSD-endpoint med FHIR R4 REST interface"
* identifier[0].system = "urn:oid:1.2.208.176.1.1"
* identifier[0].value = "5790000120314-FHIR"
* status = #active
* connectionType = http://terminology.hl7.org/CodeSystem/endpoint-connection-type#hl7-fhir-rest
* name = "FHIR R4 REST – Regionshospital Nord"
* managingOrganization = Reference(ExampleHospital)
* contact[0].system = #email
* contact[0].value = "integration@rhn.dk"
* payloadType[0] = http://terminology.hl7.org/CodeSystem/endpoint-payload-type#any
* payloadMimeType[0] = #application/fhir+json
* payloadMimeType[1] = #application/fhir+xml
* address = "https://fhir.rhn.dk/r4"
* endpoint            0..*  Reference(MCSDEndpointModel) "Tilknyttede endpoints"
*/
