// ╔══════════════════════════════════════════════════════════════════════════════╗
// ║  DK MedCom Henvisning — Logisk model i FHIR Shorthand (FSH)                ║
// ║  Udtrykt som FHIR Logical Models (ikke profiler på FHIR-ressourcer)        ║
// ║  Inkluderer de 8 vedtagne MedCom-fraser med FHIR-ressource-mapping         ║
// ║  Baseret på MedCom REF01 / FHIR R4 / DK Core                              ║
// ╚══════════════════════════════════════════════════════════════════════════════╝

// ── Aliases ──────────────────────────────────────────────────────────────────
Alias: $SOR   = urn:oid:1.2.208.176.1.1
Alias: $CPR   = urn:oid:1.2.208.176.1.2
Alias: $SCT   = http://snomed.info/sct
Alias: $LOINC = http://loinc.org
Alias: $ICD10 = urn:oid:1.2.208.176.2.4.12


// ════════════════════════════════════════════════════════════════════════════════
//  CODESYSTEMS
// ════════════════════════════════════════════════════════════════════════════════

CodeSystem: DkMedComReferralCategoryCS
Id:         dk-medcom-referral-category-cs
Title:      "DK MedCom Henvisningskategori"
Description: "Kategorier for MedCom-baserede henvisninger svarende til pakketabellens hoveddimensioner."
* #sygehus                "Sygehushenvisning"         "Generel eller pakkebaseret sygehushenvisning (REF01)"
* #speciallaege           "Speciallægehenvisning"     "Henvisning til praktiserende speciallæge (REF06)"
* #kommune-forebyggelse   "Kommunal forebyggelse"     "Henvisning til kommunens forebyggelsestilbud (XREF15)"
* #kommune-akut           "Kommunal akutfunktion"     "Henvisning til kommunal akutfunktion (XREF22)"
* #billeddiagnostik       "Billeddiagnostik"          "Billeddiagnostisk henvisning (REF02)"
* #psykolog               "Psykologhenvisning"        "Henvisning til praktiserende psykolog (REF10)"


CodeSystem: DkMedComReferralPriorityCS
Id:         dk-medcom-referral-priority-cs
Title:      "DK MedCom Hastegrad"
Description: "Hastegrader svarende til REF01 indkaldelsesprioritering."
* #rutine                 "Rutine"                    "Ikke-akut, planlagt forløb"
* #hoejt-prioriteret      "Højt prioriteret"          "Skal ses inden for kortere frist (pakkeforløb)"
* #akut                   "Akut"                      "Akut henvisning — kontakt samme dag"


CodeSystem: DkMedComReferralDialogTypeCS
Id:         dk-medcom-referral-dialog-type-cs
Title:      "DK MedCom Dialogtype"
Description: "Typer af strukturerede beskeder i dialogen om en henvisning."
* #supplement-anmodning   "Anmodning om supplement"   "Visitator anmoder om supplerende kliniske oplysninger"
* #supplement-svar        "Svar på supplement"        "Henviser besvarer supplement-anmodning"
* #faglig-afklaring       "Faglig afklaring"          "Gensidig faglig dialog om indikation eller egnethed"
* #korrektionsaftale      "Korrektionsaftale"         "Dialog om rettelse af fejl i afsendt henvisning"
* #alternativ-visitation  "Alternativ visitation"     "Dialog om alternativt tilbud ved afvisning"


CodeSystem: DkMedComReferralOutcomeCS
Id:         dk-medcom-referral-outcome-cs
Title:      "DK MedCom Visitationsafgørelse"
Description: "Udfald af visitatorens formelle afgørelse om en modtaget henvisning."
* #accept                 "Accept"                    "Henvisningen er accepteret og forløb oprettes"
* #afvisning              "Afvisning"                 "Henvisningen er afvist med begrundelse"
* #videresendelse         "Videresendelse"            "Henvisningen videresendes til anden modtager"
* #afventer-supplement    "Afventer supplement"       "Afgørelse afventer supplerende oplysninger"


CodeSystem: DkMedComReferralRoleCS
Id:         dk-medcom-referral-role-cs
Title:      "DK MedCom Behandlerrolle"
Description: "Behandlerrollens funktion i et henvisningsforløb."
* #henviser               "Henviser"                  "Den behandler der opretter og afsender henvisningen"
* #visitator              "Visitator"                 "Den behandler der modtager og triagerer henvisningen"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Patient
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComPatientModel
Id:      dk-medcom-patient-model
Title:   "DK MedCom Patient (logisk model)"
Description: """
  Logisk model for den patient der er genstand for en MedCom-baseret
  FHIR-henvisning. Svarer til DkCorePatient i FHIR-implementeringen.
"""
Characteristics: #can-be-target

