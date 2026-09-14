// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  DK MedCom Henvisning — FHIR Shorthand (FSH)                               ║
// ║  Logisk model baseret på MedCom REF01 / FHIR R4 / DK Core                  ║
// ║  Inkluderer de 8 vedtagne MedCom-fraser i kliniske oplysninger              ║
// ╚══════════════════════════════════════════════════════════════════════════════╝

// Alias-erklæringer
Alias: $SOR          = urn:oid:1.2.208.176.1.1
Alias: $CPR          = urn:oid:1.2.208.176.1.2
Alias: $SKS          = urn:oid:1.2.208.176.2.4
Alias: $ICPC2        = urn:oid:1.2.208.176.2.31
Alias: $DkCorePatient       = http://hl7.dk/fhir/core/StructureDefinition/dk-core-patient
Alias: $DkCoreOrg           = http://hl7.dk/fhir/core/StructureDefinition/dk-core-organization
Alias: $DkCorePractitioner  = http://hl7.dk/fhir/core/StructureDefinition/dk-core-practitioner
Alias: $SCT          = http://snomed.info/sct
Alias: $LOINC        = http://loinc.org
Alias: $v3ActCode    = http://terminology.hl7.org/CodeSystem/v3-ActCode
Alias: $reqIntent    = http://hl7.org/fhir/request-intent
Alias: $taskStatus   = http://hl7.org/fhir/task-status
Alias: $apptStatus  = http://hl7.org/fhir/appointmentstatus


// ════════════════════════════════════════════════════════════════════════════════
//  CODESYSTEMS
// ════════════════════════════════════════════════════════════════════════════════

/*
CodeSystem: DkMedComReferralCategoryCS
Id:         dk-medcom-referral-category-cs
Title:      "DK MedCom Henvisningskategori"
Description: "Kategorier for MedCom-baserede henvisninger svarende til pakketabellens hoveddimensioner."
* #sygehus                  "Sygehushenvisning"           "Generel eller pakkebaseret sygehushenvisning (REF01)"
* #speciallaege             "Speciallægehenvisning"       "Henvisning til praktiserende speciallæge (REF06)"
* #kommune-forebyggelse     "Kommunal forebyggelse"       "Henvisning til kommunens forebyggelsestilbud (XREF15)"
* #kommune-akut             "Kommunal akutfunktion"       "Henvisning til kommunal akutfunktion (XREF22)"
* #roentgen                 "Billeddiagnostik"            "Billeddiagnostisk henvisning (REF02)"
* #psykolog                 "Psykologhenvisning"          "Henvisning til praktiserende psykolog (REF10)"
*/

/*
CodeSystem: DkMedComReferralDialogTypeCS
Id:         dk-medcom-referral-dialog-type-cs
Title:      "DK MedCom Henvisningsdialog-type"
Description: "Typer af strukturerede beskeder i dialogen om en henvisning."
* #supplement-anmodning  "Anmodning om supplement"   "Visitator anmoder om supplerende kliniske oplysninger"
* #supplement-svar       "Svar på supplement"        "Henviser besvarer supplement-anmodning"
* #faglig-afklaring      "Faglig afklaring"          "Gensidig faglig dialog om indikation eller egnethed"
* #korrektionsaftale     "Korrektionsaftale"         "Dialog om rettelse af fejl i afsendt henvisning"
* #alternativ-visitation "Alternativ visitation"     "Dialog om alternativt tilbud ved afvisning"
*/

CodeSystem: DkMedComReferralTaskOutcomeCS
Id:         dk-medcom-referral-task-outcome-cs
Title:      "DK MedCom Visitationsafgørelse"
Description: "Udfald af visitatorens formelle afgørelse om en modtaget henvisning."
* #accept           "Accept"          "Henvisningen er accepteret og forløb oprettes"
* #afvisning        "Afvisning"       "Henvisningen er afvist med begrundelse"
* #videresendelse   "Videresendelse"  "Henvisningen videresendes til anden modtager"
* #supplement       "Afventer"        "Afgørelse afventer supplerende oplysninger"


// ════════════════════════════════════════════════════════════════════════════════
//  VALUESETS
// ════════════════════════════════════════════════════════════════════════════════