* cpr              1..1 string     "CPR-nummer. Obligatorisk identifikator for patienten. FHIR: Patient.identifier (system: urn:oid:1.2.208.176.1.2) "
* navn             1..1 string     "Patientens fulde navn. FHIR: Patient.name (HumanName)"
* foedselsdato     0..1 date     "Fødselsdato. FHIR: Patient.birthDate"
* koen             0..1 code     "Køn. FHIR: Patient.gender"
* telefon          0..* string     "Patientens telefonnummer. Vigtigt for at modtagende enhed kan kontakte borgeren. FHIR: Patient.telecom"
* adresse          0..1 string     "Patientens adresse. FHIR: Patient.address"

// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Behandler
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComBehandlerModel
Id:      dk-medcom-behandler-model
Title:   "DK MedCom Behandler (logisk model)"
Description: """
  Logisk model for en behandler i et MedCom-baseret FHIR-henvisningsforløb.
  Dækker både rollen som Henviser og Visitator via rolle-attributten.
  FHIR: Practitioner + PractitionerRole.
"""
Characteristics: #can-be-target

* autorisationsId  1..1 string     "Autorisationsidentifikator (sundhedsstyrelsens autorisationsregister). FHIR: Practitioner.identifier"
* navn             1..1 string     "Behandlerens fulde navn. FHIR: Practitioner.name"
* rolle            1..1 code     "Angiver om behandleren optræder som henviser eller visitator i det konkrete forløb. FHIR: PractitionerRole.code (DkMedComReferralRoleCS)"
* speciale         0..1 code     "Behandlerens speciale (SKS-kode). FHIR: PractitionerRole.specialty"
* organisation     1..1 Reference(DkMedComOrganisationModel)     "Den organisation behandleren er tilknyttet. FHIR: PractitionerRole.organization"
* telefon          0..1 string     "Kontakttelefonnummer. FHIR: PractitionerRole.telecom"



// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Organisation
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComOrganisationModel
Id:      dk-medcom-organisation-model
Title:   "DK MedCom Organisation (logisk model)"
Description: """
  Logisk model for en afsendende eller modtagende organisation
  i et MedCom-baseret FHIR-henvisningsforløb.
  FHIR: Organization (DkCoreOrganization).
"""
Characteristics: #can-be-target