ValueSet: DkMedComReferralCategoryVS
Id:       dk-medcom-referral-category-vs
Title:    "DK MedCom Henvisningskategori"
Description: "Gyldige kategorier for en MedCom-baseret FHIR-henvisning."
* include codes from system DkMedComReferralCategoryCS


ValueSet: DkMedComReferralDialogTypeVS
Id:       dk-medcom-referral-dialog-type-vs
Title:    "DK MedCom Henvisningsdialog-type"
Description: "Gyldige typer for strukturerede beskeder i et henvisningsforløb."
* include codes from system DkMedComReferralDialogTypeCS


ValueSet: DkMedComReferralTaskOutcomeVS
Id:       dk-medcom-referral-task-outcome-vs
Title:    "DK MedCom Visitationsafgørelse"
Description: "Gyldige udfald af en visitationsafgørelse."
* include codes from system DkMedComReferralTaskOutcomeCS


// ════════════════════════════════════════════════════════════════════════════════
//  EXTENSION — DE 8 MEDCOM-FRASER (Kliniske oplysninger)
// ════════════════════════════════════════════════════════════════════════════════

Extension: DkMedComReferralClinicalNotesExtension
Id:        dk-medcom-referral-clinical-notes
Title:     "DK MedCom Kliniske oplysninger (8 fraser)"
Description: """
  Struktureret extension der indeholder de 8 vedtagne MedCom-fraser
  for kliniske oplysninger i en dynamisk sygehushenvisning (REF01).
  Fraserne svarer til felterne i 'Den gode henvisning' og pakketabellens
  kliniske tekstdel. Alle delfelter er valgfrie (0..1).
  FHIR-mapping: ServiceRequest.note (alternativt som named extension).
"""
* ^context[0].type = #element
* ^context[0].expression = "ServiceRequest"

// Delfelt 1 — Cave
* extension contains cave 0..1
* extension[cave].value[x] only string
* extension[cave] ^short = "Cave"
* extension[cave] ^definition = """
  Overfølsomhedsreaktioner, kendte allergier eller anden information
  om forhold der kan udgøre en risiko for patienten under behandling.
  Svarer til REF01 kliniske oplysninger, afsnit (a): Cave.
"""

// Delfelt 2 — Anamnese (aktuel sygehistorie)
* extension contains anamnese 0..1
* extension[anamnese].value[x] only string
* extension[anamnese] ^short = "Anamnese"
* extension[anamnese] ^definition = """
  Aktuel sygehistorie: patientens beskrivelse af problemerne og
  den kliniske problemstilling der begrunder henvisningen.
  Svarer til REF01 kliniske oplysninger, afsnit (b): Anamnese.
"""

// Delfelt 3 — Tidligere relevant sygehistorie
* extension contains tidligereRelevantSygehistorie 0..1
* extension[tidligereRelevantSygehistorie].value[x] only string
* extension[tidligereRelevantSygehistorie] ^short = "Tidligere relevant sygehistorie"
* extension[tidligereRelevantSygehistorie] ^definition = """
  Tidligere indlæggelser, operationer, relevante kroniske sygdomme
  og tidligere undersøgelsesresultater med relevans for den aktuelle
  henvisning. Sidst indlagt: hvor og hvornår.
  Svarer til REF01 kliniske oplysninger: Tidligere relevant sygehistorie.
"""

// Delfelt 4 — Objektive fund
* extension contains objektiveFund 0..1
* extension[objektiveFund].value[x] only string
* extension[objektiveFund] ^short = "Objektive fund"
* extension[objektiveFund] ^definition = """
  Objektive fund ved klinisk undersøgelse i telegramstil.
  Inkluderer relevante undersøgelsesresultater fra radiologisk
  afdeling og laboratorium (hvor og hvornår undersøgt samt resultat).
  Svarer til REF01 kliniske oplysninger, afsnit (b): Objektive fund.
"""

// Delfelt 5 — Undersøgelsesresultater
* extension contains undersøgelsesresultater 0..1
* extension[undersøgelsesresultater].value[x] only string
* extension[undersøgelsesresultater] ^short = "Undersøgelsesresultater"
* extension[undersøgelsesresultater] ^definition = """
  Relevante parakliniske undersøgelsesresultater — EKG, blodprøver,
  billeddiagnostik mv. — der understøtter henvisningsindikationen.
  Vedlæg evt. bilag (PDF/JPG) via ServiceRequest.supportingInfo.
  Svarer til REF01 kliniske oplysninger, afsnit (b) og (c).
"""

// Delfelt 6 — Aktuel medicin
* extension contains aktuelMedicin 0..1
* extension[aktuelMedicin].value[x] only string
* extension[aktuelMedicin] ^short = "Aktuel medicin"
* extension[aktuelMedicin] ^definition = """
  Aktuel medicinliste inkl. præparat, indikation, dosis og
  administrationstidspunkt. FMK skal være ajourført forud for
  afsendelse; dette felt er en tekstuel opsummering med reference
  til FMK. Svarer til REF01 kliniske oplysninger, afsnit (e): Medicin.
  Implementeringsanbefaling: overvej MedicationStatement-reference
  via ServiceRequest.supportingInfo frem for fritekst.
"""

// Delfelt 7 — Sociale forhold og særlige behov
* extension contains socialeForhold 0..1
* extension[socialeForhold].value[x] only string
* extension[socialeForhold] ^short = "Sociale forhold og særlige behov"
* extension[socialeForhold] ^definition = """
  Relevante sociale forhold: sygemelding, boligsituation, pårørende.
  Særlige behov: tolkebehov (sprog), hjælpemidler, mobilitetsbegrænsninger,
  transportforhold. Svarer til REF01 kliniske oplysninger, afsnit (b):
  Socialt samt særlige patientbehov.
"""

// Delfelt 8 — Sagt til patienten
* extension contains sagtTilPatienten 0..1
* extension[sagtTilPatienten].value[x] only string
* extension[sagtTilPatienten] ^short = "Sagt til patienten"
* extension[sagtTilPatienten] ^definition = """
  Oplysninger om hvad der er sagt til patienten og evt. pårørende
  om diagnose, prognose, videre forløb og forventet ventetid.
  Svarer til REF01 kliniske oplysninger, afsnit (b): Sagt til patienten.
"""


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Henvisning (ServiceRequest)
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferral
Parent:  ServiceRequest
Id:      dk-medcom-referral
Title:   "DK MedCom Henvisning"
Description: """
  Profil på ServiceRequest der repræsenterer en dansk MedCom-baseret henvisning
  (sygehus, speciallæge, kommune). Inkluderer de 8 vedtagne MedCom-fraser
  for kliniske oplysninger via DkMedComReferralClinicalNotesExtension.
  Baseret på MedCom REF01/XREF01 og DK Core.
"""

// ── Obligatoriske felter ─────────────────────────────────────────────────────
* status         1..1 MS
* status         ^short = "Status på henvisningen"
* status         ^definition = "proposed | active | on-hold | revoked | completed | entered-in-error"

* intent         1..1 MS
* intent         = $reqIntent#order
* intent         ^short = "Henvisningens intent — altid 'order'"

* category       1..1 MS
* category       from DkMedComReferralCategoryVS (required)
* category       ^short = "Henvisningstype (pakketabel-kategori)"
* category       ^definition = """
  Angiver hvilken type henvisning der er tale om svarende til
  pakketabellens kategorier: sygehus, speciallæge, kommune-forebyggelse,
  kommune-akut, billeddiagnostik eller psykolog.
"""

* priority       1..1 MS
* priority       ^short = "Hastegrad"
* priority       ^definition = "routine | urgent | asap | stat — svarende til REF01 indkaldelsesprioritering"

* subject        1..1 MS
* subject        only Reference(DkMedComReferralPatient)
* subject        ^short = "Den patient der viderehenvises"

* requester      1..1 MS
* requester      only Reference(DkMedComReferralRequesterRole)
* requester      ^short = "Henvisende behandler (Practitioner + PractitionerRole)"

* performer      0..1 MS
* performer      only Reference(DkMedComReferralPerformerRole)
* performer      ^short = "Visiterende behandler / modtagende enhed"

* locationReference 0..*
* locationReference ^short = "Modtagende afdeling / lokationsnummer (SOR)"

* authoredOn     1..1 MS
* authoredOn     ^short = "Dato for oprettelse af henvisningen"