* sorKode          1..1 string     "SOR-kode (OID: 1.2.208.176.1.1). Primær identifikator. FHIR: Organization.identifier"
* lokationsnummer  0..1 string     "EAN/GLN-lokationsnummer fra pakketabellen for modtagende sygehusafdeling eller kommunal enhed. FHIR: Organization.identifier (system: urn:oid:1.3.88)"
* navn             1..1 string     "Navn på organisation / afdeling. FHIR: Organization.name"
* type             1..1 code        "Type: {afsender | modtager}. FHIR: Organization.type"
* telefon          0..1 string      "Kontakttelefonnummer. FHIR: Organization.telecom"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: KliniskeOplysninger — de 8 MedCom-fraser
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComKliniskeOplysningerModel
Id:      dk-medcom-kliniske-oplysninger-model
Title:   "DK MedCom Kliniske oplysninger — 8 fraser (logisk model)"
Description: """
  Logisk model for de 8 vedtagne MedCom-fraser der udgør 'Kliniske
  oplysninger' i en dynamisk sygehushenvisning (REF01).
  Hvert logisk element mappes til en dedikeret FHIR-ressource —
  der er ingen brug for extensions, da FHIR har ressourcer der præcist
  modellerer hvert begreb.
  Alle elementer er valgfrie (0..1) på logisk niveau og refereres
  fra DkMedComReferralModel.supportingInfo.
"""
* cave 1..1 AllergyIntolerance "Overfølsomhedsreaktioner, kendte allergier eller andre risikofaktorer der kan have betydning for behandlingen.     Inkluderer medicinallergier, kontrastmiddelreaktioner mv.     FHIR: AllergyIntolerance      .patient → Patient       .code    → allergen (SNOMED CT / ATC) .reaction.manifestation → klinisk reaktion .clinicalStatus → active | inactive | resolved .verificationStatus → confirmed | unconfirmed"
* cave ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* cave ^mapping[=].map = "AllergyIntolerance"
* cave ^mapping[=].comment = "Cave svarer til AllergyIntolerance-ressourcen. Refereres via ServiceRequest.supportingInfo"
* anamnese 1..1 Condition "Aktuel sygehistorie: patientens beskrivelse af den kliniske problemstilling der begrunder henvisningen — symptomer, debut, forløb og sværhedsgrad. FHIR: Condition  .subject     → Patient  .code        → diagnose (ICD-10 / SNOMED CT)  .clinicalStatus → active  .category    → encounter-diagnosis | problem-list-item .note        → fritekstbeskrivelse af anamnesen .onsetDateTime / .onsetPeriod → symptomdebut"
* anamnese ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* anamnese ^mapping[=].map = "Condition"
* anamnese ^mapping[=].comment = "Anamnese svarer til Condition med category = problem-list-item eller encounter-diagnosis"
* tidligereRelevantSygehistorie 1..1 Condition "(Condition or Procedure)Tidligere indlæggelser, operationer, relevante kroniske sygdomme og undersøgelsesresultater med relevans for den aktuelle henvisning (hvornår og hvor). FHIR: Condition (kroniske diagnoser) + Procedure (operationer / procedurer)       Condition.clinicalStatus → inactive | resolved       Condition.category       → problem-list-item       Procedure.status         → completed       Procedure.code           → procedurekode (SKS / SNOMED CT)       Procedure.performedDateTime → dato for indgreb"
* tidligereRelevantSygehistorie ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* tidligereRelevantSygehistorie ^mapping[=].map = "Condition | Procedure"
* tidligereRelevantSygehistorie ^mapping[=].comment = "Aktive kroniske lidelser som Condition, afsluttede indgreb som Procedure"
* objektiveFund 1..1 Observation "Objektive fund ved klinisk undersøgelse: vitale parametre, organstatus og relevante kliniske observationer (i telegramstil). Typisk: BT, puls, temperatur, respirationsfrekvens, abdominalia, palpationsfund mv. FHIR: Observation  .subject   → Patient  .code      → LOINC / SNOMED CT (type observation)  .value[x]  → målt værdi (Quantity / string / CodeableConcept)  .effectiveDateTime → tidspunkt for undersøgelsen  .category  → [exam] (http://terminology.hl7.org/CodeSystem/observation-category)"
* objektiveFund ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* objektiveFund ^mapping[=].map = "Observation (category: exam)"
* objektiveFund ^mapping[=].comment = "Én Observation pr. klinisk fund — fx blodtryk, puls, temperatur. Fritekstfund som Observation.note"
* undersoegelsesresultater 1..1 Observation "(Observation or DiagnosticReport)Relevante parakliniske undersøgelsesresultater der understøtter henvisningsindikationen: blodprøver, EKG, billeddiagnostik mv. Enkeltresultater som Observation; samlede rapporter (røntgen, patologi, mikrobiologi) som DiagnosticReport med Observation-result. FHIR: Observation (enkeltresultater — fx HbA1c, kreatinin)   + DiagnosticReport (samlede rapporter)  DiagnosticReport.result → [Observation]  DiagnosticReport.presentedForm → PDF-bilag (base64)  Observation.code       → LOINC / NPU  Observation.value[x]   → målt værdi + enhed  Observation.referenceRange → referenceinterval"
* undersoegelsesresultater ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* undersoegelsesresultater ^mapping[=].map = "Observation | DiagnosticReport"
* undersoegelsesresultater ^mapping[=].comment = "Enkeltresultater som Observation (LOINC/NPU). Samlede svar (røntgen, patologi) som DiagnosticReport"
* socialeForhold 1..1 Observation "Relevante sociale forhold og særlige patientbehov: sygemelding, boligsituation, pårørende. Særlige behov: tolkebehov (sprog), hjælpemidler, mobilitetsbegrænsninger, transportforhold mv. FHIR: Observation  .code     → LOINC 71482-7 (social history) / SNOMED CT  .category → [social-history]  .value[x] → CodeableConcept / string (fx tolkesprog)  .note     → fritekst om særlige behov"
* socialeForhold ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* socialeForhold ^mapping[=].map = "Observation (category: social-history)"
* socialeForhold ^mapping[=].comment = "Social history-observationer. Tolkebehov som Observation.valueCodeableConcept med sprogkode"
* sagtTilPatienten 1..1 Communication "Oplysninger om hvad der er sagt til patienten og evt. pårørende om diagnose, prognose, videre forløb og forventet ventetid. Svarer til journalnotatet 'sagt til patienten'. FHIR: Communication  .subject   → Patient  .sender    → Practitioner (den der har informeret patienten)  .payload.contentString → hvad der er sagt  .sent      → tidspunkt for patientinformation  .category  → [notification]  .status    → completed"
* sagtTilPatienten ^mapping[+].identity = "kliniske-oplysninger-fhir-mapping"
* sagtTilPatienten ^mapping[=].map = "Communication"
* sagtTilPatienten ^mapping[=].comment = "Communication med category notification. Én Communication-instans pr. patientsamtale"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Henvisning (rodentitet)
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComReferralModel
Id:      dk-medcom-referral-model
Title:   "DK MedCom Henvisning (logisk model)"
Description: """
  Logisk model for en dansk MedCom-baseret FHIR-henvisning (rodentitet).
  Udgangspunkt: MedCom REF01 / XREF01 og pakketabellen.
  FHIR-implementering: ServiceRequest (DK MedCom Referral profile).
"""
* henvisningsId        1..1 string "Unik identifikation (UUID). FHIR: ServiceRequest.identifier"
* status               1..1 code "Status på henvisningen i livscyklussen. FHIR: ServiceRequest.status Koder: proposed | active | on-hold | revoked | completed"
* hastegrad            1..1 code "Indkaldelsesprioritering. FHIR: ServiceRequest.priority Koder: routine | urgent | asap | stat"
* kategori             1..1 code "Henvisningstype svarende til pakketabellens dimension. FHIR: ServiceRequest.category (DkMedComReferralCategoryCS)"
* oensketYdelse         1..1 code "Hvad patienten skal udredes for / ønsket undersøgelse. Svarer til REF01 felt 6. FHIR: ServiceRequest.code (SNOMED CT / SKS)"
* henvisningsdato      1..1 dateTime "Dato for oprettelse / afsendelse. FHIR: ServiceRequest.authoredOn"
* erstatterHenvisning  0..1 Reference(DkMedComReferralModel) "Reference til original henvisning ved videresendelse. FHIR: ServiceRequest.replaces"
* patient              1..1 Reference(DkMedComPatientModel) "Den patient der viderehenvises. FHIR: ServiceRequest.subject"
* henviser             1..1 Reference(DkMedComBehandlerModel)   "Den behandler der opretter og afsender. FHIR: ServiceRequest.requester"
* afsenderOrganisation 1..1 Reference(DkMedComOrganisationModel) "Afsendende organisation. FHIR: ServiceRequest.requester (via PractitionerRole.organization)"
* visitator            0..1 Reference(DkMedComBehandlerModel)   "Visiterende behandler / modtagende enhed ved tildeling. FHIR: ServiceRequest.performer"
* modtagerOrganisation 0..1 Reference(DkMedComOrganisationModel) "Modtagende organisation. FHIR: ServiceRequest.performer (via PractitionerRole.organization)"
* kliniskeOplysninger  0..8 Reference(DkMedComKliniskeOplysningerModel) "De 8 vedtagne MedCom-fraser for kliniske oplysninger. FHIR: ServiceRequest.supportingInfo → [AllergyIntolerance, Condition, Procedure, Observation, DiagnosticReport, MedicationStatement, Communication]"""
* supplererendeDokumentation 0..* Reference(DkMedComKliniskDokumentationModel) "Yderligere klinisk dokumentation (bilag): epikriser, billeder, PDF-dokumenter. FHIR: ServiceRequest.supportingInfo → [DocumentReference, DiagnosticReport (presentedForm)]"
* dialog               0..* Reference(DkMedComDialogModel) "Kommunikation i forbindelse med henvisningen. FHIR: Communication.about → ServiceRequest"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Klinisk dokumentation (bilag)
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComKliniskDokumentationModel
Id:      dk-medcom-klinisk-dokumentation-model
Title:   "DK MedCom Klinisk dokumentation (logisk model)"
Description: """
  Logisk model for supplerende klinisk dokumentation tilknyttet en
  MedCom-baseret FHIR-henvisning — fx epikrise, PDF-bilag, røntgenbillede.
  FHIR: DocumentReference / DiagnosticReport.presentedForm
"""
Characteristics: #can-be-target