// ── Indikation og ønsket ydelse ───────────────────────────────────────────────
* reasonCode     0..* MS
* reasonCode     ^short = "Henvisningsdiagnose (ICD-10 / ICPC-2)"
* reasonCode     ^definition = """
  Primærdiagnose og evt. bidiagnoser (max 5 i REF01).
  Brug ICD-10 for sygehushenvisning, ICPC-2 for almen praksis.
"""

* code           0..1 MS
* code           ^short = "Ønsket undersøgelse / udredes for"
* code           ^definition = """
  Angiver ønsket undersøgelse eller udredning — svarer til REF01
  felt (6): 'Ønsket undersøgelse/udredes for'. SKAL altid angives
  ved sygehushenvisning.
"""

// ── Klinisk dokumentation (supportingInfo) ────────────────────────────────────
* supportingInfo 0..* MS
* supportingInfo ^short = "Supplerende klinisk dokumentation"
* supportingInfo ^definition = """
  Referencer til supplerende klinisk materiale:
  DiagnosticReport (labsvar, billeddiagnostik),
  DocumentReference (epikrise, PDF-bilag, scannet dokument),
  Observation (enkeltmålinger: blodtryk, BMI, HbA1c),
  MedicationStatement (FMK-reference).
  Svarer til REF01 mulighed for at vedlægge bilag (PDF/JPG).
"""

// ── Videresendelse ────────────────────────────────────────────────────────────
* replaces       0..1
* replaces       only Reference(DkMedComReferral)
* replaces       ^short = "Reference til original henvisning ved videresendelse"
* replaces       ^definition = """
  Anvendes når visitatoren videresender en modtaget henvisning til
  anden modtager. Den nye ServiceRequest sættes med replaces-reference
  til den originale. Svarer til UC 2.5 Videresende.
"""

// ── De 8 MedCom-fraser (extension) ───────────────────────────────────────────
* extension contains DkMedComReferralClinicalNotesExtension named clinicalNotes 0..1 MS
* extension[clinicalNotes] ^short = "Kliniske oplysninger — de 8 MedCom-fraser"
* extension[clinicalNotes] ^definition = """
  Struktureret samling af de 8 vedtagne MedCom-fraser der udgør
  feltet 'Kliniske oplysninger' i REF01 den dynamiske sygehushenvisning:
  cave, anamnese, tidligereRelevantSygehistorie, objektiveFund,
  undersøgelsesresultater, aktuelMedicin, socialeForhold, sagtTilPatienten.
"""

// ── Bemærkninger / fritekst ───────────────────────────────────────────────────
* note           0..* MS
* note           ^short = "Fritekstbemærkninger"
* note           ^definition = """
  Supplerende fritekst. Kan anvendes til yderligere kommentarer
  der ikke passer i de 8 strukturerede fraser.
  Alternativ placement af fraser hvis extension ikke understøttes.
"""

// ── Identifier ────────────────────────────────────────────────────────────────
* identifier     1..* MS
* identifier     ^short = "Henvisnings-ID (UUID anbefalet af MedCom)"
* identifier     ^definition = """
  Unik identifikation af henvisningen. MedCom anbefaler UUID uden bindestreger
  (MedCom kanonisk form) som forløbsnummer. Mindst ét identifier-element kræves.
"""


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Patient
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralPatient
Parent:  $DkCorePatient
Id:      dk-medcom-referral-patient
Title:   "DK MedCom Henvisning — Patient"
Description: "Patient i et MedCom-baseret FHIR-henvisningsforløb. Udleder fra DkCorePatient."

* identifier     1..* MS
* identifier     ^short = "CPR-nummer (obligatorisk)"
* identifier     ^definition = "CPR-nummeret skal angives. OID: urn:oid:1.2.208.176.1.2"

* name           1..* MS
* name           ^short = "Patientens fulde navn"

* birthDate      0..1 MS
* birthDate      ^short = "Fødselsdato"

* gender         0..1 MS
* gender         ^short = "Køn"

* telecom        0..* MS
* telecom        ^short = "Patientens telefonnummer"
* telecom        ^definition = """
  Patientens kontakttelefonnummer. MedCom bemærker at dette felt
  er vigtigt for kommunens mulighed for at kontakte borgeren, og
  at manglende telefonnummer er oplevet som et problem i praksis.
"""