* dokumentId       1..1 string "Unik identifikation af dokumentet. FHIR: DocumentReference.identifier"
* type             1..1 code "Dokumenttype. FHIR: DocumentReference.type (LOINC). Eksempler: epikrise, laboratoriesvar, billeddiagnostik, samtykkeerklæring"
* dato             1..1 dateTime "Dato for dokumentet. FHIR: DocumentReference.date"
* format           0..1 code    "Filformat: PDF, CDA, FHIR, JPEG. FHIR: DocumentReference.content.attachment.contentType"
* indhold          1..1 string  "URL eller base64-kodet indhold. FHIR: DocumentReference.content.attachment.url / .data"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Visitationsafgørelse
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComVisitationsafgørelseModel
Id:      dk-medcom-visitationsafgoerelse-model
Title:   "DK MedCom Visitationsafgørelse (logisk model)"
Description: """
  Logisk model for visitatorens formelle afgørelse om en modtaget
  MedCom-baseret FHIR-henvisning.
  FHIR: Task
"""
Characteristics: #can-be-target

* afgoerelsesId     1..1 string "Unik identifikation. FHIR: Task.identifier"
* status           1..1 code     "Workflowstatus for afgørelsen. FHIR: Task.status Koder: requested | in-progress | completed | cancelled"
* afgoerelsesType   1..1 code "Typen af afgørelse: accept, afvisning eller videresendelse. FHIR: Task.reasonCode (DkMedComReferralOutcomeCS)"
* begrundelse      0..1 string   "Begrundelse — obligatorisk ved afvisning. FHIR: Task.note"
* afgoerelsesdato   1..1 dateTime "Dato og tidspunkt for afgørelsen. FHIR: Task.authoredOn"
* vedroererHenvisning 1..1 Reference(DkMedComReferralModel) "Den henvisning afgørelsen vedrører. FHIR: Task.focus"
* truffetAf        1..1 Reference(DkMedComBehandlerModel) "Den visitator der har truffet afgørelsen. FHIR: Task.owner"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Booking
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComBookingModel
Id:      dk-medcom-booking-model
Title:   "DK MedCom Booking (logisk model)"
Description: """
  Logisk model for en booking oprettet som følge af en positiv
  visitationsafgørelse for en MedCom-baseret FHIR-henvisning.
  FHIR: Appointment
"""
Characteristics: #can-be-target