* address        0..* MS
* address        ^short = "Patientens adresse"


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Henviser (PractitionerRole)
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralRequesterRole
Parent:  PractitionerRole
Id:      dk-medcom-referral-requester-role
Title:   "DK MedCom Henvisning — Henviser"
Description: """
  Profil på PractitionerRole der repræsenterer den henvisende behandler.
  Kobler Practitioner (autorisationsId, navn) til Organization (SOR/ydernummer)
  og angiver specialale.
"""

* practitioner   1..1 MS
* practitioner   only Reference($DkCorePractitioner)
* practitioner   ^short = "Den henvisende læge / behandler"

* organization   1..1 MS
* organization   only Reference(DkMedComReferralOrganization)
* organization   ^short = "Afsendende organisation / praksis"

* specialty      0..* MS
* specialty      ^short = "Specialale (SKS-kode)"
* specialty      ^definition = "Afsenders sygehusspeciale eller alment medicinsk speciale (SKS-koder fra SSI)."

* telecom        0..* MS
* telecom        ^short = "Kontakttelefonnummer til henviser"
* telecom        ^definition = """
  Telefonnummer til den afdeling eller praksis der har oprettet
  henvisningen. Anbefales altid angivet i MedComs guidelines.
"""


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Visitator (PractitionerRole)
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralPerformerRole
Parent:  PractitionerRole
Id:      dk-medcom-referral-performer-role
Title:   "DK MedCom Henvisning — Visitator"
Description: """
  Profil på PractitionerRole der repræsenterer den visiterende behandler
  / modtagende enhed. Tildeles til ServiceRequest.performer ved
  visitationsafgørelse.
"""

* practitioner   0..1 MS
* practitioner   only Reference($DkCorePractitioner)
* practitioner   ^short = "Den visiterende behandler (hvis navngiven)"

* organization   1..1 MS
* organization   only Reference(DkMedComReferralOrganization)
* organization   ^short = "Modtagende organisation / afdeling"

* specialty      0..* MS
* specialty      ^short = "Specialale for modtagende enhed"

* telecom        0..* MS
* telecom        ^short = "Kontakttelefonnummer til modtagende afdeling"
* telecom        ^definition = """
  Vises i den dynamiske henvisning som kontaktinformation til
  den afdeling/kommune der modtager henvisningen (pakketabellen).
"""


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Organisation
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralOrganization
Parent:  $DkCoreOrg
Id:      dk-medcom-referral-organization
Title:   "DK MedCom Henvisning — Organisation"
Description: "Organisation (afsendende eller modtagende) i et MedCom-baseret FHIR-henvisningsforløb."

* identifier     1..* MS
* identifier     ^short = "SOR-kode og/eller lokationsnummer"
* identifier     ^definition = """
  SOR-kode (OID: 1.2.208.176.1.1) er primær identifikator.
  Lokationsnummer fra pakketabellen skal angives for modtagende
  sygehusafdeling / kommunal enhed.
"""

* name           1..1 MS
* name           ^short = "Navn på organisation / afdeling"

* telecom        0..* MS
* telecom        ^short = "Kontakttelefonnummer"


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Visitationsafgørelse (Task)
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralTask
Parent:  Task
Id:      dk-medcom-referral-task
Title:   "DK MedCom Visitationsafgørelse"
Description: """
  Profil på Task der repræsenterer visitatorens formelle afgørelse
  om en modtaget henvisning: accept, afvisning eller videresendelse.
  Kobler til den originale ServiceRequest via Task.focus.
"""

* status         1..1 MS
* status         ^short = "Status på visitationsafgørelsen"
* status         ^definition = "requested | in-progress | completed | cancelled"

* intent         1..1 MS
* intent         = #order

* focus          1..1 MS
* focus          only Reference(DkMedComReferral)
* focus          ^short = "Den henvisning afgørelsen vedrører"

* for            0..1 MS
* for            only Reference(DkMedComReferralPatient)
* for            ^short = "Den patient der er henvist"

* owner          0..1 MS
* owner          only Reference(DkMedComReferralPerformerRole)
* owner          ^short = "Den visitator der har truffet afgørelsen"

* reasonCode     0..1 MS
* reasonCode     from DkMedComReferralTaskOutcomeVS (required)
* reasonCode     ^short = "Afgørelsestype: accept | afvisning | videresendelse"

* note           0..* MS
* note           ^short = "Begrundelse for afgørelsen"
* note           ^definition = """
  Visitatorens begrundelse for afgørelsen — obligatorisk ved afvisning.
  Svarer til UC 2.4: 'afvist med faglig eller kapacitetsmæssig begrundelse'.
"""

* authoredOn     1..1 MS
* authoredOn     ^short = "Dato og tidspunkt for afgørelsen"


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Booking (Appointment)
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralAppointment
Parent:  Appointment
Id:      dk-medcom-referral-appointment
Title:   "DK MedCom Booking"
Description: """
  Profil på Appointment der repræsenterer en booking oprettet som
  følge af en positiv visitationsafgørelse. Kobler til ServiceRequest
  via Appointment.basedOn.
"""

* status         1..1 MS
* status         ^short = "Status på booking"
* status         ^definition = "booked | cancelled | noshow | fulfilled"

* basedOn        1..1 MS
* basedOn        only Reference(DkMedComReferral)
* basedOn        ^short = "Den henvisning booking er baseret på"

* participant    1..* MS
* participant    ^short = "Deltagere: patient og behandler"

* start          1..1 MS
* start          ^short = "Starttidspunkt for aftalen"

* end            0..1 MS
* end            ^short = "Sluttidspunkt for aftalen"

* comment        0..1
* comment        ^short = "Eventuel kommentar til bookingen"


// ════════════════════════════════════════════════════════════════════════════════
//  PROFIL: Henvisningsdialog (Communication)
// ════════════════════════════════════════════════════════════════════════════════

Profile: DkMedComReferralDialog
Parent:  Communication
Id:      dk-medcom-referral-dialog
Title:   "DK MedCom Henvisningsdialog"
Description: """
  Profil på Communication der repræsenterer en struktureret besked
  i dialogen om en henvisning — supplement-anmodning, svar, faglig
  afklaring, korrektionsaftale eller alternativ visitation.
  Svarer til MedCom CommunicationRequest / Communication i FHIR.
  Dialog-tråde knyttes via Communication.inResponseTo.
"""

* status         1..1 MS
* status         ^short = "Status på beskeden"
* status         ^definition = "preparation | in-progress | completed | unknown"

* category       1..1 MS
* category       from DkMedComReferralDialogTypeVS (required)
* category       ^short = "Dialogtype"
* category       ^definition = """
  Angiver hvad beskeden handler om: supplement-anmodning,
  supplement-svar, faglig-afklaring, korrektionsaftale eller
  alternativ-visitation.
"""

* subject        1..1 MS
* subject        only Reference(DkMedComReferralPatient)
* subject        ^short = "Den patient dialogen vedrører"

* about          1..* MS
* about          only Reference(DkMedComReferral)
* about          ^short = "Den henvisning dialogen vedrører"

* sender         1..1 MS
* sender         only Reference(DkMedComReferralRequesterRole or
                                DkMedComReferralPerformerRole)
* sender         ^short = "Afsender af beskeden (præcis én)"
* sender         ^definition = """
  En besked har præcis én afsender. Kan være enten henviser eller
  visitator afhængigt af dialogtype.
"""

* recipient      1..* MS
* recipient      only Reference(DkMedComReferralRequesterRole or
                                DkMedComReferralPerformerRole)
* recipient      ^short = "Modtager(e) af beskeden (mindst én)"
* recipient      ^definition = """
  Dialogen inkluderer altid mindst to parter (henviser og visitator).
  Kardinalitet 1..* sikrer at mindst én modtager er angivet.
"""

* inResponseTo   0..* MS
* inResponseTo   only Reference(DkMedComReferralDialog)
* inResponseTo   ^short = "Reference til forudgående besked i tråden"
* inResponseTo   ^definition = """
  Kæder beskeder i en dialog-tråd. Svarer til Communication.inResponseTo
  i FHIR-standardspecifikationen. Giver mulighed for at følge den fulde
  kommunikationshistorik for en given henvisning.
"""

* sent           1..1 MS
* sent           ^short = "Afsendelsestidspunkt"