* bookingId        1..1 string "Unik identifikation. FHIR: Appointment.identifier"
* status           1..1 code  "Status: booked | cancelled | noshow | fulfilled. FHIR: Appointment.status"
* starttidspunkt   1..1 dateTime "Starttidspunkt for aftalen. FHIR: Appointment.start"
* varighed         0..1 positiveInt "Varighed i minutter. FHIR: Appointment.minutesDuration"
* baseresPaaHenvisning 1..1 Reference(DkMedComReferralModel) "Den henvisning booking er baseret på. FHIR: Appointment.basedOn"
* patient          1..1 Reference(DkMedComPatientModel) "Den patient der er booket. FHIR: Appointment.participant (actor → Patient)"
* modtagerOrganisation 1..1 Reference(DkMedComOrganisationModel) "Den organisation bookingen er hos. FHIR: Appointment.participant (actor → Location/Organization)"


// ════════════════════════════════════════════════════════════════════════════════
//  LOGISK MODEL: Henvisningsdialog
// ════════════════════════════════════════════════════════════════════════════════

Logical: DkMedComDialogModel
Id:      dk-medcom-dialog-model
Title:   "DK MedCom Henvisningsdialog (logisk model)"
Description: """
  Logisk model for en struktureret besked i dialogen om en MedCom-baseret
  FHIR-henvisning. Dialogen kan bestå af en kæde af beskeder via
  inResponseTo-reference. Dialog inkluderer altid mindst to parter.
  FHIR: Communication / CommunicationRequest
"""
Characteristics: #can-be-target

* dialogId         1..1 string "Unik identifikation. FHIR: Communication.identifier"
* type             1..1 code     "Dialogtype. FHIR: Communication.category (DkMedComReferralDialogTypeCS) Koder: supplement-anmodning | supplement-svar | faglig-afklaring | korrektionsaftale | alternativ-visitation"
* emne             0..1 string "Emnebeskrivelse. FHIR: Communication.topic"
* indhold          1..1 string "Beskedens indhold. FHIR: Communication.payload.contentString"
* status           1..1 code "Status: preparation | in-progress | completed. FHIR: Communication.status"
* tidspunkt        1..1 dateTime "Afsendelsestidspunkt. FHIR: Communication.sent"
* vedroererHenvisning 1..1 Reference(DkMedComReferralModel) "Den henvisning dialogen vedrører. FHIR: Communication.about"
* afsender         1..1 Reference(DkMedComBehandlerModel) "Præcis én afsender. FHIR: Communication.sender"
* modtager         1..* Reference(DkMedComBehandlerModel) "Mindst én modtager — dialogen involverer altid begge parter (henviser og visitator). FHIR: Communication.recipient [1..*]"
* svarPaa           0..1 Reference(DkMedComDialogModel) "Reference til forudgående besked i tråden. FHIR: Communication.inResponseTo "