* payload        0..* MS
* payload        ^short = "Indhold af beskeden"
* payload        ^definition = """
  Beskedens indhold — typisk struktureret tekst (contentString)
  eller reference til vedhæftet DocumentReference (contentReference).
"""

* identifier     0..* MS
* identifier     ^short = "Dialog-ID til trådhåndtering"
* identifier     ^definition = """
  UUID der kobler sammenhørende beskeder i én dialog-tråd.
  Svarer til MedCom korrespondancemeddelelsens kommunikations-identifier.
"""


// ════════════════════════════════════════════════════════════════════════════════
//  EKSEMPEL-INSTANCE: Henvisning med de 8 fraser
// ════════════════════════════════════════════════════════════════════════════════

Instance: ReferralExample
InstanceOf: DkMedComReferral
Title:   "Eksempel — Sygehushenvisning med kliniske oplysninger"
Description: """
  Eksempel på en DkMedComReferral-instance med alle 8 MedCom-fraser
  udfyldt i DkMedComReferralClinicalNotesExtension.
"""
Usage: #example

* identifier[0].system = "urn:ietf:rfc:3986"
* identifier[0].value  = "urn:uuid:a1b2c3d4e5f64a7b8c9d0e1f2a3b4c5d"

* status   = #active
* intent   = #order
* priority = #routine

* category[0].coding[0].system = "http://example.org/fhir/CodeSystem/dk-medcom-referral-category-cs"
* category[0].coding[0].code   = #sygehus
* category[0].coding[0].display = "Sygehushenvisning"

* subject.reference = "Patient/patient-example-01"

* requester.reference = "PractitionerRole/requester-example-01"

* authoredOn = "2026-06-29T09:00:00+02:00"

* reasonCode[0].coding[0].system  = "urn:oid:1.2.208.176.2.31"
* reasonCode[0].coding[0].code    = #K86
* reasonCode[0].coding[0].display = "Kronisk pankreatitis"

* code.coding[0].system  = "http://snomed.info/sct"
* code.coding[0].code    = #168537006
* code.coding[0].display = "Abdominal CT-scanning"

// De 8 MedCom-fraser
* extension[clinicalNotes].extension[cave].valueString = "Penicillinallergi (urticaria). Kontrastmiddel: tidligere mild reaktion — præmediker."

* extension[clinicalNotes].extension[anamnese].valueString = "62-årig mand med tiltagende abdominale smerter de seneste 3 måneder, lokaliseret til epigastriet med udsitring til ryggen. Vægttab på ca. 5 kg. Ingen ikterus. Tidligere alkoholforbrug (ophørt for 5 år siden)."

* extension[clinicalNotes].extension[tidligereRelevantSygehistorie].valueString = "Type 2-diabetes diagnosticeret 2019, behandlet med metformin. Ingen tidligere operationer. Sidst indlagt Regionshospitalet Horsens 2021 med akut pankreatitis."

* extension[clinicalNotes].extension[objektiveFund].valueString = "AT: let påvirket. BT 138/84. Puls 78. Temp 37,1. Abdomen: øm i epigastriet, ingen resistens. Lever og milt ikke palpable. Ingen ascites."

* extension[clinicalNotes].extension[undersøgelsesresultater].valueString = "Amylase 340 U/L (forhøjet). HbA1c 58 mmol/mol. Lipase 410 U/L. Ultralyd abdomen 22.06.2026: dilateret ductus pancreaticus, ingen sten. Bilirubin normal."

* extension[clinicalNotes].extension[aktuelMedicin].valueString = "Metformin 1000 mg x 2 (type 2-DM). Pantoprazol 40 mg x 1 (GER). Paracetamol 1g p.n. FMK ajourført 28.06.2026."

* extension[clinicalNotes].extension[socialeForhold].valueString = "Pensioneret, bor alene. Ingen tolkebehov. Kører selv. Har pårørende (datter) som kan ledsage. Ingen aktuel sygemelding."

* extension[clinicalNotes].extension[sagtTilPatienten].valueString = "Patienten er informeret om, at der er behov for CT-scanning og gastroenterologisk vurdering. Forstår og accepterer henvisning. Er informeret om at skulle forvente kontakt fra sygehuset inden for 2 uger."
